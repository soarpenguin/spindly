# libspdy makefile
#
CC=gcc

CFLAGS += -Werror -Wall -Wextra -Wformat=2 -std=c89 -pedantic -DDEBUG -I./includes/ -Wno-overlength-strings
LDFLAGS +=

SRCS_SPDY += src/spdy_data.c
SRCS_SPDY += src/spdy_frame.c
SRCS_SPDY += src/spdy_control_frame.c
SRCS_SPDY += src/spdy_syn_stream.c
SRCS_SPDY += src/spdy_syn_reply.c
SRCS_SPDY += src/spdy_rst_stream.c
SRCS_SPDY += src/spdy_headers.c
SRCS_SPDY += src/spdy_data_frame.c
SRCS_SPDY += src/spdy_nv_block.c
SRCS_SPDY += src/spdy_zlib.c
SRCS_SPDY += src/spdy_stream.c
SRCS_SPDY += src/spdy_string.c
HDRS_SPDY = $(SRCS_SPDY,.c=.h)
OBJS_SPDY = $(SRCS_SPDY:.c=.o)

SRCS_TEST =  tests/check_spdy.c
SRCS_TEST += tests/check_spdy_frame.c
SRCS_TEST += tests/check_spdy_control_frame.c
SRCS_TEST += tests/check_spdy_syn_stream.c
SRCS_TEST += tests/check_spdy_syn_reply.c
SRCS_TEST += tests/check_spdy_rst_stream.c
SRCS_TEST += tests/check_spdy_data_frame.c
SRCS_TEST += tests/check_spdy_nv_block.c
SRCS_TEST += tests/check_spdy_zlib.c
SRCS_TEST += tests/testdata.c
OBJS_TEST = $(SRCS_TEST:.c=.o)
LIBS_TEST = `pkg-config --libs check` `pkg-config --libs zlib`
EXEC_TEST = tests/checks

AUX += $(HDRS_SPDY)

all: spdy

spdy: $(OBJS_SPDY)

checks_build: $(EXEC_TEST)

checks: checks_build
	$(EXEC_TEST)

$(EXEC_TEST): $(OBJS_SPDY) $(OBJS_TEST)
	$(CC) $(CFLAGS) $(LDFLAGS) -g $(OBJS_SPDY) $(OBJS_TEST) $(LIBS_TEST) -o $(EXEC_TEST)

create_nv_block: spdy
	$(CC) $(CFLAGS) $(LDFLAGS) -g $(OBJS_SPDY) `pkg-config --libs zlib` bin/create_nv_block.c -o bin/$@

read_dump: spdy
	$(CC) $(CFLAGS) $(LDFLAGS) -g $(OBJS_SPDY) `pkg-config --libs zlib` bin/read_dump.c -o bin/$@

read_stream: spdy
	$(CC) $(CFLAGS) $(LDFLAGS) -g $(OBJS_SPDY) `pkg-config --libs zlib` bin/read_stream.c -o bin/$@

doc:
	doxygen Doxyfile

clean:
	rm $(OBJS_SPDY)||true
	rm $(OBJS_TEST)||true
	rm $(EXEC_TEST)||true

splint:
	splint +posixlib src/*.c

cloc:
	cloc bin/ src/ tests/

tags:
	ctags -R src/

gource:
	gource -640x480 -a 1 --file-idle-time 0 --hide date --disable-progress --stop-at-end --output-ppm-stream - | ffmpeg -y -b 3000k -r 60 -f image2pipe -vcodec ppm -i - -fpre /usr/share/ffmpeg/libx264-medium.ffpreset -vcodec libx264 gource.mp4

.PHONY: doc tags
