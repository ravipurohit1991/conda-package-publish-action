FROM continuumio/miniconda3:4.12.0

LABEL "repository"="https://github.com/ravipurohit1991/conda-package-publish-action"
LABEL "maintainer"="Ravi Purohit <purushot@esrf.fr>"

RUN conda install -y conda-build conda-verify anaconda-client
RUN conda install -y -c conda-forge mamba
RUN conda update mamba
RUN mamba install libarchive=3.5.2=hb890918_2 -y
RUN mamba install -y -c conda-forge anaconda-client conda-build conda-verify boa

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
