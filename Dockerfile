FROM microsoft/dotnet:2.1-runtime AS base
RUN curl --output libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && \
	apt-get update && \
	apt-get upgrade -y libkrb5-3 && \
	apt-get install -y krb5-multidev libkrb5-dev gss-ntlmssp
# TODO: Clear apt cache.