REM Setup environment variables
SET RESOURCE_GROUP=acs-rg
SET LOCATION=australiasoutheast
SET DNS_PREFIX=hectacs
SET CLUSTER_NAME=hectkubecluster
set PATH=%PATH%;C:\Program Files (x86)\

REM Create resource group
az group create --name=%RESOURCE_GROUP% --location=%LOCATION%

REM Create the ACS cluster
az acs create --orchestrator-type=kubernetes --resource-group %RESOURCE_GROUP% --name=%CLUSTER_NAME% --dns-prefix=%DNS_PREFIX%

REM Get kubernetes credentials
az acs kubernetes get-credentials --resource-group=%RESOURCE_GROUP% --name=%CLUSTER_NAME%

REM See the kubernetes nodes
kubectl get nodes

REM Run the aspnetapp from Docker hub
kubectl run aspnetapp --image hectagon/aspnetapp

REM See the kubernetes running pods
kubectl get pods

REM expose the container's port on the public load balancer
kubectl expose deployments aspnetapp --port=80 --target-port=5000 --type=LoadBalancer

REM See the allocated IP address to the container
kubectl get svc

REM See for more info: https://docs.microsoft.com/en-us/azure/container-service/container-service-kubernetes-walkthrough
