FROM buildpack-deps:bionic
LABEL version="14"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y gnupg2

RUN set -ex; \
	dist=$(grep DISTRIB_CODENAME /etc/lsb-release | cut -d= -f2); \
	echo "deb http://ppa.launchpad.net/ethereum/cpp-build-deps/ubuntu $dist main" >> /etc/apt/sources.list ; \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1c52189c923f6ca9 ; \
	apt-get update; \
	apt-get install -qqy --no-install-recommends \
		build-essential \
		software-properties-common \
		cmake ninja-build \
		libboost-filesystem-dev libboost-test-dev libboost-system-dev \
		libboost-program-options-dev \
		clang jq git\