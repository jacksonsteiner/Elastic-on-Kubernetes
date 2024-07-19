FROM elastic/apm-server:8.14.3
RUN apt update -y &&\
    apt upgrade -y
COPY --chmod=0644 --chown=1000:1000 apm-server.yaml /usr/share/apm-server/apm-server.yml