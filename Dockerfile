FROM continuumio/miniconda3:4.12.0

LABEL "repository"="https://github.com/ravipurohit1991/conda-package-publish-action"
LABEL "maintainer"="Ravi Purohit <purushot@esrf.fr>"

RUN conda install -y conda-build conda-verify anaconda-client

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
