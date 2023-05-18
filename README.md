# Terraforming-AWS
Here I use Terraform to deply infrastructure in AWS with Terraform. The below architecture has been created with Terraform using a CI/CD pipeline with GitHub actions.

# Overview of the Architecture
## VPC
Within a Virtual Private Cloud, you can launch AWS resources within a private endpoint. It allows you to create your own virtual network in the cloud and control the IP address range, subnets, routing tables, network gateways, and security settings. As shown in the architecture, every single resource has been deployed under such isolated environment for security reasons. Here are a few arguments within the VPC resource block:

## Subnet
A subnet is a subdivision of VPC's IP address range. Subnets are used to segment and separate resources within a VPC. Resources within a subnet can communicate with one another using their private IP addresses. 

Each subnet is associated with a routing table that determine how the traffic is routed to its destination. If a subnet is associated with a route table that has a route to an internet gateway, it's known as a **public subnet**. If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a **private subnet**. In this architecture, we have deployed 5 subnets, 2 of which are public. 

## Routing Table
A routing table is a set of rules, called routes, that determine where internet traffic from subnets or a gateway should be directed. If we have multiple subnets inside our VPC, we can create a number of custom route tables and associate each one to a subnet. Like this we can control how each subnet routes traffic. For more details on networking in AWS, see [this great aws documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html). If a subnet has not been associated with a routing table, it's get automatically associated with a default routing table.

## Internet Gateway
An internet gateway is a highly scalable, highly available, aws-managed component that allows communications between a VPC and the internet. For public subnetw we use an internet gateway as an associatition with a route table. A principal virtual gateway could alternatively be used for private subnets. In this architecture, every routing table will have a default route to an internet gateway. So, every time a resource makes a request, like an EC2 instance trying to reach the internet, it'll going through the internet gateway.

## Security Groups
A security group control the traffic that reach and leave resources that are associated with it. For example, if we associate a security group with an EC2 instance, it'll control the inbound and outbound traffic for the instance. For more examples [see this documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html). In this architecture we have a public SG that has been provisioned to provide access to ports 22 and 80, and a private security group to provide access to port 3306, which will be used for the RDS instances, which are deployed under a private subnet; so they will not be able to interact with public internet, but they will be able to communicate with resources inside the VPC.

## Database subnet group
An AWS database subnet group is a collection of subnets in a virtual private cloud where AWS RDS instances can be deployed. When you create a database subnet group, you need to provide the subnets that are associated with it. This ensures high availability and fault tolerance for AWS RDS instances. This means that the RDS instances are spread across different subnets and availability zones to minimize the impact of failures.

## Application Load Balancer (ALB)
An application load balancer automatically distributes the incoming traffic across multiple targets. In an ALB a listener checks for connection requests from clients; the rules that we define for a listener determines how the load balancer routes requests to its registered targets. Each listener can be associated with a target group that routes traffic to a number of registered targets, such as a EC2 instance. Additionally, it's possible to configure health checks for the load balancer, so that it only routes traffic to the healthy ones. See the documentation for more details on the [ALB components](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html). 

In this architecture, we have associated the ALB to two public subnets and a public security group allowing access to ports 22 and 80. So, we will listen to these ports and forward the traffic into any target group.

## Target group
Each target group is used to route requests to one or more registered targets. In this architecture, we created a target group hosting our target instances that receive traffic from the the Application Load Balancer that we created above.

## Listener
In order for the Load Balancer to forward the traffic into a target group with a number of target instances, we would need a listener. A listener is a process that checks for connection requests, using the protocol and port that you configure. The rules that you define for a listener determine how the load balancer routes requests to its registered targets. 

In this architecture, we have associated the ALB to a security group that allows traffic from port 80 and 22. We have then provisioned a listener that forwards traffic from port 80 to our target group. This means that only the portion of the traffic from the load balancer that is associated with port 80 will be ingested by the listener and forwarded to the target group.  

## EC2 
Next task will be to deploy a EC2 instance. This will be then associated to the target group we created above, and will be used to host the control place of the Kubernetes service. 


## Kubernetes and its components 

## Terraform Best Practices
- For high-level resources with many dependencies, such as a VPC, it's best practice to use the ```create_before_destroy``` life cycle meta-argument. This way, when a change gets implemented to a VPC resource argument, the new replacement object is created first, and the prior object is destroyed after the replacement is created. This ensures that other objects that depend on VPC would not be interuppted. 

- **Conditional resource deployment inside a module -** For such cases create a variable of type boolean and pass it to the module. If this variable is set to true, use a ```count``` meta argument inside the resource definition in the module and set it to one, and if the variable is set to false, set the count to zero. Here's how the count meta argument would look like: ```count = var.createResource ? 1: 0```

# Summary
In summary, VPC provides the overall network infrastructure, subnets divide the IP address range, routing tables determine traffic paths, and the internet gateway enables communication between the VPC and the internet. These resources work together to create a secure and scalable network architecture within AWS.