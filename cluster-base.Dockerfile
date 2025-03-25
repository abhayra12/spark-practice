ARG java_image_tag=17-jre
FROM eclipse-temurin:${java_image_tag}

# -- Layer: OS + Python

ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace} && \
    apt-get update && \
    apt-get install -y python3 python3-pip bash curl git && \
    rm -f /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python

ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]