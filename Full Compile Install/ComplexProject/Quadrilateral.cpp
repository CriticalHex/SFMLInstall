#include "Quadrilateral.h"

Quadrilateral::Quadrilateral() {
  _vertices.resize(4);
  _vertices.setPrimitiveType(sf::PrimitiveType::Quads);
}
