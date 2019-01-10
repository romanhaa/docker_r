FROM r-base:3.5.1

RUN apt update -y && apt upgrade -y
RUN apt install -y \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip

# for curl and RCurl (R package)
RUN apt install -y \
  libcurl4-openssl-dev

# for openssl (R package)
RUN apt install -y libssl-dev

# for Cairo (R package)
RUN apt install -y \
  libcairo2-dev
  # libxt-dev

# for XML and xml2 (R package)
RUN apt install -y libxml2-dev

# for units (R package)
RUN apt install -y libudunits2-dev

# for hdf5r (R package)
RUN apt install -y libhdf5-dev

# for UMAP in Seurat (R package)
RUN pip install umap-learn
RUN pip3 install umap-learn

# use script here as soon as repo is public
ADD https://github.com/romanhaa/docker_r/archive/master.tar.gz /docker/
RUN tar -xvzf /docker/master.tar.gz -C /docker
RUN ls /docker
RUN Rscript /docker/docker_r-master/install_packages.R
# RUN Rscript -e 'install.packages("BiocManager", repos="http://cran.us.r-project.org")'
# RUN Rscript -e 'BiocManager::install(c("Seurat", "tidyverse", "reshape2", "scales", "gridExtra", "enrichR", "scran", "biomaRt", "Rmagic"))'
# test
# RUN Rscript -e 'Seurat::RunUMAP()'

CMD R
