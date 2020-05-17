CXX=g++

DEFS=-D_MT -DNOPCH -DFOURWAYSSE2 -DUSE_SSL

# Detect MinGW
MINGW=$(shell uname -s|grep -i mingw32)

# Link boost statically
DEFS += -DBOOST_THREAD_USE_LIB

#INCLUDEPATHS= \
#	-I../libs/openssl-1.0.1i/include \
#	-I../libs/db-4.7.25.NC/build_unix \
#	-I../libs/boost_1_50_0
INCLUDEPATHS= \
	-I../contrib/db48/include -I../contrib/openssl/include

#LIBPATHS= \
#	-L../libs/openssl-1.0.1i \
#	-L../libs/db-4.7.25.NC/build_unix \
#	-L../libs/boost_1_50_0/stage/lib
LIBPATHS= \
	-L../contrib/db48/lib -L../contrib/openssl/lib

LIBBOOST_SUFFIX=

LIBS= \
 -Wl,-Bstatic \
   -l boost_system$(LIBBOOST_SUFFIX) \
   -l boost_filesystem$(LIBBOOST_SUFFIX) \
   -l boost_program_options$(LIBBOOST_SUFFIX) \
   -l boost_thread$(LIBBOOST_SUFFIX) \
   -l boost_chrono$(LIBBOOST_SUFFIX) \
   -l db_cxx \
   -l ssl \
   -l crypto

611: USE_UPNP:=1
	ifdef USE_UPNP
		LIBS += -l miniupnpc
		DEFS += -DUSE_UPNP=$(USE_UPNP)
	endif
	ifneq "$(MINGW)" ""
		# MinGW-specific
		DEFS += -D__NO_SYSTEM_INCLUDES -D__WXMSW__
		LIBS += -lws2_32 -lshlwapi -lmswsock -lole32 -loleaut32 -luuid -lgdi32
		LIBBOOST_SUFFIX=-mgw46-mt-1_50
	else
		# Linux-specific
		LIBS+= \
			-Wl,-Bdynamic \
			-l z \
			-l dl \
			-l pthread
	endif

611d: USE_UPNP:=0
	ifdef USE_UPNP
		LIBS += -l miniupnpc
		DEFS += -DUSE_UPNP=$(USE_UPNP)
	endif
	ifneq "$(MINGW)" ""
		# MinGW-specific
		DEFS += -D__NO_SYSTEM_INCLUDES -D__WXMSW__
		LIBS += -l mingwthrd -lws2_32 -lshlwapi -lmswsock -lole32 -loleaut32 -luuid -lgdi32
	else
		# Linux-specific
		LIBS+= \
			-Wl,-Bdynamic \
			-l z \
			-l dl \
			-l pthread
	endif

CXXFLAGS=-O2 -std=gnu++98 -Wno-invalid-offsetof -Wformat $(DEFS) $(INCLUDEPATHS)
HEADERS=headers.h strlcpy.h serialize.h uint256.h util.h key.h bignum.h base58.h \
    script.h allocators.h db.h walletdb.h crypter.h net.h irc.h keystore.h main.h wallet.h bitcoinrpc.h uibase.h ui.h noui.h init.h auxpow.h

OBJS= \
    obj/auxpow.o \
    obj/util.o \
    obj/key.o \
    obj/script.o \
    obj/db.o \
    obj/walletdb.o \
    obj/crypter.o \
    obj/net.o \
    obj/irc.o \
    obj/keystore.o \
    obj/main.o \
    obj/wallet.o \
    obj/bitcoinrpc.o \
    obj/init.o \
    cryptopp/obj/sha.o \
    cryptopp/obj/cpu.o

all: 611d


obj/%.o: %.cpp $(HEADERS)
	$(CXX) -c $(CXXFLAGS) -DGUI -o $@ $<

cryptopp/obj/%.o: cryptopp/%.cpp
	$(CXX) -c $(CXXFLAGS) -O3 -o $@ $<

obj/nogui/%.o: %.cpp $(HEADERS)
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/test/%.o: test/%.cpp $(HEADERS)
	$(CXX) -c $(CFLAGS) -o $@ $<

obj/nogui/611.o: 611.h

611d: $(OBJS:obj/%=obj/nogui/%) obj/nogui/611.o
	$(CXX) $(CXXFLAGS) -o $@ $(LIBPATHS) $^ $(LIBS)

clean:
	-rm -f 611 611d
	-rm -f obj/*.o
	-rm -f obj/nogui/*.o
	-rm -f obj/test/*.o
	-rm -f cryptopp/obj/*.o
	-rm -f headers.h.gch
