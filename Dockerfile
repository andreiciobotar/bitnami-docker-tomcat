FROM gcr.io/stacksmith-images/minideb:jessie-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=8.0.39-r5 \
    BITNAMI_APP_NAME=tomcat \
    BITNAMI_APP_USER=tomcat \
    PATH=/opt/bitnami/$BITNAMI_APP_NAME/bin:/opt/bitnami/java/bin:$PATH

# System packages required
RUN install_packages --no-install-recommends libc6 libxext6 libx11-6 libxcb1 libxau6 libxdmcp6 libglib2.0-0 libfreetype6 libfontconfig1 libstdc++6 libgcc1 zlib1g libselinux1 libpng12-0 libexpat1 libffi6 libpcre3 libxml2 liblzma5

# Additional modules required
RUN bitnami-pkg install java-1.8.0_111-1 --checksum f7705a3955f006eb59a6e4240a01d8273b17ba38428d30ffe7d10c9cc525d7be

# Install tomcat
RUN bitnami-pkg unpack tomcat-8.0.39-3 --checksum 0b84cb324fa971d610eadbc7db1b2b00c8ca7a97ae4c527f193a94340f489c71
RUN ln -sf /opt/bitnami/$BITNAMI_APP_NAME/data /app

COPY rootfs /

#VOLUME ["/bitnami/$BITNAMI_APP_NAME"]
VOLUME ["/opt/bitnami"]

EXPOSE 8080

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "tomcat"]
