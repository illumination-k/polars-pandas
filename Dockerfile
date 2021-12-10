FROM rust:1.56 as rust

USER root

RUN apt-get update -y --fix-missing && \
    apt-get install -y build-essential cmake jupyter-notebook libzmq3-dev

RUN rustup component add rust-src && \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && rm -f get-pip.py && \
    pip install jupyterlab && pip install -U jupyter_client

CMD [ "jupyter", "lab", "--port", "8888", "--ip=0.0.0.0", "--allow-root" ]