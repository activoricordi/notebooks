FROM python:3.8-slim-buster AS compile-image


ENV VIRTUAL_ENV=/opt/venv

RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && \
    apt-get install -y sudo apt-utils && \
    apt-get upgrade -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        # This is necessary for apt to access HTTPS sources:
        apt-transport-https \
        build-essential

# Default powerline10k theme, no plugins installed
# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)"



# Set Working directory
WORKDIR /docs

# Expose Mkdocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT [ "mkdocs" ]