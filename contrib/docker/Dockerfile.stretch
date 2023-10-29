# 611 (SixEleven) Coin Wallet on Docker
FROM debian:stretch AS builder

MAINTAINER 611project
ENV REFRESHED_AT 20200517

# grab the latest 611 source code from git, compile, install and clean up
RUN set -ex; \
	apt-get update ; \
        apt-get upgrade ; \
	# install dependencies
	apt-get install -y --no-install-recommends ca-certificates wget \
		build-essential dirmngr libboost-all-dev zlib1g-dev git ; \
	# compile and install 611
	cd /usr/src ; \
	git clone https://github.com/611project/sixeleven.git sixeleven ; \
	cd sixeleven/contrib ; \
	./build-static-with-db48.sh ; \
	strip ../build/611d

FROM debian:stretch

RUN groupadd -r sixeleven && useradd -r -m -g sixeleven sixeleven

RUN set -ex; \
	apt-get update ; \
	apt-get upgrade ; \
	# install dependencies
	apt-get install -y --no-install-recommends ca-certificates \
		libgcc1 zlib1g gosu ; \
	# cleanup
	apt-get clean ; \
	rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/sixeleven/build/611d /usr/local/bin/

ENV SIXELEVEN_DATA /sixeleven
RUN mkdir $SIXELEVEN_DATA \
	&& chown sixeleven:sixeleven $SIXELEVEN_DATA \
	&& ln -s $SIXELEVEN_DATA /home/sixeleven/.611
VOLUME ["/sixeleven"]

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8661 8663
CMD ["611d"]
