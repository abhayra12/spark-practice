FROM eclipse-temurin:17-jre-alpine

# -- Layer: OS + Python

ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace} && \
    apk add --no-cache python3 bash curl git && \
    ln -s /usr/bin/python3 /usr/bin/python

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"] 