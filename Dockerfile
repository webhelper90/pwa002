FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth 1 https://github.com/osmcode/osmconvert.git && \
    cd osmconvert && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd .. && \
    rm -rf osmconvert/build && \
    rm -rf osmconvert

RUN git clone --depth 1 https://github.com/mapbox/tippecanoe.git && \
    cd tippecanoe && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf tippecanoe

RUN git clone --depth 1 https://github.com/maptiler/pmtiles.git && \
    cd pmtiles && \
    go build && \
    cp pmtiles /usr/local/bin/ && \
    cd .. && \
    rm -rf pmtiles

CMD ["/bin/bash"] # コンテナ起動時にbashシェルを起動
