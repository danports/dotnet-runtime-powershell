# We use Ubuntu rather than the default Debian image for historical reasons - either should work.
FROM mcr.microsoft.com/dotnet/runtime:5.0-focal AS base
# We install netbase since this image lacks an /etc/services file, and that's a problem: https://github.com/Microsoft/omi/issues/623
# We install gss-ntlmssp since it is needed for PowerShell authentication.
RUN apt-get update && \
    apt-get install -y gss-ntlmssp wget netbase && \
    # Ubuntu in its Focal release no longer includes the ancient libssl1.0.0 package in its default repositories - a wise choice.
    # Unfortunately, libpsrpcclient still depends upon it, so we need to install it manually.
    wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.7_amd64.deb && \
    dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.7_amd64.deb && \
    rm libssl1.0.0_1.0.2n-1ubuntu5.7_amd64.deb && \
    apt-get clean