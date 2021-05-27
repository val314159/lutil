liblutil.dylib: src/*.c src/*.h
	$(CC) $(CFLAGS) -shared -o $@ src/*.c
all:
	./test.ros
clean:
	rm -fr *.dylib *~

