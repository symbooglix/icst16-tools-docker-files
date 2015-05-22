# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM ubuntu:14.04
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV CONTAINER_USER=ase

# Create ``ase`` user for container with password ``ase``.
# Give it sudo access so it possible to install new packages inside the container.
# NEVER EVER EVER EVER USE THIS CONTAINER IN PRODUCTION DUE HOW EASY IT IS
# TO GET ROOT PRIVILIDGES WITH THE ``ase`` USER!
RUN useradd -m ${CONTAINER_USER} && \
    echo ${CONTAINER_USER}:${CONTAINER_USER} | chpasswd && \
    echo "${CONTAINER_USER}  ALL=(root) ALL" >> /etc/sudoers

WORKDIR /home/${CONTAINER_USER}/
