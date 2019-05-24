FROM mcr.microsoft.com/windows/servercore:1803

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; \
    Install-Package -Name microsoft-visual-cpp-build-tools -RequiredVersion 14.0.25420.1 -Force; \
    Install-Package -Name netfx-4.5.2-devpack -RequiredVersion 4.5.5165101 -Force; \
    Install-Package -Name vcredist2015 -RequiredVersion 14.0.24215.20170201 -Force; \
    Install-Package -Name fxcop -RequiredVersion 10.0.30319.20180212 -Force;

ENV FXCOP_PATH="C:\Program Files (x86)\Microsoft Fxcop 10.0"

RUN $env:PATH = $env:FXCOP_PATH + ';' + $env:PATH; \
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

RUN New-Item -Path C:\fxcop -ItemType SymbolicLink -Value $env:FXCOP_PATH;


