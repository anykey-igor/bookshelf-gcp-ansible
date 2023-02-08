#!/bin/bash

export TF_VAR_project_id=gcp-2022-bookshelf-ianikeiev1
export TF_VAR_user_pass=bookshelf-pass

SERVICE_ACCOUNT=terraform-sa
SA_ROLES=("roles/source.admin" "roles/iam.serviceAccountUser" "roles/iam.serviceAccountAdmin" "roles/iam.serviceAccountTokenCreator" "roles/compute.admin" "roles/storage.admin" "roles/cloudsql.admin" "roles/pubsub.admin" "roles/servicenetworking.networksAdmin" "roles/resourcemanager.projectIamAdmin")  #"roles/editor"
DESCRIPTION_SA=ServiceAccountTerraform
DISPLAY_SA=terraform-sa
CREDENTIAL_SA_JSON=terraform-sa.json

BUCKET_NAME=tf-bookshelf-ianikeiev
BUCKET_ROLES=("roles/storage.legacyBucketOwner" "roles/storage.legacyObjectOwner")
LOCATION=EU
STORAGE_CLASS=STANDARD
STATE_STORAGE=--uniform-bucket-level-access

INFRA_REPO=Infra
ANSIBLE_REPO=InstanceConfig
APP_REPO=bookshelfApp

#[START Project]
if gcloud projects list --filter="project_id:$PROJECT_ID" --format="table(project_id)" | grep -q $PROJECT_ID; then
  echo "This project present. Set $PROJECT_ID as current"
  gcloud config set project $PROJECT_ID
  echo "Set up $PROJECT_ID as a current project: Done"
else
  echo "Need create project - $PROJECT_ID"
  gcloud projects create $PROJECT_ID
  echo "Set up $PROJECT_ID as a current project: Done"
fi
#[END Project]

#[START Billing]
echo "Get billing ACCOUNT ID..."
# shellcheck disable=SC2006
BILLING_ACCOUNT=`gcloud alpha billing accounts list --filter=open=true --format='value(ACCOUNT_ID)'`
echo "Link Binding Project with Billing Account ID..."
gcloud beta billing projects link $PROJECT_ID --billing-account="$BILLING_ACCOUNT"
echo "Done"
#[END Billing]


echo "Check available Service Account and binding roles..."
if gcloud iam service-accounts list --filter="displayName:$SERVICE_ACCOUNT" --format="table(displayName)" | grep -q $SERVICE_ACCOUNT; then
  echo "Service Account - $SERVICE_ACCOUNT: present"
  for i in ${SA_ROLES[*]}; do
    # shellcheck disable=SC2016
    gcloud projects get-iam-policy $PROJECT_ID --flatten='bindings[].members' --format='table(bindings.role)' --filter='bindings.members:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com' | grep -q "$i"
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
      echo "Present role $i for Service Account: $SERVICE_ACCOUNT"
    else
      gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" --role="$i"
    fi
  done
  echo "Get credential file for Service Account: $SERVICE_ACCOUNT"
  gcloud iam service-accounts keys create $CREDENTIAL_SA_JSON --iam-account=$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com
else
  echo "SA $SERVICE_ACCOUNT absent. Need to create $SERVICE_ACCOUNT"
  gcloud iam service-accounts create $SERVICE_ACCOUNT --description="$DESCRIPTION_SA" --display-name="$DISPLAY_SA"
  for i in ${SA_ROLES[*]}; do
    # shellcheck disable=SC2016
    gcloud projects get-iam-policy $PROJECT_ID --flatten='bindings[].members' --format='table(bindings.role)' --filter='bindings.members:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com' | grep -q "$i"
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
      echo "Present role $i for Service Account: $SERVICE_ACCOUNT"
    else
      gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" --role="$i"
    fi
  done
  echo "Get credential file for Service Account: $SERVICE_ACCOUNT"
  gcloud iam service-accounts keys create $CREDENTIAL_SA_JSON --iam-account=$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com
fi
mv $CREDENTIAL_SA_JSON "$HOME"/.config/gcloud/$CREDENTIAL_SA_JSON
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/$CREDENTIAL_SA_JSON
#[END SERVICE Account]

#[START Create Storage Bucket - remote state]
gcloud storage buckets create gs://$BUCKET_NAME --project=$PROJECT_ID --default-storage-class=$STORAGE_CLASS --location=$LOCATION $STATE_STORAGE
gsutil versioning set on gs://$BUCKET_NAME
#[START SERVICE Account for Terraform and get json key]



gcloud source repos create $INFRA_REPO
gcloud source repos create $ANSIBLE_REPO
gcloud source repos create $APP_REPO

#[START ENABLE API]
echo "Start Enable API..."
gcloud services enable compute.googleapis.com cloudresourcemanager.googleapis.com servicenetworking.googleapis.com sqladmin.googleapis.com sourcerepo.googleapis.com iam.googleapis.com pubsub.googleapis.com trafficdirector.googleapis.com
echo "Done"
#[END ENABLE API]

#[END Create Storage Bucket]
for role in ${BUCKET_ROLES[*]}; do
  gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME --member=serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com --role="$role"
done


#[START Create Source Repository Infra - Terraform; InstanceConfig - Anisible; bookshelfApp - FlaskApplication]

#gcloud source repos set-iam-policy REPOSITORY_NAME POLICY_FILE
gcloud source repos clone $INFRA_REPO --project=$PROJECT_ID
## shellcheck disable=SC2154
cp -r ../Source/Infra/* $INFRA_REPO
# shellcheck disable=SC2164
cd $INFRA_REPO
git add .
git commit -m "add files"
git push -u origin master
# shellcheck disable=SC2103
cd ..
pwd
gcloud source repos clone $ANSIBLE_REPO --project=$PROJECT_ID
## shellcheck disable=SC2154
cp -r ../Source/InstanceConfig/* $ANSIBLE_REPO
# shellcheck disable=SC2164
cd $ANSIBLE_REPO
git add .
git commit -m "add files"
git push -u origin master
cd ..
#rm -rf $ANSIBLE_REPO
pwd
gcloud source repos clone $APP_REPO --project=$PROJECT_ID
## shellcheck disable=SC2154
cp -r ../Source/bookshelfApp/* $APP_REPO
# shellcheck disable=SC2164
cd $APP_REPO
git add .
git commit -m "add files"
git push -u origin master
cd ..
#rm -rf $APP_REPO
export -p | grep TF_VAR
echo
export -p | grep GOOGLE
# shellcheck disable=SC2164
cd $INFRA_REPO

terraform init
terraform apply -auto-approve