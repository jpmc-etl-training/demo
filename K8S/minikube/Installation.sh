
#Installation of Bat tool on Linux

wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb

sudo dpkg -i ./bat_0.15.4_amd64.deb

#Check the OS details before installation

https://v1-18.docs.kubernetes.io/docs/tasks/tools/install-minikube/


# start multiple node minikube 
minikube start --nodes 4 -p multinode

#Select the profile 
minikube profile list
minikube profile multinode-demo


# Setup of registry for minikube

minikube addons configure registry-creds


#Setup of the Ingress Controller for Minikube 

minikube addons enable ingress
