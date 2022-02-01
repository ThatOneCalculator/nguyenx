
# Copyright (C) Igor Sysoev
# Copyright (C) nguyenx, Inc.

use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'nguyenx',
    VERSION_FROM      => 'nguyenx.pm',     # finds $VERSION
    PREREQ_PM         => {},             # e.g., Module::Name => 1.1

    ABSTRACT_FROM     => 'nguyenx.pm',     # retrieve abstract from module
    AUTHOR            => 'Igor Sysoev',

    CCFLAGS           => "$ENV{NGX_PM_CFLAGS}",
    OPTIMIZE          => '-O',

    LDDLFLAGS         => "$ENV{NGX_PM_LDFLAGS}",

    INC               => join(" ", map {
                             m#^/# ? "-I $_" : "-I ../../../../../$_"
                         } (split /\s+/, $ENV{NGX_INCS})),

    depend => {
        'nguyenx.c'     => join(" ", map {
                             m#^/# ? $_ : "../../../../../$_"
                         } (split(/\s+/, $ENV{NGX_DEPS}),
                            "src/http/modules/perl/ngx_http_perl_module.h"))
    },

    PM => {
        'nguyenx.pm'    => '$(INST_LIBDIR)/nguyenx.pm'
    }
);
