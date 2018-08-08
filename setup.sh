#!/bin/bash

if [ "$1" = "" ]; then
	printf "\nProvide a link for USEARCH download (from email) as argument.\nGet a license from http://www.drive5.com/usearch/download.html\nSee RMarkdown file for details.\n\n"
    exit 1
fi

wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-2.3.0-MacOSX-x86_64.sh
bash Anaconda-2.3.0-MacOSX-x86_64.sh

anaconda/bin/conda create -n STECEnv python pip numpy matplotlib=1.4.3 scipy pandas cython mock nose
source anaconda/bin/activate STECEnv
pip install https://github.com/biocore/qiime/archive/1.9.0.tar.gz

anaconda/bin/conda install -c r r r-XML
anaconda/bin/conda install -c https://conda.binstar.org/asmeurer pandoc
anaconda/bin/conda install -c https://conda.anaconda.org/r rpy2=2.5.6

wget -O anaconda/envs/STECEnv/bin/usearch $1
chmod 775 anaconda/envs/STECEnv/bin/usearch 