#!/bin/bash
set -e

if [ "$1" = '611d' ]; then
	mkdir -p "$SIXELEVEN_DATA"

	if [ ! -s "$SIXELEVEN_DATA/611.conf" ]; then
		cat <<-EOF > "$SIXELEVEN_DATA/611.conf"
		printtoconsole=1
		rpcpassword=${SIXELEVEN_RPC_PASSWORD:-$(dd if=/dev/urandom bs=22 count=1 status=none | base64)}
		rpcuser=${SIXELEVEN_RPC_USER:-sixeleven}
		dns=1
		noirc=1
		EOF
	fi

	if [ ! -e "$SIXELEVEN_RPC_PASSWORD" ]; then
		cat $SIXELEVEN_DATA/611.conf
	fi

	chown -R sixeleven "$SIXELEVEN_DATA"
	exec gosu sixeleven "$@"
fi

exec "$@"
