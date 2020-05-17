# 611 (SixEleven) docker iamge

FROM debian:stretch

MAINTAINER 611project
ENV REFRESHED_AT 20200517

RUN groupadd -r sixeleven && useradd -r -m -g sixeleven sixeleven

# grab the latest 611 source code from git, compile, install and clean up
RUN set -ex \
	&& apt-get update \
	# install dependencies
	&& apt-get install -y --no-install-recommends ca-certificates wget \
		build-essential libssl1.0-dev gnupg dirmngr libboost-all-dev zlib1g-dev git gosu \
	# compile and install 611
	&& cd /usr/src \
	&& git clone https://github.com/611project/sixeleven.git sixeleven \
	&& cd sixeleven/contrib \
	&& ./build-static-with-db48.sh \
	&& cp ../src/611d /usr/local/bin \
	&& strip /usr/local/bin/611d \
	# cleanup
	&& cd ../.. && rm -rf /usr/src/sixeleven \
	&& apt-get -y purge build-essential libssl1.0-dev gnupg dirmngr libboost-all-dev zlib1g-dev git \
	&& apt-get -y autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV SIXELEVEN_DATA /sixeleven
RUN mkdir $SIXELEVEN_DATA \
	&& chown sixeleven:sixeleven $SIXELEVEN_DATA \
	&& ln -s $SIXELEVEN_DATA /home/sixeleven/.611
VOLUME ["/sixeleven"]

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8661 8663
CMD ["611d"]
