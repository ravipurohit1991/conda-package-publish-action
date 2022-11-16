FROM continuumio/miniconda3:4.11.0

LABEL "repository"="https://github.com/ravipurohit1991/conda-package-publish-action"
LABEL "maintainer"="Ravi Purohit <purushot@esrf.fr>"

RUN conda install -y conda-build conda-verify anaconda-client
RUN conda install -c conda-forge -y mamba==0.23.3
RUN mamba install -y -c conda-forge anaconda-client conda-build conda-verify boa

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
