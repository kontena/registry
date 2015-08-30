FROM registry:2.1

ADD ./run.sh /run.sh

ENTRYPOINT "/run.sh"
