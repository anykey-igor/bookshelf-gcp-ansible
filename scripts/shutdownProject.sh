#!/bin/bash

PROJECT_ID=gcp-2022-bookshelf-ianikeiev1
SERVICE_ACCOUNT=terraform-sa
SA_ROLES=("roles/source.admin" "roles/iam.serviceAccountUser" "roles/iam.serviceAccountAdmin" "roles/iam.serviceAccountTokenCreator" "roles/compute.admin" "roles/storage.admin" "roles/cloudsql.admin" "roles/pubsub.admin" "roles/servicenetworking.networksAdmin" "roles/resourcemanager.projectIamAdmin")  #"roles/editor"
CREDENTIAL_SA_JSON=terraform-sa.json
BUCKET_NAME=tf-bookshelf-ianikeiev
BUCKET_ROLES=("roles/storage.legacyBucketOwner" "roles/storage.legacyObjectOwner")

terraform destroy -auto-approve
cd ..
#[START Delete Source Repository]
# shellcheck disable=SC2207
REPOS=($(gcloud source repos list --filter="Name:'$PROJECT_ID'" --format="value(name)"))
for i in ${REPOS[*]}; do
    gcloud source repos list --filter="name:'$PROJECT_ID'" --format="value(name)" | grep -q "$i"
    if [ $? -eq 0 ]; then
      EXECUTE=`gcloud source repos delete "$i" --quiet`
      echo "Deleted Repo Name: $i$EXECUTE. Done"
    fi
  done
#[END Delete Source Repository]

for role in ${BUCKET_ROLES[*]}; do
  gcloud storage buckets remove-iam-policy-binding gs://$BUCKET_NAME --member=serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com --role="$role"
  #gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME --member=serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com --role="$role"
  #gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME --member=serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com --role=roles/storage.legacyObjectOwner
done

#[START Delete Storage Bucket]
gcloud storage rm --recursive gs://$BUCKET_NAME
gcloud storage buckets delete gs://$BUCKET_NAME
#[END Delete Storage Bucket]



#[START REMOVE SERVICE ACCOUNT AND IAM POLICY BINDING]
#gcloud iam service-accounts delete $SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com
if gcloud iam service-accounts list --filter="displayName:$SERVICE_ACCOUNT" --format="table(displayName)" | grep -q $SERVICE_ACCOUNT; then
  for role in ${SA_ROLES[*]}; do
    gcloud projects remove-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com" --role="$role"
  done
  #gcloud iam service-accounts delete terraform-sa@try-bookshelf-ianikeiev.iam.gserviceaccount.com --quiet
  echo "Delete Service Account $SERVICE_ACCOUNT"
  gcloud iam service-accounts delete $SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com --quiet
else
  echo "Servie Account Absent"
fi
#[END REMOVE IAM POLICY BINDING]
#gcloud services disable $PROJECT_API

#rm $CREDENTIAL_SA_JSON
rm $HOME/.config/gcloud/$CREDENTIAL_SA_JSON
#Unlink Billing from Project
#gcloud beta billing projects unlink $PROJECT_ID
rm -rf Infra/
