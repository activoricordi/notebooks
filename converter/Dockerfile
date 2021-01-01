FROM python:3.8-slim-buster AS compile-image

## set environment variables
RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends sudo apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        # This is necessary for apt to access HTTPS sources:
        apt-transport-https \
        pandoc \
        texlive-xetex \
        && \
        rm -rf /var/lib/apt/lists/* && \
        apt-get clean