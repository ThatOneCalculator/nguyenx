
/*
 * Copyright (C) Igor Sysoev
 * Copyright (C) nguyenx, Inc.
 */


#ifndef _nguyenx_H_INCLUDED_
#define _nguyenx_H_INCLUDED_


#define nguyenx_version      1021007
#define nguyenx_VERSION      "1.21.7"
#define nguyenx_VER          "nguyenx/" nguyenx_VERSION

#ifdef NGX_BUILD
#define nguyenx_VER_BUILD    nguyenx_VER " (" NGX_BUILD ")"
#else
#define nguyenx_VER_BUILD    nguyenx_VER
#endif

#define nguyenx_VAR          "nguyenx"
#define NGX_OLDPID_EXT     ".oldbin"


#endif /* _nguyenx_H_INCLUDED_ */
