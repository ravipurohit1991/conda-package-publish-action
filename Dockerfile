FROM continuumio/miniconda3:4.11.0

LABEL "repository"="https://github.com/ravipurohit1991/conda-package-publish-action"
LABEL "maintainer"="Ravi Purohit <purushot@esrf.fr>"

RUN conda install -c conda-forge -y mamba==0.27
RUN mamba install -y -c conda-forge anaconda-client conda-build conda-verify boa

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
