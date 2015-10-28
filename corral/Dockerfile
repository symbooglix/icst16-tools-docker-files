# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM symbooglix/mono_z3_base:icst16
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV CORRAL_REVISION=3aa62d7425b57295f698c6f47d3ce1910f5f5f8d \
    BOOGIE_REVISION=1550a8112d172a37a168b048b5c78642bc39bf90

ADD *.yml /home/${CONTAINER_USER}/
USER root
RUN chown ${CONTAINER_USER}: *.yml
USER ${CONTAINER_USER}

# Get Boogie
# Unfortunately we can't do a shallow clone because we need
# to check out a particular revision
RUN git clone https://github.com/boogie-org/boogie.git && \
    cd boogie/ && \
    git checkout ${BOOGIE_REVISION} && \
    wget https://nuget.org/nuget.exe && \
    mono ./nuget.exe restore Source/Boogie.sln && \
    xbuild /p:Configuration=Release Source/Boogie.sln && \
    ln -s /usr/bin/z3 Binaries/z3.exe

# Unfortunately we can't do a shallow clone because we need
# to check out a particular revision
# NOTE: The clone sometimes fails. I think this is a codeplex issue
RUN git clone https://git.codeplex.com/corral && \
    cd corral/ && \
    git checkout ${CORRAL_REVISION} && \
    cp ~/boogie/Binaries/*.dll references/ && \
    cp ~/boogie/Binaries/*.mdb references/ && \
    xbuild /p:Configuration=Release cba.sln && \
    ln -s /usr/bin/z3 /home/${CONTAINER_USER}/corral/bin/Release/z3.exe

# Put corral.exe in the user's PATH
RUN echo 'export PATH=$PATH:/home/${CONTAINER_USER}/corral/bin/Release' >> \
    /home/${CONTAINER_USER}/.bashrc
