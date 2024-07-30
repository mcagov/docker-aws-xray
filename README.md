# Image to run local AWS XRay

Branches are used for the various versions

To build locally

    docker build -t 009543623063.dkr.ecr.eu-west-2.amazonaws.com/aws-xray:latest .

To run

see https://docs.aws.amazon.com/xray/latest/devguide/xray-daemon-local.html

    docker run -t -i --rm 009543623063.dkr.ecr.eu-west-2.amazonaws.com/aws-xray
