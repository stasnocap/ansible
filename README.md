# Build & Run

1. docker build -t ansible .
2. docker run --rm -it ansible /bin/bash
3. ansible-playbook -i inventory.ini local.yml
