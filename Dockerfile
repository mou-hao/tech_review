FROM ubuntu:trusty
RUN apt-get update && apt-get install -y software-properties-common &&\
    add-apt-repository ppa:george-edison55/cmake-3.x && apt-get update &&\
    apt-get install -y g++ cmake libicu-dev git libjemalloc-dev zlib1g-dev &&\
    rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch v3.0.2 https://github.com/meta-toolkit/meta.git &&\
    cd meta && git submodule update --init --recursive
WORKDIR meta
RUN sed -i 's,http://download.icu-project.org/files/icu4c/58.2/,'\
'https://github.com/unicode-org/icu/releases/download/release-58-2/,' CMakeLists.txt &&\
    mkdir build && cd build && cp ../config.toml . &&\
    cmake ../ -DCMAKE_BUILD_TYPE=Release && make
WORKDIR /meta/build