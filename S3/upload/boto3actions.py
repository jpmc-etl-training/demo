import boto3

# Initialize interfaces
s3Client = boto3.client('s3')
s3Resource = boto3.resource('s3')

# Create byte string to send to our bucket
putMessage = b'Hi! I came from Boto3!'

# put_object
response = s3Client.put_object(
    Body = putMessage,
    Bucket = 'retdataupload',
    Key = 'boto3put.txt'
)

print(response)

# copy
toCopy = {
    'Bucket': 'retdataupload',
    'Key': 'boto3put.txt'
}

s3Resource.meta.client.copy(toCopy, 'retdataupload', 'boto3copy.txt')

# copy_object
response = s3Client.copy_object(
    Bucket = 'retdataupload',
    CopySource = '/retdataupload/boto3put.txt',
    Key = 'boto3copyobject.txt'
)

print(response)

# upload_file
boto3Upload = 'boto3upload.txt'

s3Resource.meta.client.upload_file(boto3Upload, 'retdataupload', boto3Upload)

# upload_fileobj
with open(boto3Upload, 'rb') as fileObj:
    response = s3Client.upload_fileobj(fileObj, 'retdataupload', 'boto3uploadobj.txt')
    print(response)
