TARGET = Main.exe # this is where you name the executable.
SRC_FILES = main.cpp #you list out all the source files for your program here. See the complex project for an example. If they're in folders, you'll need to provide the relative (or absoulte) path.

OBJECTS = $(SRC_FILES:.cpp=.o)

INCLUDE_PATH = -I"C:\mingw64\include"

LIBS = -lsfml-graphics -lsfml-window -lsfml-system
LIB_PATH = -L"C:\mingw64\lib"

CXX = g++

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@$(CXX) -o $@ $^ $(LIB_PATH) $(LIBS)

%.o: %.cpp
	@$(CXX) -c $< -o $@ $(INCLUDE_PATH)

clean:
	@del $(OBJECTS) $(TARGET)

run:
	@$(TARGET)

.PHONY: clean run
