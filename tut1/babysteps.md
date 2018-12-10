# Tutorial 1: A simple environment for building rust 

Environments in docker are defined in a `Dockerfile`, full documentation [here](https://docs.docker.com/engine/reference/builder/). 

A Dockerfile always starts with a base image,
and for each proceeding instruction in the Dockerfile an image is produced based on the previous image. Each image is also cached locally in your machine. 

Right now, we look into two of the three most important Dockerfile instructions: `FROM` and `RUN`. 

## A basic Dockerfile
The following is a simple dockerfile that checkouts out, builds and installs the rust compiler from source. 
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
RUN cd rust && ./x.py build
# Install  
RUN cd rust && ./x.py install 
```

### From 
The `FROM ...` instruction defines our base image. 
The images are retreived from docker-hub by default, but you can setup docker to use an alternative repository. 
In our case, we will use `debian`, since that is a widespread, well known linux distribution most are familiar with.
We can find available versions by looking through the [Debian entry on docker-hub](https://hub.docker.com/_/debian/). We choose `debian:sid-slim` since that is a minimal, up to date version of the os. The smaller the base image, the smaller our final container will be. 

### Run
We can then start configuring our container with the `RUN`-instruction that allows you to run any typical shell command. 

#### Caching
An important detail to note is that the caching is done between instructions. For instance, if you would run 
```
RUN apt-get update
RUN apt-get install -y ...
```
Then the apt update step will be cached as its own image. If you the update then dependency list, the apt update step will not be invalidated. Grouping all releted commands into one instruction is therefore important in order to avoid weird bugs because of partial caching. Likewise, you might want to split up instructions if caching might be useful. 

#### State 
It is also important to note that the working directory doesn't transfer between the `RUN`-instructions. This: 
```
# Build 
RUN cd rust && ./x.py build
# Install  
RUN ./x.py install 
```
wouldn't work, since the next instruction will be running on top of an image where we are back at root. We will later circumvent this with `WORKDIR`.  

## Building our first docker image
We can build our image by running: 
`docker build . -t rust`

The `docker build`-command takes a context that points to a Dockerfile as an argument. This can be a URL or a Path. In our case we use our current directory, assuming that the Dockerfile is there. 

The `-t rust`-flag sets a tag (rust) for our image. This will allow us to refer to our image in the future without having to use a hash.

## Running our first docker image
We can fire it up by running: `docker run rust sh -c "rustc --version"`. If we want to browse around in our container, you can use `docker run -ti rust sh`. The `-ti`-flags allocate a pseudo tty and keep STDIN open, allowing us to actually use the shell we tell docker to fire up inside the container. 
