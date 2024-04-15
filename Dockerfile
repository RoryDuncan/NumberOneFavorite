steps:
  - name: gcr.io/k8s-skaffold/pack
    env:
      - GOOGLE_ENTRYPOINT=$_ENTRYPOINT
    args:
      - build
      - >-
        $_AR_HOSTNAME/$PROJECT_ID/cloud-run-source-deploy/$REPO_NAME/$_SERVICE_NAME:$COMMIT_SHA
      - '--builder=gcr.io/buildpacks/builder:v1'
      - '--network=cloudbuild'
      - '--path=.'
      - '--env=GOOGLE_ENTRYPOINT'
    id: Buildpack
    entrypoint: pack
  - name: gcr.io/cloud-builders/docker
    args:
      - push
      - >-
        $_AR_HOSTNAME/$PROJECT_ID/cloud-run-source-deploy/$REPO_NAME/$_SERVICE_NAME:$COMMIT_SHA
    id: Push
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk:slim'
    args:
      - run
      - services
      - update
      - $_SERVICE_NAME
      - '--platform=managed'
      - >-
        --image=$_AR_HOSTNAME/$PROJECT_ID/cloud-run-source-deploy/$REPO_NAME/$_SERVICE_NAME:$COMMIT_SHA
      - >-
        --labels=managed-by=gcp-cloud-build-deploy-cloud-run,commit-sha=$COMMIT_SHA,gcb-build-id=$BUILD_ID,gcb-trigger-id=$_TRIGGER_ID
      - '--region=$_DEPLOY_REGION'
      - '--quiet'
    id: Deploy
    entrypoint: gcloud
images:
  - >-
    $_AR_HOSTNAME/$PROJECT_ID/cloud-run-source-deploy/$REPO_NAME/$_SERVICE_NAME:$COMMIT_SHA
options:
  substitutionOption: ALLOW_LOOSE
  logging: CLOUD_LOGGING_ONLY
substitutions:
  _ENTRYPOINT: node build
  REPO_NAME: numberonefavorite
  _TRIGGER_ID: eb028846-d118-4956-a689-25fb13b7b5fe
  _DEPLOY_REGION: us-west1
  _AR_HOSTNAME: us-west1-docker.pkg.dev
  _PLATFORM: managed
  _SERVICE_NAME: numberonefavorite-cicd-test
tags:
  - gcp-cloud-build-deploy-cloud-run
  - gcp-cloud-build-deploy-cloud-run-managed
  - numberonefavorite-cicd-test
