#! bash


docker build -t kensdeepseek . 

docker run -it  \
    -p 5900:5900 \
    -p 8501:8501 \
    -p 6080:6080 \
    -p 8080:8080 \
    -it kensdeepseek:latest


docker container ls 