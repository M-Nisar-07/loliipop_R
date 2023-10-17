FROM jianhong/trackviewer

RUN apt-get install -y libsodium-dev
RUN R -e "install.packages('sodium')"
RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('aws.s3')"
RUN R -e "install.packages('aws.ec2metadata')"
COPY . /app

ENTRYPOINT ["Rscript", "run_api.R"]