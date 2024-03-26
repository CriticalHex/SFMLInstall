#ifndef ISOSCELES_H
#define ISOSCELES_H

#include "Triangle.h"

class IsoscelesTriangle : public Triangle {
private:
public:
  IsoscelesTriangle();
  bool validate() override;
};

#endif