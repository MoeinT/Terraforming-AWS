# Terraforming-AWS
Here I use Terraform to deply infrastructure in AWS with Terraform. The below architecture has been created with Terraform using a CI/CD pipeline with GitHub actions. 

# VPC 
Within a Virtual Private Cloud, you can launch AWS resources within a private endpoint. It allows you to create your own virtual network in the cloud and control the IP address range, subnets, routing tables, network gateways, and security settings. As shown in the architecture, every single resource has been deployed under such isolated environment for security reasons. Here are a few arguments within the VPC resource block: 

- **enable_dns_hostnames -** DNS hostname is a human-readable name assigned to a network resource, such as a computer, server, or EC2 instance, that is used to identify the resource over the internet. If this argument is set to true, AWS will assign a hostname to every resource launched within this VPC. DNS hostnames are particularly useful if we'd like to refer to those resources using a friendly memorable name, instead of using complex ip addresses. The hostname takes the form of ```hostname.domainname```, where ```hostname``` is the name of the EC2 instance and ```domainname``` is the domain name of your VPC.

- **aws_vpc -** When creating a VPC, we must specify a range of ip addresses that the VPC can use. The CIDR block is specified as a string in the form of IPv4 ```address```/```prefix length```. The IPv4 address is the starting IP address for the range, and the prefix length is the number of bits in the address that are used to define the range
