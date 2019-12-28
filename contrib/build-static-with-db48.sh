SIXELEVEN_ROOT=$(pwd)/..

# Pick some paths to install BDB and OpenSSL
# we create directories within the contrib directory
BDB_PREFIX="${SIXELEVEN_ROOT}/contrib/db48"
mkdir -p $BDB_PREFIX
OPENSSL_PREFIX="${SIXELEVEN_ROOT}/contrib/openssl"
mkdir -p $OPENSSL_PREFIX

# Fetch the DB48 source and verify that it is not tampered with
wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c
# -> db-4.8.30.NC.tar.gz: OK
tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz
# bugfix DB48 build: atomic error
patch db-4.8.30.NC/dbinc/atomic.h < db48-patch/atomic.patch

# Build the library and install to our prefix
cd db-4.8.30.NC/build_unix/ \
  && ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$BDB_PREFIX \
  && make install \
  && cd ../../ && rm -R db-4.8.30.NC

# Load the latest OpenSSL 1.0.2 source
wget -O openssl.tar.gz 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2u.tar.gz'
echo '82fa58e3f273c53128c6fe7e3635ec8cda1319a10ce1ad50a987c3df0deeef05  openssl.tar.gz' | sha256sum -c
# -> openssl.tar.gz: OK
mkdir openssl-src \
  && tar -C ./openssl-src --strip 1 -xvzf openssl.tar.gz && rm openssl.tar.gz \
  && cd openssl-src \
  && ./config --prefix=$OPENSSL_PREFIX \
  && make install \
  && cd .. && rm -R openssl-src

# Configure Bitcoin Core to use our own-built instance of BDB
cd $SIXELEVEN_ROOT/src
make
