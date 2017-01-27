FROM registry:2.6.0

ENV REGISTRY_STORAGE_DELETE_ENABLED=true
ADD ./run.sh /entrypoint.sh
