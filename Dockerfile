FROM ghcr.io/douglasparker/byond/byond:514.1589
WORKDIR /opt/naruto-evolution
COPY naruto-evolution.dmb naruto-evolution.rsc VERSION* PRERELEASE* CHANGELOG.md  ./