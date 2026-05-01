FROM debian:stable

# Install X11 apps and basic libraries
RUN apt-get update && apt-get install -y x11-apps git emacs vim curl gcc g++ gdb valgrind screen \
    binutils electric-fence fzf exuberant-ctags iputils-ping tcpdump strace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies, download, and install Anaconda
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    wget --quiet https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# activate conda install
ENV PATH="/opt/conda/bin:${PATH}"

#install gemini cli
# Install dependencies and Node.js from NodeSource
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*
RUN npm install -g @google/gemini-cli

# Install paraview
RUN apt-get update && apt-get install -y paraview && \
    apt-clean && \
    rm -rf /var/lib/apt/lists/*

# Install a browser
RUN apt-get update && apt-get install -y \
    firefox-esr \ 
    libcanberra-gtk3-module \
    libdbus-glib-1-2 \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:0

# Install Dakota tools
# We don't build this because the build process requires far more dependencies to be added
# and can often take hours depending on the complexity. 
RUN wget https://github.com/snl-dakota/dakota/releases/download/v6.19.0/dakota-6.19.0-public-rhel8.Linux.x86_64-cli.tar.gz && \
    tar xvf dakota-6.19.0-public-rhel8.Linux.x86_64-cli.tar.gz dakota-6.19.0-public-rhel8.Linux.x86_64-cli && \
    mv dakota-6.19.0-public-rhel8.Linux.x86_64-cli /usr/local/bin/dakota && \
    rm dakota-6.19.0-public-rhel8.Linux.x86_64-cli.tar.gz

# Add users and switch to them, keep this layer on the end
RUN useradd -ms /bin/bash nick
USER nick
WORKDIR /home/nick

# Set environment variable for display
ENV DISPLAY=host.docker.internal:0.0
CMD ["/bin/bash"]
