This is a sample project for use Terraform to create an small infraestructure on AWS cloud

Mandatory Steps

Go to AWS Console and create your access key

You should get 2 values:

- Access Key
- Secret Access Key

Create the following enviroment variables:

AWS_ACCESS_KEY_ID       = Your AWS Access Key
AWS_SECRET_ACCESS_KEY   = Your AWS Secret Access Key

Create a aws group with the policies needed

TODO

Create service user for this implementation and add it to the terraform_services aws group 

aws iam create-user --user-name tf_aws_java_example

OUTPUT:

{
    "User": {
        "UserName": "tf_aws_java_example",
        "Path": "/",
        "CreateDate": "2018-08-28T14:25:07Z",
        "UserId": "AIDAJDB2V2BANQEITSOYU",
        "Arn": "arn:aws:iam::882165092973:user/tf_aws_java_example"
    }
}

aws iam add-user-to-group --group-name terraform_services --user-name tf_aws_java_example