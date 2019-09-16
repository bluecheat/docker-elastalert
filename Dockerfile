FROM ubuntu:18.04

LABEL description="ElastAlert suitable for Kubernetes and image"
LABEL maintainer="gochact (itsinil@gmail.com)"

ENV CONTAINER_TIMEZONE Asia/Seoul
ENV CONFIG_DIR /opt/config
ENV RULES_DIR /opt/rules
ENV ELASTALERT_CONFIG ${CONFIG_DIR}/elastalert_config.yaml
ENV LOG_DIR /opt/logs
ENV ELASTALERT_HOME /opt/elastalert
ENV ELASTALERT_INDEX elastalert_status

ARG ELASTALERT_VERSION=0.2.1

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install curl vim language-pack-ko build-essential python-setuptools python3 python3-dev libssl-dev git tox python3-pip libffi-dev
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

RUN mkdir -p ${CONFIG_DIR} && \
    mkdir -p ${RULES_DIR}
COPY ./config ${CONFIG_DIR}
COPY ./run.sh ./requirements.txt ./requirements-dev.txt ${ELASTALERT_HOME}/
WORKDIR ${ELASTALERT_HOME}

ENV TZ UTC

RUN pip install -r requirements-dev.txt
RUN pip install elastalert==${ELASTALERT_VERSION}
RUN rm -rf /var/cache/apt/*
RUN chmod +x /opt/elastalert/run.sh

#COPY ./rules ${RULES_DIR}

VOLUME [ "${CONFIG_DIR}", "${RULES_DIR}", "${LOG_DIR}" ]
# run elastalert
CMD "${ELASTALERT_HOME}/run.sh"

