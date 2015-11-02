# vim: set sw=2 ts=2 softtabstop=2 expandtab:
FROM symbooglix/mono_z3_base:icst16
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV SBX_REVISION=29d1d2297b686e0163b6c18e76a90b47c23d561e \
    BUILD_TYPE=Release \
    NUGET_URL=https://dist.nuget.org/win-x86-commandline/v2.8.6/nuget.exe

USER root
RUN pip install lit OutputCheck
ADD *.yml /home/${CONTAINER_USER}/
RUN chown ${CONTAINER_USER}: *.yml
USER ${CONTAINER_USER}

# Get Symbooglix
RUN git clone git://github.com/symbooglix/symbooglix.git && cd symbooglix \
    git checkout ${SBX_REVISION} && \
    git submodule init && \
    git submodule update && \
    wget ${NUGET_URL} -O nuget.exe && \
    mono ./nuget.exe restore src/Symbooglix.sln && \
    xbuild /p:Configuration=${BUILD_TYPE} /p:Platform=X86 src/Symbooglix.sln && \
    ln -s /usr/bin/z3 src/SymbooglixDriver/bin/${BUILD_TYPE}/z3.exe && \
    ln -s /usr/bin/z3 src/Symbooglix/bin/${BUILD_TYPE}/z3.exe

# Put sbx.exe in the user's PATH
RUN echo 'export PATH=$PATH:/home/${CONTAINER_USER}/symbooglix/src/SymbooglixDriver/bin/${BUILD_TYPE}' >> \
    /home/${CONTAINER_USER}/.bashrc
