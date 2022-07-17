#!/bin/bash
# configure AWS
# sudo apt-get update
# sudo apt-get install awscli -y
# sudo /bin/mkdir -p "$PATH/$DIR"
# sudo chmod 777 ~/.aws/credentials
# sudo mkdir ~/.aws/
# sudo touch ~/.aws/credentials
# sudo touch ~/.aws/credentials
# sudo cat <<EOF > ~/.aws/credentials
# aws_access_key_id = AKIAVXWQJLACQOCP2PDV 
# aws_secret_access_key = pIheVBKXL08PPDxkG8Y3lqc68o
# EOF
# sudo cat <<EOF > ~/.aws/config
# [default]
# region = us-east-1
# output = json
# EOF

# # associate Elastic IP
# # INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
# # ALLOCATION_ID=$(aws ec2 allocate-address --output table | perl -lne 'print $& if /(\d+\.){3}\d+/')
# # aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $ALLOCATION_ID --allow-reassociation

sudo yum install httpd -y
sudo echo "<h1>hey i am $(hostname -f)<h1>"| sudo tee /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on