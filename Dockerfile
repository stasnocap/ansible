FROM debian:bookworm AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo software-properties-common curl git build-essential ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS prime
ARG TAGS
RUN addgroup --gid 1000 stasnocap
RUN adduser --gecos stasnocap --uid 1000 --gid 1000 --disabled-password stasnocap
RUN echo "stasnocap ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stasnocap
USER stasnocap
WORKDIR /home/stasnocap/

FROM prime
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
