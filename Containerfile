FROM registry.access.redhat.com/ubi9/ubi:latest

ARG MINIO_RPM=https://dl.min.io/server/minio/release/linux-amd64/archive/minio-20240217011557.0.0-1.x86_64.rpm
ARG CONSOLE_PORT=9001
ARG API_PORT=9000

ENV CONSOLE_PORT=${CONSOLE_PORT}
ENV API_PORT=${API_PORT}

EXPOSE ${CONSOLE_PORT}/tcp
EXPOSE ${API_PORT}/tcp

USER root

RUN dnf -y update && dnf -y upgrade && dnf -y install wget && mkdir ~/minio

WORKDIR ~/minio

RUN wget ${MINIO_RPM} -O minio.rpm && dnf -y install minio.rpm && rm minio.rpm

CMD ["minio", "server", "~/minio", "--console-address", ":${CONSOLE_PORT}"]
