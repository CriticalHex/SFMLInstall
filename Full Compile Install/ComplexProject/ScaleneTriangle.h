#ifndef SCALENE_H
#define SCALENE_H

#include "Triangle.h"

class ScaleneTriangle : public Triangle {
private:
public:
  ScaleneTriangle();
  bool validate() override;
};

#endif