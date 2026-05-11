CXX = g++

CXXFLAGS = -O2 -Wall

TARGET = introsort

SRC = main.cpp introsort.cpp

all:
	$(CXX) $(SRC) $(CXXFLAGS) -o $(TARGET)

run: all
	./$(TARGET)

clean:
	rm -f $(TARGET)