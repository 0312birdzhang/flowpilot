FROM ubuntu:24.04

RUN apt update && apt install -y capnproto pkg-config m4 libtool automake autoconf openjdk-17-jdk patchelf python3-venv unzip libssl-dev libgdbm-compat-dev liblzma-dev libbz2-dev cmake zlib1g-dev git python3-pip swig zip libffi-dev wget capnproto libcapnp-dev sudo gcc-arm-none-eabi libeigen3-dev
RUN git config --global --add safe.directory '*'

COPY capnproto-java /capnproto-java
WORKDIR /capnproto-java
RUN make && make install

RUN python3 -m venv ~/.venv
RUN ~/.venv/bin/pip install buildozer setuptools cython
RUN ~/.venv/bin/pip install scons numpy pycryptodome pycapnp
RUN ~/.venv/bin/pip install pyyaml certifi hatanaka casadi future-fstrings
