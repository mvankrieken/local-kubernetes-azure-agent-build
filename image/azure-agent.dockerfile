FROM ubuntu:22.04

USER root

# Also can be "linux-arm", "linux-arm64".
ENV TARGETARCH="linux-x64"
ENV TZ="Europe/Amsterdam"
ENV DEBIAN_FRONTEND="noninteractive"

# Install defaults
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y curl libicu70 software-properties-common jq

# Install tooling
RUN add-apt-repository -y ppa:rmescandon/yq && apt update && apt -y install docker-buildx git yq 

# Install python
COPY ./build-tools.sh ./
RUN chmod +x ./build-tools.sh
RUN ./build-tools.sh

# WORKDIR
WORKDIR /azp/
COPY ./start.sh ./
RUN chmod +x ./start.sh
COPY ./pypirc /home/root/.pypirc

# Another option is to run the agent as root.
ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ["./start.sh"]