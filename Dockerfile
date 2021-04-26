FROM public.ecr.aws/ubuntu/ubuntu:20.04

EXPOSE 8555
EXPOSE 8444

ENV VERSION=1.1.2

COPY docker-entrypoint.sh /usr/local/bin
COPY healthcheck.sh /usr/local/bin

RUN apt-get update
RUN apt-get install -y python3.8-venv python3.8-distutils sudo git lsb-release
RUN git clone https://github.com/Chia-Network/chia-blockchain.git && cd chia-blockchain && git checkout tags/$VERSION -b $VERSION && sh install.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
