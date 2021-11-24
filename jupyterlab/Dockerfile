ARG BASE_IMAGE=debian:stretch-slim

ARG BASE_CONTAINER=${BASE_IMAGE}


# Mutli-stage build to keep final image small. Otherwise end up with
# curl and openssl installed
FROM ${BASE_CONTAINER} AS stage1
ARG MICROMAMBA_VERSION=0.7.14

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
    apt-get install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/{apt,dpkg,cache,log} \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/${MICROMAMBA_VERSION} | \
    tar -xj -C /tmp bin/micromamba

FROM ${BASE_CONTAINER} AS stage2

USER root
WORKDIR /

# Prevents from writing python compiler files
ENV PYTHONDONTWRITEBYTECODE=1
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV MICROMAMBA_BIN=/bin/micromamba
ENV MICROMAMBA_ENVS=/opt/conda/envs/
ENV ENV_NAME=jupyterlab
ENV ENV_PATH=/opt/conda/envs/${ENV_NAME}
ENV ENV_FOLDER=/venv

# Use bash in Dockerfile RUN commands and make sure bashrc is sourced when
# executing commands with /bin/bash -c
# Needed to have the micromamba activate command configured etc.
ENV BASH_ENV /root/.bashrc
# Change shell from sh to bash 
SHELL ["/bin/bash", "-c"]

# Setting $BASH_ENV and the SHELL command will not result in .bashrc being sourced when
# you supply the program to run as an argument to the "docker run" command.
# Manually add directory for micromamba installed executables to PATH as a workaround.
ENV PATH "$MAMBA_ROOT_PREFIX/bin:$PATH"

COPY --from=stage1 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=stage1 /tmp/bin/micromamba ${MICROMAMBA_BIN}

RUN ln -s ${MICROMAMBA_BIN} /bin/mamba && \
    ln -s ${MICROMAMBA_BIN} /bin/conda && \
    ln -s ${MICROMAMBA_BIN} /bin/miniconda && \
    mkdir -p $(dirname $MAMBA_ROOT_PREFIX) && \
    ${MICROMAMBA_BIN} shell init -s bash -p $MAMBA_ROOT_PREFIX && \
    echo "micromamba activate base" >> /root/.bashrc

# Install conda-pack to use it outside the environment
# No need to remove /opt/conda/pkgs/ or '*.a', '*.pyc' and '*.js.map'
# Since this package is installed at the base environment and it not
# moved to the next stage
RUN micromamba install -c conda-forge conda-pack


COPY env.yaml /root/env.yaml

# Create environment without cleaning conda/pkgs, conda/pkgs and micromamba/pkgs
# As we clean them all when we unpack the content before being copied
# --no-deps
RUN  micromamba create -y -n ${ENV_NAME} -f /root/env.yaml && \
     micromamba activate ${ENV_NAME}
     
# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini


# Use conda-pack to create a standalone environment in /venv:
# We've put venv in same path it'll be in final image, so now fix up paths.
# micromamba clean --all which remove index cache.
# micromamba clean command cleans /opt/conda/pkgs /opt/conda/pkgs/cache/*
# 	
# https://github.com/mamba-org/mamba/blob/master/src/micromamba/clean.cpp
RUN conda-pack -p ${ENV_PATH} -o /tmp/env.tar && \
    mkdir ${ENV_FOLDER} && cd ${ENV_FOLDER} && tar xf /tmp/env.tar && \
    rm /tmp/env.tar && \
    ${ENV_FOLDER}/bin/conda-unpack && \
    micromamba clean --all && \
    rm -rf /opt/conda/pkgs && \
    rm -rf /root/micromamba/pkgs/ && \
    find /opt/conda/ -follow -type f,l -name '*.a' -delete && \
    find /opt/conda/ -follow -type f,l -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f,l -name '*.js.map' -delete
  # find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete


# The runtime-stage image; we can use Debian as the
# base image since the Conda environment already includes Python for us.
FROM ${BASE_CONTAINER} AS runtime

USER root

# Clean up
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    rm -rf /var/lib/{apt,dpkg,cache,log} && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge --auto-remove && \
    apt-get clean

# RUN useradd -m -r user && \
    # chown user ${ENV_FOLDER}

# Copy ${ENV_FOLDER} from the previous stage:
COPY --from=stage2 ${ENV_FOLDER} ${ENV_FOLDER}
COPY --from=stage2 /usr/bin/tini /usr/bin/tini
COPY bin/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/bin/tini && chmod 777 /usr/local/bin/entrypoint.sh && ln -s /usr/local/bin/entrypoint.sh

SHELL ["/usr/bin/tini", "--"]

# Make sure we use the venv:
ENV PATH="${ENV_FOLDER}/bin:$PATH"

# When image is run, run the code with the environment
# activated:
SHELL ["/bin/bash", "-c"]

# Expose Jupyterlab default port
EXPOSE 8888

# Expose notebooks
VOLUME /workspace

# Working directory notebooks
WORKDIR /workspace

# Convert to non-root user

# Entrypoint
ENTRYPOINT ["entrypoint.sh"]
