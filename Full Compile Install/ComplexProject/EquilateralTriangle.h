#ifndef EQUILATERAL_H
#define EQUILATERAL_H

#include "Triangle.h"

class EquilateralTriangle : public Triangle {
private:
public:
  EquilateralTriangle();
  bool validate() override;
};

#endif