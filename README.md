Step 1: Enable GCP APIs

  Enables required GCP services like Cloud Build, Cloud Deploy, Artifact Registry, and Cloud Run.

Step 2: Create a trigger and connect Github repository

Step 3: Crate Docketfile

Step 4: Cloud Build (cloudbuild.yaml)

  Builds Docker image, pushes it to Artifact Registry, and creates a release in Cloud Deploy.

Step 5: Delivery Pipeline and Targets (clouddeploy.yaml)

  Defines deployment flow: dev → prod.
  Defines environments (dev and prod) and where deployments happen (Cloud Run region).

Step 6: Apply Pipeline

  You need to run the gcloud commnad before you push the change.
  gcloud deploy apply --file=clouddeploy.yaml --region=us-east1
  Registers pipeline and targets using gcloud deploy apply.
  This is to be run manually only once. not required for every deployment

Step 7: Cloud Run Services 

  Initial creation of dev and prod services.
  cloud deploy needs services to be available. It will not create automatically.

Step 8: Skaffold Configuration (scaffold.yaml)

  Defines deployment method (Cloud Run) and maps profiles to environments.
  Skaffold is the deployment engine used by Cloud Deploy
  skaffold.yaml tells Cloud Deploy how to deploy and which service definition to use for each environment (dev vs prod)

  Take service YAML → apply it → deploy to Cloud Run
  
  Target: dev
  	→ Skaffold picks profile: dev
  	→ Uses service-dev.yaml
  	→ Deploys to my-service-dev

Step 9: Service Definitions (service.yaml)

  Separate YAML files for dev and prod services with placeholder image.
  This file defines the Cloud Run service, and my-app is a placeholder replaced with the real Docker image during deployment
  service name
  spec template
  containers
  image

Step 10: Run Pipeline

  Triggered via GitHub to build, push, and create release.

Step 11: Cloud Deploy Execution

  Automatically deploys to dev, waits for approval, then deploys to prod.

Step 12: Promote to Prod

  Manual approval step to move from dev to prod.

Key Concept:

  Image placeholder (my-app) is replaced with actual Docker image during deployment.
  
  Cloud Build →
     create release →
        Cloud Deploy →
  
           → Target: dev
                      ↓
                 Skaffold uses profile: dev
                      ↓
                 service-dev.yaml applied
                      ↓
                 Cloud Run → my-service-dev
  
           → Approval required
  
           → Target: prod
                      ↓
                 Skaffold uses profile: prod
                      ↓
                 service-prod.yaml applied
                      ↓
                 Cloud Run → my-service-prod

