#ifndef SPDY_ERROR_H_
#define SPDY_ERROR_H_ 1

enum SPDY_ERRORS
{
  SPDY_ERROR_NONE = 0,
  SPDY_ERROR_MALLOC_FAILED,
  SPDY_ERROR_INSUFFICIENT_DATA,
  SPDY_ERROR_INVALID_DATA,
  SPDY_ERROR_ZLIB_DEFLATE_FAILED,
  SPDY_ERROR_ZLIB_INFLATE_FAILED,
  SPDY_ERROR_ZLIB_DEFLATE_INIT_FAILED,
  SPDY_ERROR_ZLIB_INFLATE_INIT_FAILED,
  SPDY_ERROR_ZLIB_DEFLATE_DICT_FAILED,
  SPDY_ERROR_ZLIB_INFLATE_DICT_FAILED,
  SPDY_ERROR_STREAM_RST,
  SPDY_ERROR_STREAM_FIN,
  SPDY_ERROR_TOO_SMALL_BUFFER,
};

#endif
