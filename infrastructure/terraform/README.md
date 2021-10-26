# set up
1. create key to use for the webserver and bastion instances

    ssh-keygen -f <key-name>

2. in the ./packer/scripts/01_instance_user_data.sh update the url to download the codedeploy agent to your desire region

3. create initial ami using packer, first you need to create the variables.json file and fill the required data (use variable.example.json as base)

    cd ./packer
    packer validate 00_create_custom_ami.json
    packer build 00_create_custom_ami.json

4. copy the ami-id created by packer and note it to use it in the next step for the terraform variables

5. create ./terraform/terraform.tfvars file and set up required variables (use terraform.example.tfvars as base)

6. run terraform to create infrastructure

    terraform init
    terraform plan
    terraform apply -auto-approve

7. terraform will create a codedeployer user, using the aws console generate a access key id and acess key secret, note them.

8. create repository in github (named: aws-codedeploy) and set up the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY secrtes with the data from the previous

9. in the .github/worflows/ci-cd.yml file, update the appname, deploy-group, s3-bucket and aws-region you are going to use

10. push your changes to the github repository, changes pushed to the staging branch will be deployed to the ec2 instance created by terraform

    git checkout -b staging
    git comimit -am "initial commit"
    git push origin staging
