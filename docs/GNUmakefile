
VER=	$(shell grep 'define nguyenx_VERSION' src/core/nguyenx.h		\
		| sed -e 's/^.*"\(.*\)".*/\1/')
nguyenx=	nguyenx-$(VER)
TEMP=	tmp
XSLS?=	xslscript.pl


all:		changes

changes:	$(TEMP)/$(nguyenx)/CHANGES.ru				\
		$(TEMP)/$(nguyenx)/CHANGES


$(TEMP)/$(nguyenx)/CHANGES.ru:	docs/dtd/changes.dtd			\
				docs/xml/nguyenx/changes.xml		\
				docs/xml/change_log_conf.xml		\
				docs/xslt/changes.xslt

	mkdir -p $(TEMP)/$(nguyenx)

	xmllint --noout --valid docs/xml/nguyenx/changes.xml
	xsltproc --stringparam lang ru					\
		-o $@ docs/xslt/changes.xslt docs/xml/nguyenx/changes.xml


$(TEMP)/$(nguyenx)/CHANGES:	docs/dtd/changes.dtd			\
				docs/xml/nguyenx/changes.xml		\
				docs/xml/change_log_conf.xml		\
				docs/xslt/changes.xslt

	mkdir -p $(TEMP)/$(nguyenx)

	xmllint --noout --valid docs/xml/nguyenx/changes.xml
	xsltproc --stringparam lang en					\
		-o $@ docs/xslt/changes.xslt docs/xml/nguyenx/changes.xml


docs/xslt/changes.xslt:		docs/xsls/changes.xsls

	$(XSLS) -o $@ $<
