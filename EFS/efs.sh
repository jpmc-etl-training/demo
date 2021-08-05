 sudo yum install -y amazon-efs-utils

#Centos and Redhat Linux
sudo yum –y install nfs-utils

#Ubuntu 
sudo apt-get –y install nfs-common


#Creating the EFS using aws cli
aws efs create-file-system --performance-mode generalPurpose --throughput-mode bursting --encrypted --tags env=dev,Value=my-test-filesystem

#Checking for EFS filesystem status
aws efs describe-file-systems --file-system-id FILESYSTEM_NAME

https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/efs.html
