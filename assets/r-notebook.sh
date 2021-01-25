#!/usr/bin/env bash

set -e

GIT_CONFIG="/home/jupyter/.gitconfig"

git config -f $GIT_CONFIG user.name "${name}"
git config -f $GIT_CONFIG user.email "${email}"


sudo apt-get update && \
sudo apt-get -y install build-essential libxml2-dev libcurl4-openssl-dev libssl-dev libv8-dev libudunits2-dev && \
sudo apt-get -y install r-cran-rcpp r-cran-inline r-cran-rcpp r-cran-nloptr r-cran-lme4 libgdal-dev libproj-dev libgeos-dev && \
sudo apt-get -y install jags && \
sudo apt-get -y install r-cran-mcmcpack && \

Rscript -e 'install.packages("rstan", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("rjags", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("blavaan", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("rstanarm", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("readstata13", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("emmeans", repos="https://cloud.r-project.org")'

# R-INLA

Rscript -e 'install.packages("units", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("rgdal", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("rgeos", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("sf", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("spdep", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("dependencies", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("graph", repos="https://cloud.r-project.org")'
Rscript -e 'install.packages("rgl", repos="https://cloud.r-project.org")' 
Rscript -e 'install.packages("Rgraphviz", repos="https://cloud.r-project.org")'

Rscript -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)'
