# Terraforming-AWS
Here I use Terraform to deply infrastructure in AWS with Terraform. The below architecture has been created with Terraform using a CI/CD pipeline with GitHub actions. 

# VPC
Within a Virtual Private Cloud, you can launch AWS resources within a private endpoint. It allows you to create your own virtual network in the cloud and control the IP address range, subnets, routing tables, network gateways, and security settings. As shown in the architecture, every single resource has been deployed under such isolated environment for security reasons. Here are a few arguments within the VPC resource block:

# Subnet
If a subnet is associated with a route table that has a route to an internet gateway, it's known as a public subnet. If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a private subnet.

# Routing Table
A routing table is a set of rules, called routes, that determines where internet traffic from subnets or a gateway should be directed. If we have multiple subnets inside our VPC, we can create a number of custom route tables and associate each one of them to a subnet. Like this we can control how each subnet routes traffic. For more details on networking in AWS, see [this great aws documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html).

If a subnet has not been associated with a routing table, it's get automatically associated with a default routing table.

# Internet Gateway 
We use an internet gateway as an associatition between a route table and a subnet. A principal virtual gateway could have alternatively been used. An internet gateway provides a target in your VPC route tables. 

In this architecture, every routing table will have a default route to an internet gateway. So, every time a resource makes a request, like an EC2 instance trying to reach the internet, it'll going through the internet gateway.