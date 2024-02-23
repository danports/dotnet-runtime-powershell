# We use Ubuntu rather than the default Debian image for historical reasons - either should work.
FROM mcr.microsoft.com/dotnet/runtime:6.0-focal AS base
# We install netbase since this image lacks an /etc/services file, and that's a problem: https://github.com/Microsoft/omi/issues/623
# We install gss-ntlmssp since it is needed for PowerShell authentication.
# We install libldap-2.4-2 since it is needed for System.DirectoryServices.Protocols.
RUN apt-get update && \
    apt-get install -y gss-ntlmssp wget netbase libldap-2.4-2 && \
    # Ubuntu in its Focal release no longer includes the ancient libssl1.0.0 package in its default repositories - a wise choice.
    # Unfortunately, libpsrpcclient still depends upon it, so we need to install it manually.
    wget http://snapshot.debian.org/archive/debian/20190501T215844Z/pool/main/g/glibc/multiarch-support_2.28-10_amd64.deb && \
    dpkg -i multiarch-support_2.28-10_amd64.deb && \
    rm multiarch-support_2.28-10_amd64.deb && \
    wget https://snapshot.debian.org/archive/debian/20170705T160707Z/pool/main/o/openssl/libssl1.0.0_1.0.2l-1~bpo8%2B1_amd64.deb && \
    dpkg -i libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb && \
    rm libssl1.0.0_1.0.2l-1~bpo8+1_amd64.deb && \
    apt-get clean