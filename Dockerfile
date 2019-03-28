FROM mcr.microsoft.com/dotnet/core/runtime:2.1 AS base
RUN apt-get update && apt-get install -y gss-ntlmssp && echo 'http            80/tcp          www www-http' > /etc/services
# TODO: Clear apt cache.