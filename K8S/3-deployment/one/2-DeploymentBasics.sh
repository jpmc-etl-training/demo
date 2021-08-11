#Demo 1 - Creating a Deployment
#Demo 1.a - Imperatively, with kubectl run, you have lot's of options available to you 
#such as resource limits, restart policies, or even starting other workload types such as Jobs and bare Pods.

#UPDATE: Starting in kubernetes 1.18 kubectl run creates a pod rather than a deployment. 
#kubectl run hello-world --image=gcr.io/google-samples/hello-app:1.0 --replicas=5
#To create a deployment, we need kubectl create deployment
kubectl create deployment hello-world --image=gcr.io/google-samples/hello-app:1.0
kubectl scale deployment hello-world --replicas=5

#Check out the status of our imperative deployment
kubectl get deployment 


#Now let's delete that and move towards declarative configuration.
kubectl delete deployment hello-world




#Demo 1.b - Declaratively
#Simple Deployment
#Let's start off declaratively creating a deployment with a service.
kubectl apply -f deployment.yaml


#Check out the status of our deployment, which creates the ReplicaSet, which creates our Pods
kubectl get deployments hello-world


#The first replica set created in our deployment, which has the responsibility of keeping
#of maintaining the desired state of our application but starting and keeping 5 pods online
kubectl get replicasets


#The actual pods as part of this replicaset, we know these pods belong to the replicaset because of the
#Pod template hash in the name
kubectl get pods


#But also by looking at the 'Controlled By' property
kubectl describe pods | head -n 15


#Check out the events and the From column, it's the job of the deployment-controller to maintain state.
kubectl describe deployment


#Examining a service, Endpoint controller has the responsibility of managing who is a member of the Service.
kubectl get service hello-world


#Remove our resources
kubectl delete deployment hello-world
kubectl delete service hello-world
