FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

LABEL org.opencontainers.image.source="https://github.com/beecho01/sd-webui-forge-docker"

WORKDIR /app

# Install required packages
RUN apt update && apt upgrade -y && \
    apt install -y wget git python3 python3-venv libgl1 libglib2.0-0 apt-transport-https libgoogle-perftools-dev bc python3-pip

# Clone Stable Diffusion WebUI Forge
RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge /app/sd-webui && \
    cd /app/sd-webui && \
    git checkout f11456e

    # Copy launcher
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set up webui user
RUN useradd -m webui && \
    chown -R webui:webui /app

USER webui

ENTRYPOINT ["/app/run.sh"]