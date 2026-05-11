CC = gcc

CFLAGS = -O2 -Wall -lm

TARGET = introsort

SRC = main.c introsort.c

all:
	$(CC) $(SRC) $(CFLAGS) -o $(TARGET)

run: all
	./$(TARGET)

clean:
	rm -f $(TARGET)