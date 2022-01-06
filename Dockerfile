FROM fedora:35

RUN dnf install -y sudo findutils tar bzip2 git python3-pip mock copr-cli && \
    dnf clean all

RUN useradd -u 1000 builder && \
    usermod -a -G mock builder

RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder
ENV HOME /home/builder
WORKDIR ${HOME}

# Create symlinks for easier development
RUN sudo ln -s /mockfiles/mariner-1.tpl /etc/mock/templates/mariner-1.tpl
RUN sudo ln -s /mockfiles/mariner-1-x86_64.cfg /etc/mock/mariner-1-x86_64.cfg
RUN sudo ln -s /mockfiles/mariner-1-aarch64.cfg /etc/mock/mariner-1-aarch64.cfg

# COPY *.src.rpm /

# run with 
# sudo docker run --privileged -v /path/to/Dockerfiles:/mockfiles -it mock-tester:latest /bin/bash