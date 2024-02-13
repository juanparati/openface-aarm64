FROM arm64v8/debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
	libboost-filesystem1.74.0 \
	libgtk2.0-0 \
	libdc1394-25 \
	libavcodec58 \
	libavformat58 \
    libtbb2 \
    libprotobuf23 \
    python3-numpy \
    libopenblas-base \
    libswscale5 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*
    

COPY bin ./oface
COPY libopencv /usr/local/lib

RUN chmod +x ./oface/FaceLandmark* \
 && chmod +x ./oface/FeatureExtraction \
 && mkdir ./oface/processed \
 && mkdir ./oface/input

WORKDIR oface
