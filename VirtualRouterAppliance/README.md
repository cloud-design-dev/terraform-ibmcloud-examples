<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Deploying our test VRA environment using Terraform](#deploying-our-test-vra-environment-using-terraform)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Deploying our test VRA environment using Terraform

**Major work in progress**

The goal of this project is to have a drop in Terraform repository to deploy our testing VRA environment. As AT&T pushes updates to the VRA we want to be able to spin up a test environment and run some throughput benchmarks. 

- [ ] Test that you can deploy a VRA and execute a small configuration change 
- [ ] Test that you can deploy 2 VRAs and a VSI behind each and then associate the VLANs. 
- [ ] Test the VSI post install scripts to see if we can setup additional interfaces and routes (needs to be created)
- [ ] Test deploying 2 VRAs with 2 Bare Metal Servers 
- [ ] Test the BM post install scripts to see if we can setup additional interfaces and routes (needs to be created)