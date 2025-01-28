#!/bin/bash

docker build -t kensdeepseek . 


# docker run --gpus all -it --rm -p 7860:7860 deepseek-ai
docker run --gpus all -it --rm \
    -p 7860:7860 \
    -p 11434:11434 \
    -v ollama:/root/.ollama
    -it kensdeepseek:latest


docker container ls 