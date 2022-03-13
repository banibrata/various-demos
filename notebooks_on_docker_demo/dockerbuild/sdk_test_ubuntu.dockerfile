
FROM ubuntu:18.04
# System packages
RUN apt-get update && apt-get install -y curl
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda
# Python packages from conda
RUN conda install -c anaconda -y python=3.7
RUN conda install -c anaconda -y pip
RUN conda init bash

#Choose your version of azcli
RUN echo "pip install azure-cli" | bash
#Choose your version of ml cli
RUN echo "az extension add -n ml" | bash

##This is to run jupyter as a back ground process
##Docker does not have background scheduler e.g. systemctl like nornal linux
##so little bit of hack to have the jupyter process running in the background and logs dumped into a log file

RUN pip install jupyterlab && jupyter notebook --generate-config
WORKDIR /root/.jupyter
COPY dockerbuild/jupyter_server_config.py jupyter_server_config.py
WORKDIR /root
COPY dockerbuild/.start.sh .start_jupyter.sh
COPY notebooks notebooks