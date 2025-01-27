FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install git and basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
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

# install ollama 
RUN curl -fsSL https://ollama.com/install.sh | sh

# Clone the DeepSeek repository
RUN git clone https://github.com/deepseek-ai/DeepSeek-LLM.git /app/DeepSeek-LLM

# 
RUN ollama run deepseek-r1:8b

# Set environment variables for GPU support
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Expose port for potential web interface
EXPOSE 7860

# Create an entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]