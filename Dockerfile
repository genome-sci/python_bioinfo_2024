# Use miniconda3:23.10.0-1 as the base image
FROM --platform=linux/amd64 condaforge/miniforge3:24.11.3-0


# Create the conda environment with Python 3.12
RUN mamba create -n pags2024 python=3.12

# Initialize conda in bash shell
# RUN, CMD, ENTRYPOINTが実行される際のshellを指定
# condaのpags2024環境内でbashを実行するようにしている (defaultでは ["/bin/bash", "-c"])
SHELL ["mamba", "run", "-n", "pags2024", "/bin/bash", "-c"]

# Install Jupyter and other specified packages
RUN mamba install -c conda-forge jupyter && \
    mamba install -c conda-forge matplotlib matplotlib-venn pandas seaborn && \
    mamba install -c bioconda biopython bcbio-gff

# This part does not work when using python 3.12. Use 3.11 instead.
# Install libraries for sc-seq analysis, if necessary.
# RUN mamba install -c conda-forge scanpy python-igraph leidenalg && \
#     mamba install -c conda-forge scvi-tools && \
#     mamba install -c bioconda scvelo && \
#     mamba install -c conda-forge -c bioconda cellrank && \
#     mamba install -c conda-forge scikit-misc
    

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Set the default environment to pags2024 when executing commands in the container
# RUN echo "mamba activate pags2024" >> /root/.bashrc
RUN mamba init && echo "mamba activate pags2024" >> /root/.bashrc


# Add source code to the container
COPY ./ /python_bioinfo_2024

# Set the working directory in the container
WORKDIR /python_bioinfo_2024


# Run Jupyter Notebook when the container launches
CMD ["mamba", "run", "-n", "pags2024", "--no-capture-output", "jupyter", "notebook", "--notebook-dir=/python_bioinfo_2024", "--ip='*'", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
# Equivalent as above, but using the shell.
# CMD jupyter notebook --notebook-dir=/python_bioinfo_2024 --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token=''
