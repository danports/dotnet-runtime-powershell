# We use Ubuntu rather than the default Debian image because this image correctly packages the old libssl & libcrypto versions that libpsrpcclient depends upon.
FROM mcr.microsoft.com/dotnet/core/runtime:3.1-bionic AS base
# This image lacks an /etc/services file, so we supply one to work around this issue: https://github.com/Microsoft/omi/issues/623
RUN apt-get update && apt-get install -y gss-ntlmssp && echo 'http            80/tcp          www www-http' > /etc/services
# TODO: Clear apt cache.
