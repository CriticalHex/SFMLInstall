#ifndef TRIANGE_H
#define TRIANGE_H

#include "Polygon.h"

class Triangle : public Polygon {
private:
public:
  Triangle();
  bool isTriangle(double, double, double);
};
#endif