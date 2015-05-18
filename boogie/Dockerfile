# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM symbooglix/mono_z3_base:ase15
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV BOOGIE_REVISION=fde61624bc8b47a947d0da8a76632e8b8aeaacb6

# Unfortunately we can't do a shallow clone because we need
# to check out a particular revision
RUN git clone https://github.com/boogie-org/boogie.git && \
    cd boogie/ && \
    git checkout ${BOOGIE_REVISION} && \
    wget https://nuget.org/nuget.exe && \
    mono ./nuget.exe restore Source/Boogie.sln && \
    xbuild /p:Configuration=Release Source/Boogie.sln && \
    ln -s /usr/bin/z3 Binaries/z3.exe

# Put Boogie.exe in the user's PATH
RUN echo 'export PATH=$PATH:/home/ase/boogie/Binaries' >> /home/ase/.bashrc
