# This terraform code will create  bastion host on AWS 

![bastion_host](https://user-images.githubusercontent.com/100177153/156974704-4edc013e-e845-44f1-aa9b-915856723692.jpg)

### Create VPC Infrastructure
```
10.0.0.0/16 - vpc
private subnet a - 10.0.12.0/24 - nat-A 
private subnet b - 10.0.22.0/24 - nat-B
public subnet a  - 10.0.11.0/24 - igw
public subnet b - 10.0.21.0/24  - igw
db subnet a - 10.0.13.0/24
db subnet b- 10.0.23.0/24
route table public 
route table private a - (subnet associate private subnet a)
route table private b -  (subnet associate private subnet b)
route table db - (subnet associate db-a and db-b)
nat -a - elastic ip attached 
nat -b - elastic ip attached 
nat-a attached to public subnet a  - destination 0.0.0.0/0
nat-b attached to public subnet b - destination 0.0.0.0/0
```
### BASTION Host

sec group (SSH-Access-For-Bastion) - inbound rules open ssh 22 port anywhere   0.0.0.0/0  (outbond nothing)
asg launch configuration (Bastion_Host)
asg  (Bastion_ASG)

	1. asg will automatically create bastion host 

	2. create ec2 instance for bastion host
	  - attach PrivateSubnet-A
	  - auto-assign Public IP - No
	  - sec group (SSH-Access-For-Bastion)

	3. create another ec2 instance for bastion host DB
	  - attach DBSubnet-B
	  - auto-assign Public IP - No
    - sec group (SSH-Access-For-Bastion)

