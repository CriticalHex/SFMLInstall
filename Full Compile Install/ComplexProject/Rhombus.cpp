#include "Rhombus.h"
#include "IsoscelesTriangle.h"

Rhombus::Rhombus() {}

bool Rhombus::validate() {
  IsoscelesTriangle t1, t2;
  t1.setCoordinate(0, _vertices[0].position);
  t1.setCoordinate(1, _vertices[1].position);
  t1.setCoordinate(2, _vertices[2].position);
  t2.setCoordinate(0, _vertices[0].position);
  t2.setCoordinate(1, _vertices[2].position);
  t2.setCoordinate(2, _vertices[3].position);
  double s1 = getSideLength(0, 1), s2 = getSideLength(1, 2),
         s3 = getSideLength(2, 3), s4 = getSideLength(3, 0);
  return s1 == s2 && s2 == s3 && s3 == s4 && t1.validate() && t2.validate();
}