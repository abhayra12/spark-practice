FROM cluster-base

# -- Layer: Apache Spark (Lightweight)

ARG spark_version=3.3.1
ARG hadoop_version=3

RUN apk add --no-cache wget && \
    mkdir -p /tmp/spark && cd /tmp/spark && \
    wget --timeout=20 --tries=3 --retry-connrefused \
    https://dlcdn.apache.org/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -O spark.tgz || \
    wget --timeout=20 --tries=3 --retry-connrefused \
    https://downloads.apache.org/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -O spark.tgz || \
    wget --timeout=20 --tries=3 --retry-connrefused \
    https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -O spark.tgz && \
    tar -xzf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir -p /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    cd / && rm -rf /tmp/spark

ENV SPARK_HOME=/usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version} \
    SPARK_MASTER_HOST=spark-master \
    SPARK_MASTER_PORT=7077 \
    PYSPARK_PYTHON=python3

# -- Runtime

WORKDIR ${SPARK_HOME}