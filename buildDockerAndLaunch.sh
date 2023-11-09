#!/usr/bin/env bash

if [[ "$1" == "--buildAndLaunch" ]]; then
    docker volume create data
    docker build -f /home/thanos/repositories/TornadoVM-stratika/Dockerfile.nvidia.opencl.graalvm.jdk21 -t tornadovm-polyglot-graal-23.1.0-nvidia-opencl-container .
    docker run -it -p 8080:8080 --rm --runtime=nvidia --gpus all -v data:/data tornadovm-polyglot-graal-23.1.0-nvidia-opencl-container
elif [[ "$1" == "--launch" ]]; then
    docker run -it -p 8080:8080 --rm --runtime=nvidia --gpus all -v data:/data tornadovm-polyglot-graal-23.1.0-nvidia-opencl-container
elif [[ "$1" == "--deleteVolume" ]]; then
    docker volume rm data
elif [[ "$1" == "--help" ]] || [[ "$1" == "--h" ]]; then
    echo "Please run:"
    echo "  ./buildDockerAndLaunch.sh --buildAndLaunch	to build and launch the image, or"
    echo "  ./buildDockerAndLaunch.sh <command>		to launch a built image, or"
    echo "  ./buildDockerAndLaunch.sh --deleteVolume	to delete the generated volume"
    echo "  ./buildDockerAndLaunch.sh --help		to print help message"
else
    docker run -it -p 8080:8080 --rm --runtime=nvidia --gpus all -v data:/data tornadovm-polyglot-graal-23.1.0-nvidia-opencl-container "$@"
fi
