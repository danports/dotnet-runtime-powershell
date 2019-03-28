FROM mcr.microsoft.com/dotnet/core/runtime-deps:2.1-bionic AS base
RUN apt-get update && apt-get install -y gss-ntlmssp
# TODO: Clear apt cache.