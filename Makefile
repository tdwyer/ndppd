ifdef DEBUG
CXXFLAGS ?= -g -DDEBUG
else
CXXFLAGS ?= -O3
endif

PREFIX  ?= usr
CXX             ?= g++
GZIP    ?= /usr/bin/gzip
MANDIR  ?= ${DESTDIR}/${PREFIX}/share/man
BINDIR  ?= ${DESTDIR}/${PREFIX}/bin

LIBS     =

OBJS     = src/logger.o src/ndppd.o src/iface.o src/proxy.o src/address.o \
		   src/rule.o src/session.o src/conf.o src/route.o

all: ndppd ndppd.1.gz ndppd.conf.5.gz

install: all
		mkdir -p ${BINDIR} ${MANDIR} ${MANDIR}/man1 ${MANDIR}/man5
		cp ndppd ${BINDIR}
		chmod +x ${BINDIR}/ndppd
		cp ndppd.1.gz ${MANDIR}/man1
		cp ndppd.conf.5.gz ${MANDIR}/man5

ndppd.1.gz:
		${GZIP} < ndppd.1 > ndppd.1.gz

ndppd.conf.5.gz:
		${GZIP} < ndppd.conf.5 > ndppd.conf.5.gz

ndppd: ${OBJS}
		${CXX} -o ndppd ${LDFLAGS} ${LIBS} ${OBJS}

.cc.o:
		${CXX} -c $(CXXFLAGS) -o $@ $<

clean:
		rm -f ndppd ndppd.conf.5.gz ndppd.1.gz ${OBJS}