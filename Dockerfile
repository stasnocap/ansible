FROM debian:bookworm AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS prime
ARG TAGS
RUN addgroup --gid 1000 stasnocap
RUN adduser --gecos stasnocap --uid 1000 --gid 1000 --disabled-password stasnocap
USER stasnocap
WORKDIR /home/stasnocap/

FROM prime
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
