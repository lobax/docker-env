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


