# learning-terraform-up-and-running
Learning Terraform with: Terraform: Up and Running by Yevgeniy Brikman

# Chapter 2

This chapter is about learning essenital syntax. This also walks through how to create an EC2 instacne suing Terraform and builds all the way up to building a cluster of EC2s using Autoscaling Groups and Load Balancers. 

## What I've Learned

- Getting comfortable with everchanging code (multiple updates of Terraform)
- Ensuring that I am being careful with how I write the code (4 hours later, figured out I was missing an 's'.)

It was really cool to see how the auto-scaling group worked along with the load balancer. 

- Terminated an instance, and there was another one that took it's place (auto-healing)
- Was able to ping the 'web server' even while I terminated one of the EC2's, the ALB was able to route to the other EC2 that was available.