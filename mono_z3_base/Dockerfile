# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM symbooglix/user_base:ase15
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

# Get Mono 3.12.1 . Perhaps we should build it ourselves
# because we had to patch it to avoid crashes when calling
# System.Environment.Exit()
#
# https://github.com/mono/mono/pull/1649
RUN apt-get update && apt-get -y install wget && \
    wget -O - http://download.mono-project.com/repo/xamarin.gpg |apt-key add - && \
    echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/3.12.0 main" > /etc/apt/sources.list.d/mono-xamarin.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C504E590 && \
    echo 'deb http://ppa.launchpad.net/delcypher/gpuverify-smt/ubuntu trusty main' > /etc/apt/sources.list.d/smt.list && \
    apt-get update

# Setup Mono and Z3 4.3.2
# FIXME: This is overkill, we don't need everything from mono
RUN apt-get -y install mono-devel z3=4.3.2-0~trusty1

WORKDIR /home/${CONTAINER_USER}/
USER ${CONTAINER_USER}
