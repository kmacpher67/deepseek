#!/bin/bash

echo "installing ollama deeseek" 
# install version of deepseek
# https://ollama.com/library/deepseek-r1
# RUN ollama run deepseek-r1:7b
/bin/ollama run deepseek-r1:8b
# RUN ollama run deepseek-r1:14b
# RUN ollama run deepseek-r1:32b
# RUN ollama run deepseek-r1:70b



# Function to print usage information
print_usage() {
    echo "DeepSeek AI Container Usage:"
    echo "  No arguments: Start Python interactive shell"
    echo "  --serve: Start the model with Gradio web interface"
    echo "  --interactive: Start interactive chat with the model in terminal"
    echo "  --help: Show this help message"
    echo "  Any other command will be executed as-is"
}

# Function to start the Gradio web interface
start_gradio_server() {
    python3 -c "
import gradio as gr
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

# Initialize model and tokenizer
model_name = 'deepseek-ai/deepseek-coder-33b-instruct'
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    torch_dtype=torch.float16,
    device_map='auto'
)

def generate_response(prompt):
    inputs = tokenizer(prompt, return_tensors='pt').to(model.device)
    outputs = model.generate(
        **inputs,
        max_length=2048,
        temperature=0.7,
        do_sample=True,
        pad_token_id=tokenizer.eos_token_id
    )
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return response

# Create Gradio interface
iface = gr.Interface(
    fn=generate_response,
    inputs=gr.Textbox(lines=5, label='Input Prompt'),
    outputs=gr.Textbox(lines=10, label='Generated Response'),
    title='DeepSeek AI Interface',
    description='Enter your prompt to generate responses using DeepSeek AI model.'
)

iface.launch(server_name='0.0.0.0', server_port=7860)
"
}

# Function to start interactive chat
start_interactive_chat() {
    python3 -c "
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

# Initialize model and tokenizer
model_name = 'deepseek-ai/deepseek-coder-33b-instruct'
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    torch_dtype=torch.float16,
    device_map='auto'
)

print('DeepSeek AI Interactive Chat')
print('Type \'quit\' to exit')
print('='*50)

while True:
    try:
        user_input = input('\nYou: ')
        if user_input.lower() == 'quit':
            break
            
        inputs = tokenizer(user_input, return_tensors='pt').to(model.device)
        outputs = model.generate(
            **inputs,
            max_length=2048,
            temperature=0.7,
            do_sample=True,
            pad_token_id=tokenizer.eos_token_id
        )
        response = tokenizer.decode(outputs[0], skip_special_tokens=True)
        print('\nDeepSeek:', response)
        
    except KeyboardInterrupt:
        break
    except Exception as e:
        print(f'Error: {str(e)}')
        continue

print('\nGoodbye!')
"
}

# Main script logic
case "$1" in
    --help)
        print_usage
        ;;
    --serve)
        echo "Starting DeepSeek AI with Gradio web interface..."
        start_gradio_server
        ;;
    --interactive)
        echo "Starting DeepSeek AI interactive chat..."
        start_interactive_chat
        ;;
    "")
        echo "Starting Python interactive shell..."
        python3
        ;;
    *)
        # Execute any other command passed to the container
        exec "$@"
        ;;
esac