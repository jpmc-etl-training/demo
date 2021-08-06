Install CLI: pip install awscli
Configure CLI: aws congifure
List Buckets: aws s3 ls
List Bucket Content: aws s3 ls s3://<bucket>
Make Bucket: aws s3 mb s3://<bucket>
Remove Empty Bucket: aws s3 rb s3://<bucket>
Sync Objects: aws s3 sync <local> s3://bucket
Copy to Bucket: aws s3 <object> s3://<bucket>
Copy from Bucket: aws s3 cp s3://<bucket>/<object> <destination>
Move Object: aws s3 mv s3://<bucket>/<object> <destination>
Remove Object: aws s3 rm s3://<bucket>/<object>
Sync Objects Between Buckets or Directories: aws s3 sync <local> s3://<bucket>