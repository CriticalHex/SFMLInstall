TARGET = Main.exe
SRC_FILES = main.cpp Polygon.cpp Triangle.cpp Quadrilateral.cpp EquilateralTriangle.cpp IsoscelesTriangle.cpp ScaleneTriangle.cpp Rhombus.cpp

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

#below is dependencies. lots need polygon, like triangle, but some things need triangle, etc.

main.o: main.cpp Polygon.cpp
Polygon.o: Polygon.cpp
Triangle.o: Triangle.cpp Polygon.cpp
Quadrilateral.o: Quadrilateral.cpp Polygon.cpp
EquilateralTriangle.o: EquilateralTriangle.cpp Triangle.cpp
IsoscelesTriangle.o: IsoscelesTriangle.cpp Triangle.cpp
ScaleneTriangle.o: ScaleneTriangle.cpp Triangle.cpp
Rhombus.o: Rhombus.cpp Quadrilateral.cpp