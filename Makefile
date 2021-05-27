liblutil.dylib: *.c *.h
	$(CC) $(CFLAGS) -shared -o $@ *.c
all:
	./test.ros
