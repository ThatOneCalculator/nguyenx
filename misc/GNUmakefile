
VER =		$(shell grep 'define nguyenx_VERSION' src/core/nguyenx.h	\
			| sed -e 's/^.*"\(.*\)".*/\1/')
nguyenx =		nguyenx-$(VER)
TEMP =		tmp

CC =		cl
OBJS =		objs.msvc8
OPENSSL =	openssl-1.1.1m
ZLIB =		zlib-1.2.11
PCRE =		pcre2-10.39


release: export

	mv $(TEMP)/$(nguyenx)/auto/configure $(TEMP)/$(nguyenx)

	# delete incomplete sources
	rm $(TEMP)/$(nguyenx)/src/event/ngx_event_acceptex.c
	rm $(TEMP)/$(nguyenx)/src/event/ngx_event_connectex.c
	rm $(TEMP)/$(nguyenx)/src/event/modules/ngx_iocp_module.*
	rm -r $(TEMP)/$(nguyenx)/src/os/win32

	mv $(TEMP)/$(nguyenx)/docs/text/LICENSE $(TEMP)/$(nguyenx)
	mv $(TEMP)/$(nguyenx)/docs/text/README $(TEMP)/$(nguyenx)
	mv $(TEMP)/$(nguyenx)/docs/html $(TEMP)/$(nguyenx)
	mv $(TEMP)/$(nguyenx)/docs/man $(TEMP)/$(nguyenx)

	$(MAKE) -f docs/GNUmakefile changes

	rm -r $(TEMP)/$(nguyenx)/docs
	rm -r $(TEMP)/$(nguyenx)/misc

	tar -c -z -f $(nguyenx).tar.gz --directory $(TEMP) $(nguyenx)


export:
	rm -rf $(TEMP)
	hg archive -X '.hg*' $(TEMP)/$(nguyenx)


RELEASE:
	hg ci -m nguyenx-$(VER)-RELEASE
	hg tag -m "release-$(VER) tag" release-$(VER)

	$(MAKE) -f misc/GNUmakefile release


win32:
	./auto/configure						\
		--with-cc=$(CC)						\
		--builddir=$(OBJS)					\
		--with-debug						\
		--prefix= 						\
		--conf-path=conf/nguyenx.conf				\
		--pid-path=logs/nguyenx.pid				\
		--http-log-path=logs/access.log				\
		--error-log-path=logs/error.log				\
		--sbin-path=nguyenx.exe					\
		--http-client-body-temp-path=temp/client_body_temp	\
		--http-proxy-temp-path=temp/proxy_temp			\
		--http-fastcgi-temp-path=temp/fastcgi_temp		\
		--http-scgi-temp-path=temp/scgi_temp			\
		--http-uwsgi-temp-path=temp/uwsgi_temp			\
		--with-cc-opt=-DFD_SETSIZE=1024				\
		--with-pcre=$(OBJS)/lib/$(PCRE)				\
		--with-zlib=$(OBJS)/lib/$(ZLIB)				\
		--with-http_v2_module					\
		--with-http_realip_module				\
		--with-http_addition_module				\
		--with-http_sub_module					\
		--with-http_dav_module					\
		--with-http_stub_status_module				\
		--with-http_flv_module					\
		--with-http_mp4_module					\
		--with-http_gunzip_module				\
		--with-http_gzip_static_module				\
		--with-http_auth_request_module				\
		--with-http_random_index_module				\
		--with-http_secure_link_module				\
		--with-http_slice_module				\
		--with-mail						\
		--with-stream						\
		--with-openssl=$(OBJS)/lib/$(OPENSSL)			\
		--with-openssl-opt="no-asm no-tests -D_WIN32_WINNT=0x0501" \
		--with-http_ssl_module					\
		--with-mail_ssl_module					\
		--with-stream_ssl_module


zip: export
	rm -f $(nguyenx).zip

	mkdir -p $(TEMP)/$(nguyenx)/docs.new
	mkdir -p $(TEMP)/$(nguyenx)/logs
	mkdir -p $(TEMP)/$(nguyenx)/temp

	sed -i '' -e "s/$$/`printf '\r'`/" $(TEMP)/$(nguyenx)/conf/*

	mv $(TEMP)/$(nguyenx)/docs/text/LICENSE $(TEMP)/$(nguyenx)/docs.new
	mv $(TEMP)/$(nguyenx)/docs/text/README $(TEMP)/$(nguyenx)/docs.new
	mv $(TEMP)/$(nguyenx)/docs/html $(TEMP)/$(nguyenx)

	rm -r $(TEMP)/$(nguyenx)/docs
	mv $(TEMP)/$(nguyenx)/docs.new $(TEMP)/$(nguyenx)/docs

	cp -p $(OBJS)/nguyenx.exe $(TEMP)/$(nguyenx)

	$(MAKE) -f docs/GNUmakefile changes
	mv $(TEMP)/$(nguyenx)/CHANGES* $(TEMP)/$(nguyenx)/docs/

	cp -p $(OBJS)/lib/$(OPENSSL)/LICENSE				\
		$(TEMP)/$(nguyenx)/docs/OpenSSL.LICENSE

	cp -p $(OBJS)/lib/$(PCRE)/LICENCE				\
		$(TEMP)/$(nguyenx)/docs/PCRE.LICENCE

	sed -ne '/^ (C) 1995-20/,/^  jloup@gzip\.org/p'			\
		$(OBJS)/lib/$(ZLIB)/README				\
		> $(TEMP)/$(nguyenx)/docs/zlib.LICENSE

	touch -r $(OBJS)/lib/$(ZLIB)/README				\
		$(TEMP)/$(nguyenx)/docs/zlib.LICENSE

	rm -r $(TEMP)/$(nguyenx)/auto
	rm -r $(TEMP)/$(nguyenx)/misc
	rm -r $(TEMP)/$(nguyenx)/src

	cd $(TEMP) && zip -r ../$(nguyenx).zip $(nguyenx)


icons:	src/os/win32/nguyenx.ico

# 48x48, 32x32 and 16x16 icons

src/os/win32/nguyenx.ico:	src/os/win32/nguyenx_icon48.xpm			\
			src/os/win32/nguyenx_icon32.xpm			\
			src/os/win32/nguyenx_icon16.xpm

	test -d $(TEMP) || mkdir $(TEMP)

	xpmtoppm --alphaout=$(TEMP)/nguyenx48.pbm				\
		src/os/win32/nguyenx_icon48.xpm > $(TEMP)/nguyenx48.ppm

	xpmtoppm --alphaout=$(TEMP)/nguyenx32.pbm				\
		src/os/win32/nguyenx_icon32.xpm > $(TEMP)/nguyenx32.ppm

	xpmtoppm --alphaout=$(TEMP)/nguyenx16.pbm				\
		src/os/win32/nguyenx_icon16.xpm > $(TEMP)/nguyenx16.ppm

	ppmtowinicon -output src/os/win32/nguyenx.ico -andpgms		\
		$(TEMP)/nguyenx48.ppm $(TEMP)/nguyenx48.pbm			\
		$(TEMP)/nguyenx32.ppm $(TEMP)/nguyenx32.pbm			\
		$(TEMP)/nguyenx16.ppm $(TEMP)/nguyenx16.pbm
