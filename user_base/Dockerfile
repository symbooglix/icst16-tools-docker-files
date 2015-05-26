# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM ubuntu:14.04
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV CONTAINER_USER=ase \
    BOOGIE_RUNNER_REVISION=9be74e6e12bac25befa0f4fb13ced040754b702a

# Create ``ase`` user for container with password ``ase``.
# Give it sudo access so it possible to install new packages inside the container.
# NEVER EVER EVER EVER USE THIS CONTAINER IN PRODUCTION DUE HOW EASY IT IS
# TO GET ROOT PRIVILIDGES WITH THE ``ase`` USER!
RUN useradd -m ${CONTAINER_USER} && \
    echo ${CONTAINER_USER}:${CONTAINER_USER} | chpasswd && \
    echo "${CONTAINER_USER}  ALL=(root) ALL" >> /etc/sudoers

WORKDIR /home/${CONTAINER_USER}/

# Upgrade existing packages and update package lists
RUN apt-get update && apt-get -y upgrade

# Setup Python
# Note python3-dev installs gcc. We need that so pyyaml gets built properly
# but remove gcc (and other bits) afterwards to save space
RUN apt-get -y --no-install-recommends install python3 python3-pip libyaml-dev git && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 && \
    apt-get -y install python3-dev && \
    pip install psutil pyyaml && \
    apt-get remove -y python3-dev && apt-get autoremove -y
USER ${CONTAINER_USER}
# Install boogie-runner
RUN git clone https://github.com/symbooglix/boogie-runner.git && \
    cd boogie-runner && \
    git checkout ${BOOGIE_RUNNER_REVISION} && \
    echo 'PATH=/home/${CONTAINER_USER}/boogie-runner:$PATH' >> \
         /home/${CONTAINER_USER}/.bashrc

USER root
