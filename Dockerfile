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


