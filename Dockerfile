FROM jianhong/trackviewer

RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('aws.s3')"
RUN R -e "install.packages('aws.s3')"
RUN R -e "install.packages('aws.ec2metadata')"
COPY . /app

CMD ["/app/plumber.R"]