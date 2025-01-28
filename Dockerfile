FROM ollama/ollama


# Set working directory
WORKDIR /app

# Install git and basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    build-essential \
    curl \
    wget 

# add extra os installs here
RUN apt-get update && apt-get install -y \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp
RUN cd /tmp && pip install -r requirements.txt

# Install deepseek and its dependencies from requirements.txt 
# RUN pip3 install --no-cache-dir \
#     torch \
#     transformers \
#     accelerate \
#     sentencepiece \
#     gradio

# Clone the DeepSeek repository
RUN git clone https://github.com/deepseek-ai/DeepSeek-LLM.git /app/DeepSeek-LLM

# install ollama 
# RUN curl -fsSL https://ollama.com/install.sh | sh

# I THINK THIS NEEDS TO BE IN THE SHELL SCRIPT!!!
# install version of deepseek
# https://ollama.com/library/deepseek-r1
# RUN ollama run deepseek-r1:7b
# RUN /bin/ollama run deepseek-r1:8b
# RUN ollama run deepseek-r1:14b
# RUN ollama run deepseek-r1:32b
# RUN ollama run deepseek-r1:70b

# Set environment variables for GPU support
# ENV NVIDIA_VISIBLE_DEVICES all
# ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Expose port for potential web interface
# EXPOSE 7860

# # Create an entrypoint script
# COPY entrypoint.sh /app/entrypoint.sh
# RUN chmod +x /app/entrypoint.sh

# ENTRYPOINT ["/app/entrypoint.sh"]