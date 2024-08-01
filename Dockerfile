FROM 009543623063.dkr.ecr.eu-west-2.amazonaws.com/amazonlinux

LABEL maintainer="info@catapult.cx"
LABEL org.label-schema.description="Base nodejs image"

ARG AWS_REGION=eu-west-2
RUN curl -o daemon.zip https://s3.${AWS_REGION}.amazonaws.com/aws-xray-assets.${AWS_REGION}/xray-daemon/aws-xray-daemon-linux-3.x.zip

RUN unzip daemon.zip && cp xray /usr/bin/xray

EXPOSE 2000/udp
EXPOSE 2000/tcp

ENTRYPOINT ["/usr/bin/xray", "-t", "0.0.0.0:2000", "-b", "0.0.0.0:2000"]
