# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/minimal-notebook
FROM $BASE_CONTAINER

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install Graphviz and Latex
RUN apt-get update && apt-get install -y \
  apt-utils \
  strace \
  graphviz \
  && rm -rf /var/lib/apt/lists/* \ 
  && apt-get update && apt-get clean && apt-get install -y build-essential \
  && apt-get install -y software-properties-common \
  && apt update \
  && add-apt-repository universe \
  && apt-get install -y texlive-full
  
  
  
#  texlive-latex-base texlive-binaries texlive-pictures texlive-latex-extra texlive-luatex



# Julia dependencies
# install Julia packages in /opt/julia instead of ${HOME}
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia

# Setup Julia
RUN /opt/setup-scripts/setup_julia.py

USER ${NB_UID}

# Setup IJulia kernel & other packages
RUN /opt/setup-scripts/setup-julia-packages.bash

RUN  julia -e 'import Pkg; Pkg.update(); Pkg.add(["Git", "Convex", "SCS", "Compose", "JSON3", "TikzPictures", "Colors", "Documenter", "Literate", "PrettyTables", "LaTeXStrings", "TikzCDs", "GATlab", "Catlab", "DataStructures", "AlgebraicRewriting", "DataMigrations" ]); Pkg.precompile();'
#"LabelledArrays", "OrdinaryDiffEq", "Plots", 

RUN pip install -U jupyterlab-git

# RUN <<-EOF
#   cat <<- STARTUP_SCRIPT > /home/jovyan/.ipython/profile_default/startup/00-xx.jl

#   STARTUP_SCRIPT
# EOF
