# This docker image has LaTeX to build the vignettes
FROM bioconductor/bioconductor_docker:devel

RUN echo 'Iniciando actualizaciones...'

# Update apt-get
RUN apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y --no-install-recommends \
	texlive \
	texlive-latex-extra \
	texlive-fonts-extra \
	texlive-bibtex-extra \
	texlive-science \
	texi2html \
	texinfo \
	unzip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

## Install fastqc
RUN echo 'Instalando FASTQC...'
RUN apt install default-jre
RUN java -version
RUN mkdir /fastqc
RUN cd /fastqc
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
RUN unzip fastqc_v0.12.1.zip
RUN chmod 755 fastqc
RUN sudo ln -s /fastqc/FASTQC/fastqc /bin/fastqc

RUN echo 'fin FASTQC...'

RUN echo 'Instalando paquetes...'

#RUN R -e ''
# Software packages

RUN R -e 'BiocManager::install("BiocStyle")'

RUN R -e 'BiocManager::install("Rsubread")'
RUN R -e 'browseVignettes("Rsubread")'

# Workflow packages

RUN R -e 'BiocManager::install("seqpac")'
RUN R -e 'browseVignettes("seqpac")'

RUN echo 'Listo!'