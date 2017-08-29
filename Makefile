
REPOSITORY = https://github.com/pedroarthur/tcpreplay
REVISION   = v4.1.2-macrewrite-1

SOURCES_TYPES = *.c *.h *.def Makefile
define find
$(shell find $(1) -false $(addprefix -or -name , $(SOURCES_TYPES)))
endef

docker.build: tcpreplay.build
	docker build \
		--build-arg  http_proxy=$(http_proxy) \
	 	--build-arg https_proxy=$(https_proxy) \
		-t pedroarthur/tcpreplay:$(REVISION) .

docker.push: docker.build
	docker push pedroarthur/tcpreplay:$(REVISION)

tcpreplay.build: tcpreplay/src/tcpreplay

tcpreplay/src/tcpreplay: tcpreplay/.git $(call find,tcpreplay)
	find tcpreplay -name '*_opts.h' -or -name '*_opts.c' | xargs -r rm
	cd tcpreplay; ./autogen.sh && \
		./configure --disable-local-libopts --disable-libopts-install
	make -C tcpreplay

tcpreplay/.git:
	[ -d tcpreplay ] || mkdir tcpreplay
	git -C tcpreplay    clone $(REPOSITORY) .
	git -C tcpreplay checkout $(REVISION)

