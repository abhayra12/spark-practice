FROM spark-base

# -- Layer: JupyterLab

ARG jupyterlab_version=3.6.1
ARG spark_version=3.3.1

RUN apk add --no-cache py3-pip bash git && \
    pip3 install --no-cache-dir pyspark==${spark_version} jupyterlab==${jupyterlab_version} \
    jupyterlab-git notebook-shim nbclassic

# Configure git in Jupyter
RUN pip3 install --no-cache-dir jupyterlab-git

# Create config directory to persist Jupyter settings
RUN mkdir -p /root/.jupyter

# Create a config file that persists theme and other settings
COPY jupyter_lab_config.py /root/.jupyter/

# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root 