FROM alpine:3.19.1

COPY requirements.txt .

RUN apk --update --no-cache add \
  ca-certificates \
  git \
  openssh-client \
  openssl \
  py3-cryptography \
  py3-pip \
  py3-yaml \
  python3 \
  && apk --update --no-cache add --virtual .build-deps \
  build-base \
  curl \
  libffi-dev \
  openssl-dev \
  python3-dev \
  && pip3 install --no-cache-dir --upgrade --break-system-packages --no-binary :all: -r requirements.txt \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/* \
  && find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
  && find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

CMD [ "ansible", "--version" ]
