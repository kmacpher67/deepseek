# Kens deepseek testing @2025-Jan-27

I generated the first file via myself and 2nd Dockerfile using Anthropics Claude Computer Use Demo. lol. 
Can i write an integration into index2.html for claude demo to use this or https://openwebui.com/

I just used the ollama docker image and created a custom entrypoint file for running. Then I just gave up on that and 
docker exec -it into the contianer and run the deepseek model commands. :(

what is this: 
https://lmstudio.ai/


https://ollama.com/library/deepseek-r1


ollama run deepseek-r1:7b
ollama run deepseek-r1:8b


## Ask questions: 

### How much bleach is needed to disinfect a standard residential 300ft deep well of 2" diamter?
```
<think>
Okay, so I need to figure out how much bleach is required to disinfect a 300-foot deep well. Hmm, where do I start? I remember that wells are cylindrical, 
right? So maybe the volume of the well can be calculated using the formula for the volume of a cylinder, which is V = πr²h, where r is the radius and h is 
the height (or depth in this case).

```
It babbles on&on.





The entrypoint script uses the DeepSeek Coder 33B model by default, but you can modify the model_name variable to use other DeepSeek models like:

deepseek-ai/deepseek-coder-6.7b-instruct
deepseek-ai/deepseek-coder-1.3b-instruct
deepseek-ai/deepseek-llm-7b-chat


How to check Ubuntu 22.04 

Tool Use: bash
Input: {'command': 'sudo apt-get update && sudo apt-get install -y pciutils'}

Tool Use: bash
Input: {'command': 'lspci | grep -i nvidia'}
My local P53s (acronym for Piece of Shyt Lenovo).
3c:00.0 3D controller: NVIDIA Corporation GP108GLM [Quadro P520] (rev a1)

sudo apt-get update
sudo apt-get install -y nvidia-driver-525  # or a newer version
```
Reading state information... Done
nvidia-driver-525 is already the newest version (525.147.05-0ubuntu2.22.04.1).
```
Status: Downloaded newer image for nvidia/cuda:11.6.2-base-ubuntu20.04
docker: Error response fro

 sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```Status: Downloaded newer image for nvidia/cuda:11.6.2-base-ubuntu20.04
docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]].
(base) kenmac@kenmac-ThinkPad-P53:~/personal/deepseek$ 
```

# Configure Docker to use NVIDIA Container Runtime: & try again
# Install NVIDIA Container Toolkit
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

docker info | grep -i nvidia
sudo docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```
Runtimes: io.containerd.runc.v2 nvidia runc

+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.230.02             Driver Version: 535.230.02   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  Quadro P520                    On  | 00000000:3C:00.0 Off |                  N/A |
| N/A   50C    P5              N/A / ERR! |   1507MiB /  2048MiB |     28%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
+---------------------------------------------------------------------------------------+
```



