#!/bin/bash

echo running ollama
/bin/ollama

echo starting serve 
serve

echo "installing ollama deeseek" 
# install version of deepseek
# https://ollama.com/library/deepseek-r1
# RUN ollama run deepseek-r1:7b
/bin/ollama run deepseek-r1:8b
# RUN ollama run deepseek-r1:14b
# RUN ollama run deepseek-r1:32b
# RUN ollama run deepseek-r1:70b

echo ready???