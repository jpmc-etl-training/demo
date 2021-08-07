aws iam create-user --user-name rethesh
aws iam create-group --group-nam admins
aws iam add-user-to-group --user-name rethesh --group-name admins
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --group-name admins