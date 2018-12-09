# Tutorial 1: A simple environment for building rust 

Environments in docker are defined in a `Dockerfile`, full documentation [here](https://docs.docker.com/engine/reference/builder/). 

A Dockerfile always starts with a base image,
and for each proceeding instruction in the Dockerfile an image is produced based on the previous image. Each image is also cached locally in your machine. 

Right now, we look into two of the three most important Dockerfile instructions: `FROM` and `RUN`. 

## A basic Dockerfile

```
FROM debian:sid-slim
# Install and setup dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    git \ 
    curl \
    python \ 
    make \
    cmake \
    g++
# Clone the source
RUN git clone https://github.com/rust-lang/rust.git
# Clone submodules
RUN cd rust && \
    git submodule update --init --recursive --progress 
# Build 
RUN cd rust && \
    ./x.py build
# Install  
RUN cd rust && ./x.py install 
```

## From 
The `FROM ...` instruction defines our base image. 
The images are retreived from docker-hub by default, but you can setup docker to use an alternative repository. 
In our case, we will use `debian`, since that is a widespread, well known linux distribution most are familiar with.
We can find available versions by looking through the [Debian entry on docker-hub](https://hub.docker.com/_/debian/). We choose `debian:sid-slim` since that is a minimal, up to date version of the os. The smaller the base image, the smaller our final container will be. 

## Run
We can then start configuring our container with the `RUN`-instruction that allows you to run any typical shell command. 

### Caching
An important detail to note is that the caching is done between instructions. For instance, if you would run 
```
RUN apt-get update
RUN apt-get install -y ...
```
Then the apt update step will be cached as its own image. If you the update then dependency list, the apt update step will not be invalidated. Grouping all releted commands into one instruction is therefore important in order to avoid weird bugs because of partial caching. 

