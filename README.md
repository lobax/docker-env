# docker-env
A short to tutorial on how to build a development and deployment environments with docker. 

As a start, we will setup a simple environment for compiling the Rust programming language. 

## Requirements
All you need is to have docker installed. Follow the instructions for [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/), [Mac](https://docs.docker.com/docker-for-mac/install/) or [Windows](https://docs.docker.com/docker-for-windows/install/). 

## First impressions: What is docker? 

The simplist way to explain docker is probably to compare it to what it isn't: a Virtual Machine. 

While a Virtual Machine emulates a specific set of hardware, docker emulates an OS. Since the host OS and the virtualized OS is really one and the same, we can fire up multiple, isolated applications on the same host with minimal overhead. 

- [Tutorial 1: Baby steps](tut1/babysteps.md)

- [Tutorial 2: Compile](tut2/compile.md)
