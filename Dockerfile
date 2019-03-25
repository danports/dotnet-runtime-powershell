FROM microsoft/dotnet:2.1-runtime AS base
RUN apt update && apt install -y libssl1.0.0