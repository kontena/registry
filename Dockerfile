FROM registry:2.2

ADD ./run.sh /run.sh

ENTRYPOINT "/run.sh"
