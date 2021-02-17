FROM python:3.8-slim-buster

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git && apt-get clean

RUN curl https://pyenv.run | bash

ENV PYENV_ROOT "/root/.pyenv"
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN /root/.pyenv/bin/pyenv install 3.7-dev
RUN /root/.pyenv/bin/pyenv install 3.8-dev
RUN /root/.pyenv/bin/pyenv install 3.9-dev

RUN pyenv global 3.7-dev 3.8-dev 3.9-dev system

RUN python -m pip install tox Cython
CMD ["python", "-m", "tox"]
