#include "Triangle.h"

Triangle::Triangle() {
  _vertices.resize(3);
  _vertices.setPrimitiveType(sf::PrimitiveType::Triangles);
}

bool Triangle::isTriangle(double l1, double l2, double l3) {
  if (l1 != 0 && l2 != 0 && l3 != 0 && l1 + l2 > l3 && l1 + l3 > l2 &&
      l3 + l1 > l2)
    return true;
  return false;
}
