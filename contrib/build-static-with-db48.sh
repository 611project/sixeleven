SIXELEVEN_ROOT=$(pwd)/..

# Pick some paths to install BDB and OpenSSL
# we create directories within the contrib directory
BDB_PREFIX="${SIXELEVEN_ROOT}/contrib/db48"
OPENSSL_PREFIX="${SIXELEVEN_ROOT}/contrib/openssl"

# fetch, build and install BDB 4.8 to $BDB_PREFIX
[[ -d $BDB_PREFIX ]] || \
  ( \
    wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz' \
    && echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c \
    && tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz \
    && rm db-4.8.30.NC/dist/config.guess db-4.8.30.NC/dist/config.sub \
    && wget -O db-4.8.30.NC/dist/config.guess "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=55eaf3e779455c4e5cc9f82efb5278be8f8f900b" \
    && wget -O db-4.8.30.NC/dist/config.sub "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=55eaf3e779455c4e5cc9f82efb5278be8f8f900b" \
    && cd db-4.8.30.NC \
    && patch -p1 < ../db48-patch/atomic_clang.patch \
    && cd db-4.8.30.NC/build_unix/ \
    && ../dist/configure --enable-cxx --disable-shared --disable-replication --with-pic --prefix=$BDB_PREFIX \
    && make \
    && mkdir -p $BDB_PREFIX \
    && make install \
    && cd ../../ && rm -R db-4.8.30.NC \
  )

# fetch, build and install OpenSSL 1.0.2 to $OPENSSL_PREFIX
[[ -d $OPENSSL_PREFIX ]] || \
  ( \
    wget -O openssl.tar.gz 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2u.tar.gz' \
    && echo '82fa58e3f273c53128c6fe7e3635ec8cda1319a10ce1ad50a987c3df0deeef05  openssl.tar.gz' | sha256sum -c \
    && mkdir openssl-src \
    && tar -C ./openssl-src --strip 1 -xvzf openssl.tar.gz && rm openssl.tar.gz \
    && cd openssl-src \
    && ./config --prefix=$OPENSSL_PREFIX \
    && make \
    && mkdir -p $OPENSSL_PREFIX \
    && make install \
    && cd .. && rm -R openssl-src \
  )

# Compile 611d with our own-built instance of BDB 4.8 and OpenSSL 1.0.2
mkdir -p $SIXELEVEN_ROOT/build \
  && cd $SIXELEVEN_ROOT/src \
  && make \
  && install 611d $SIXELEVEN_ROOT/build \
  && make clean

# Return to contrib
cd $SIXELEVEN_ROOT/contrib
