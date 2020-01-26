FROM registry.redhat.io/openshift4/ose-operator-registry:latest
COPY manifests manifests
RUN /bin/initializer -o ./bundles.db
EXPOSE 50051
ENTRYPOINT ["/bin/registry-server"]
CMD ["--database", "bundles.db"]
