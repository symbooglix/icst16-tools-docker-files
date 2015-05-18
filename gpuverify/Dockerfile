FROM symbooglix/mono_z3_base:ase15
MAINTAINER Dan Liew <daniel.liew@imperial.ac.uk>

ENV BUGLE_REV=4ce4749e8c70d3640cfc4c172bd86230f906bd42 \
    LIBCLC_REV=225477 \
    LIBCLC_SVN_URL=http://llvm.org/svn/llvm-project/libclc/branches/release_35 \
    GPUVERIFY_REV=a41506612b9a742e6aabfcb213c86732aafd70ef

USER root
# Get keys, add repos and update apt-cache
RUN apt-get update && apt-get -y install wget && \
    wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|apt-key add - && \
    echo 'deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.5 main' > /etc/apt/sources.list.d/llvm.list && \
    apt-get update

# Setup LLVM, Clang 3.5
RUN apt-get -y install llvm-3.5 llvm-3.5-dev llvm-3.5-tools clang-3.5 libclang-3.5-dev && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.5 10 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.5 10 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/clang 50 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 50 && \
    update-alternatives --install /usr/bin/opt opt /usr/bin/opt-3.5 50 && \
    update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-3.5 50

# Setup Python
RUN apt-get -y --no-install-recommends install python python-dev python-pip && \
    ln -s /usr/bin/clang /usr/bin/x86_64-linux-gnu-gcc && \
    pip install psutil

# Install Other tools needed for build
RUN apt-get -y --no-install-recommends install cmake zlib1g-dev zlib1g mercurial git subversion make libedit-dev vim

USER ase

# Build Bugle
RUN mkdir bugle && cd bugle && mkdir build && \
    git clone git://github.com/mc-imperial/bugle.git src && \
    cd src/ && git checkout ${BUGLE_REV} && cd ../ && \
    cd build && \
    cmake -DLLVM_CONFIG_EXECUTABLE=/usr/bin/llvm-config-3.5 ../src && \
    make

# Libclc
RUN mkdir libclc && \
    cd libclc && \
    mkdir install && \
    svn co -r ${LIBCLC_REV} ${LIBCLC_SVN_URL} srcbuild && \
    cd srcbuild && \
    ./configure.py --with-llvm-config=/usr/bin/llvm-config-3.5 --prefix=/home/ase/libclc/install nvptx-- nvptx64-- && \
    make && \
    make install

# Build GPUVerify C# components
RUN hg clone https://hg.codeplex.com/gpuverify && \
    cd gpuverify && \
    hg update ${GPUVERIFY_REV} && \
    xbuild GPUVerify.sln && \
    ln -s /usr/bin/z3 Binaries/z3.exe

# Copy gvfindtoo.py from context
ADD gvfindtools.py /home/ase/gpuverify/

# Put GPUVerify in PATH
RUN echo 'PATH=/home/ase/gpuverify:$PATH' >> /home/ase/.bashrc
