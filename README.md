# docker-env
A short to tutorial on how to build a development and deployment environments with docker. 

As a start, we will setup a simple environment for compiling the Rust programming language. 

## Requirements
All you need is to have docker installed. Follow the instructions for [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/), [Mac](https://docs.docker.com/docker-for-mac/install/) or [Windows](https://docs.docker.com/docker-for-windows/install/). 

## First impressions: What is docker? 

The simplist way to explain docker is probably to compare it to what it isn't: a Virtual Machine. 

While a Virtual Machine emulates a specific set of hardware, docker emulates an OS. Since the host OS and the virtualized OS is really one and the same, we can fire up multiple, isolated applications on the same host with minimal overhead. 

# Tutorial 1: A simple environment for building rust 

Environments in docker are defined in a `Dockerfile`, full documentation [here](https://docs.docker.com/engine/reference/builder/). 

A Dockerfile always starts with a base image,
and for each proceeding instruction in the Dockerfile an image is produced based on the previous image. Each image is also cached locally in your machine. 

Right now, we look into two of the three most important Dockerfile instructions: `FROM` and `RUN`. 

## A basic Dockerfile

```
FROM debian:sid-slim
# Install dependencies
RUN apt-get update && apt-get install -y \
    git \ 
    python2.7 \ 
    make \
    cmake \
    g++ 
# Clone the source
RUN git clone https://github.com/rust-lang/rust.git
# Build and install
RUN cd rust && \
    git submodule update --init --recursive --progress && \
    ./x.py build && sudo ./x.py install
```

The `FROM ...` instruction defines our base image. For instance, `FROM alpine` is commonly used since alpine is a very lightweight linux distribution, which means we get a lightweight container. 
In our case, we will `debian`, but by specifying `debian:sid-slim` we make sure that we get a lightweight version with a minimal number of packages included. The images are retreived from docker-hub, but you can setup docker to use an alternative repository. 
