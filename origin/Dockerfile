FROM arm64v8/debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	git \
	libopenblas-dev \
	liblapack-dev \
	libgtk2.0-dev \
	pkg-config \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libtbb2 \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libdc1394-22-dev \
	build-essential \
	gstreamer1.0-opencv \
	libtbb-dev \
	libboost-all-dev \
	libprotobuf23 \
	python3-dev \
	python3-numpy \
	unzip \
	cmake \
	wget

RUN git clone https://github.com/FFmpeg/FFmpeg.git \
	&& cd FFmpeg \
	&& mkdir build \
	&& cd build \
	&& ../configure --prefix=/opt/ffmpeg --enable-pic --disable-asm --disable-debug --disable-cuda --disable-cuvid \
	&& make -j4 \
	&& make install \
	&& cd ../.. \
	&& rm -rf FFmpeg \
	&& export LD_LIBRARY_PATH=$FFMPEG_PATH/lib/:$LD_LIBRARY_PATH \
	&& export PKG_CONFIG_PATH=$FFMPEG_PATH/lib/pkgconfig:$PKG_CONFIG_PATH

RUN wget https://github.com/opencv/opencv/archive/4.1.0.zip \
 	&& unzip 4.1.0.zip \
	&& cd opencv-4.1.0 \
	&& sed -i 's/ipcp-unit-growth/ipa-cp-unit-growth/g' 3rdparty/carotene/CMakeLists.txt \
	&& sed -i 's/ipcp-unit-growth/ipa-cp-unit-growth/g' 3rdparty/carotene/hal/CMakeLists.txt \
	&& mkdir build \
	&& cd build \
	&& cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_TIFF=ON -D WITH_TBB=ON -D WITH_FFPMEG=ON -D WITH_V4L=ON .. \
	&& make -j4 \
	&& make install \
	&& cd ../.. \
	&& rm -rf opencv-4.1.0 \
	&& rm 4.1.0.zip

RUN wget http://dlib.net/files/dlib-19.13.tar.bz2 && tar xf dlib-19.13.tar.bz2 \
	&& cd dlib-19.13 \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& cmake --build . --config Release \
	&& make install \
	&& ldconfig \
	&& cd ../.. \
	&& rm -rf dlib-19.13 \
	&& rm dlib-19.13.tar.bz2

RUN mkdir obuild \
	&& git clone https://github.com/TadasBaltrusaitis/OpenFace.git obuild \
	&& cd obuild \
	&& bash download_models.sh \
	&& sed -i '/\/usr\/local\/opt\/openblas\/include/a \/usr\/include\/aarch64-linux-gnu' cmake/modules/FindOpenBLAS.cmake \
	&& sed -i '/\/usr\/local\/opt\/openblas\/include/a \/usr/lib/aarch64-linux-gnu' cmake/modules/FindOpenBLAS.cmake \
	&& sed -i '/\/usr\/local\/opt\/openblas\/lib/a \/usr/lib/aarch64-linux-gnu' cmake/modules/FindOpenBLAS.cmake \
	&& sed -i '/\/usr\/local\/opt\/openblas\/lib/a \/usr/include/aarch64-linux-gnu' cmake/modules/FindOpenBLAS.cmake \
	&& sed -i '/^if (\${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")$/,/^endif ()$/d' CMakeLists.txt \
	&& mkdir build \
	&& cd build \
	&& cmake -D CMAKE_BUILD_TYPE=RELEASE .. \
	&& make \
	&& mkdir ../../OpenFace \
	&& cp -R ./bin/* ../../OpenFace \
	&& cd ../.. \
	&& rm -rf obuild

RUN apt-get remove -y \
	git \
	libopenblas-dev \
	liblapack-dev \
	libgtk2.0-dev \
	pkg-config \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libdc1394-22-dev \
	build-essential \
	libtbb-dev \
	libboost-all-dev \
	unzip \
	cmake \
	wget

RUN apt-get install -y --no-install-recommends \
	libboost-filesystem1.74.0 \
	libgtk2.0-0 \
	libdc1394-25 \
	libavcodec58 \
	libavformat58

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN mkdir OpenFace/input && mkdir OpenFace/processed
WORKDIR OpenFace
