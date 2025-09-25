FROM amazonlinux:2023 AS dotnet10build

# install Zscaler cert
COPY Zscaler-Root-CA.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

# ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates
# ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates
# ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates

# Install dependencies
RUN yum -y update && \
yum -y install --allowerasing libicu \
tar findutils gzip make git wget unzip which curl && \
yum clean all

# Install .NET SDK (use .NET 8 or later)
ENV DOTNET_SDK_CHANNEL=10.0
RUN curl -SL --output /tmp/dotnet-install.sh https://builds.dotnet.microsoft.com/dotnet/scripts/v1/dotnet-install.sh
RUN chmod +x /tmp/dotnet-install.sh
RUN  /tmp/dotnet-install.sh --channel $DOTNET_SDK_CHANNEL --install-dir /usr/share/dotnet
RUN ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN rm -fv /tmp/dotnet-install.sh

ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH="$PATH:/usr/share/dotnet"
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV SSL_CERT_FILE=/tmp/noop

ENTRYPOINT ["dotnet"]
CMD [ "--version" ]
