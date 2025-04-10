# Build & Run

1. docker build -t ansible .
2. docker run --rm -it ansible /bin/bash
3. ansible-playbook -i inventory.ini local.yml --ask-vault-pass

## Npm certificate

1. openssl s_client -showcerts -connect registry.npmjs.org:443 </dev/null | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/' > npm-registry-cert.pem
