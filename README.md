# Terraforming-AWS
Here I use Terraform to deply infrastructure in AWS with Terraform. The below architecture has been created with Terraform using a CI/CD pipeline with GitHub actions.

# Overview of the Architecture 
## VPC
Within a Virtual Private Cloud, you can launch AWS resources within a private endpoint. It allows you to create your own virtual network in the cloud and control the IP address range, subnets, routing tables, network gateways, and security settings. As shown in the architecture, every single resource has been deployed under such isolated environment for security reasons. Here are a few arguments within the VPC resource block:

## Subnet
A subnet is a subdivision of VPC's IP address range. Subnets are used to segment and separate resources within a VPC. Resources within a subnet can communicate with one another using their private IP addresses. 

Each subnet is associated with a routing table that determine how the traffic is routed to its destination. If a subnet is associated with a route table that has a route to an internet gateway, it's known as a **public subnet**. If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a **private subnet**.

In this architecture, we have deployed 5 subnets, 2 of which are public. 

## Routing Table
A routing table is a set of rules, called routes, that determine where internet traffic from subnets or a gateway should be directed. If we have multiple subnets inside our VPC, we can create a number of custom route tables and associate each one to a subnet. Like this we can control how each subnet routes traffic. For more details on networking in AWS, see [this great aws documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html).

If a subnet has not been associated with a routing table, it's get automatically associated with a default routing table.

## Internet Gateway
An internet gateway is a highly scalable, highly available, aws-managed component that allows communications between a VPC and the internet. 

We use an internet gateway as an associatition between a route table and a subnet. A principal virtual gateway could have alternatively been used. An internet gateway provides a target in your VPC route tables. 

In this architecture, every routing table will have a default route to an internet gateway. So, every time a resource makes a request, like an EC2 instance trying to reach the internet, it'll going through the internet gateway.

## Security Groups
A security group control the traffic that reach and leave resources that are associated with it. For example, if we associate a security group with an EC2 instance, it'll control the inbound and outbound traffic for the instance. For more examples [see this documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html). 

## Terraform Best Practices
For high-level resources with many dependencies, such as a VPC, it's best practice to use the ```create_before_destroy``` life cycle meta argument. This way, when a change has been implemented to a VPC resource argument, the new replacement object is created first, and the prior object is destroyed after the replacement is created. 

# Summary
In summary, VPC provides the overall network infrastructure, subnets divide the IP address range, routing tables determine traffic paths, and the internet gateway enables communication between the VPC and the internet. These resources work together to create a secure and scalable network architecture within AWS.