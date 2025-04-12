FROM debian:bookworm AS base
WORKDIR /usr/local/bin

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo software-properties-common curl git build-essential ansible ca-certificates && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

# damn work issues
COPY npm-registry-cert.pem /usr/local/share/ca-certificates/npm-registry-cert.crt
RUN update-ca-certificates

FROM base AS prime
ARG TAGS
RUN echo "stasnocap ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stasnocap
RUN addgroup --gid 1000 stasnocap
RUN adduser --gecos stasnocap --uid 1000 --gid 1000 --disabled-password stasnocap
USER stasnocap
WORKDIR /home/stasnocap/ansible

FROM prime
COPY --chown=stasnocap:stasnocap . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
