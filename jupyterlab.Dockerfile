FROM cluster-base

# Install Python 3.9 and venv
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update -y && \
    apt-get install -y python3.9 python3.9-venv

# Create and activate virtual environment with Python 3.9
ENV VIRTUAL_ENV=/opt/venv
RUN python3.9 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install required packages in the virtual environment
ARG jupyterlab_version=3.6.1
ARG spark_version=3.3.1
RUN pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version}

# Set working directory
WORKDIR /opt/workspace

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]