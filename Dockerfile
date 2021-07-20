FROM rust:1.50 as rust

USER root

RUN apt-get update -y --fix-missing && \
    apt-get install -y build-essential cmake jupyter-notebook libzmq3-dev

RUN rustup install nightly && \
    rustup override add nightly && \
    rustup component add rust-src && \
    cargo install evcxr_jupyter && \
    evcxr_jupyter --install

RUN pip3 install jupyterlab && pip3 install -U jupyter_client

CMD [ "jupyter", "lab", "--port", "8888", "--ip=0.0.0.0", "--allow-root" ]