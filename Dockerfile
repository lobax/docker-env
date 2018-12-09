FROM debian:sid-slim
# Install and setup dependencies
RUN apt-get update && apt-get install -y \
    git \ 
    python2.7 \ 
    make \
    cmake \
    g++ && \
    ln -s /usr/bin/python2.7 /usr/bin/python
# Clone the source
RUN git clone https://github.com/rust-lang/rust.git
# Build and install
RUN cd rust && \
    git submodule update --init --recursive --progress && \
    ./x.py build && sudo ./x.py install


