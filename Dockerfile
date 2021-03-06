FROM rust:1.60

USER root

RUN apt-get update -y --fix-missing && \
    apt-get install -y build-essential cmake jupyter-notebook libzmq3-dev

RUN rustup component add rust-src && \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && rm -f get-pip.py && \
    pip install jupyterlab && pip install -U jupyter_client

RUN curl -fsSL https://fnm.vercel.app/install | bash

ENV PATH="${PATH}:/root/.fnm"

RUN fnm install v16.14.2 && \
    fnm default v16.14.2 && \
    eval "`fnm env`" && \
    npm install -g ijavascript && \
    ijsinstall --spec-path=full

RUN pip install jupyter-lsp jupyterlab-lsp && \
    curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | \
    gunzip -c - > /usr/local/bin/rust-analyzer && \
    chmod +x /usr/local/bin/rust-analyzer


CMD [ "jupyter", "lab", "--port", "8888", "--ip=0.0.0.0", "--allow-root" ]
