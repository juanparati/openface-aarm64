# OpenFace 2.2.0 for aarm64

## What is it?

[OpenFace](https://github.com/TadasBaltrusaitis/OpenFace) as docker container image for aarm64 environments.

## Motivation

The development of OpenFace stopped 5 years, however it's still a great piece of software used in mutiple research projects. OpenFace requires old dependencies that are not easy to compile for aarm64 architecture so I decided to create a container that runs in computers with ARM processors such new Apple Silicon devices or AWS graviton instances without the hassle of compile and pollute the current environemnt with development libraries and data files.

## Usage examples

Process multiple images from a directory:

    docker run --rm -it -v /host/input:/oface/input -v /host/processed:/oface/processed openface-arm:2.2.0 ./FaceLandmarkImg -fdir input

Process a video file

    docker run --rm -it -v /host/input:/oface/input -v /host/processed:/oface/processed openface-arm:2.2.0 ./FaceLandmarkVid -f input/myvideo.mp4


Replace `/host/input` with the path to the local directory that contains the input files.
Replace `/host/processed`with the path to the local directory that contains the processed files

## Executables included

- FaceLandmarkImg
- FaceLandmarkVid
- FaceLandmarkVidMulti
- FeatureExtraction

## How were the original binaries compiled?

See [origina/Dockerfile](origin/Dockerfile).