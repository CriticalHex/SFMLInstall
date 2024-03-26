#include "Polygon.h"
#include <cmath>

Polygon::Polygon() { setColor(sf::Color::White); }

Polygon::~Polygon() {}

void Polygon::setColor(const sf::Color color) {
  _color = color;
  for (int i = 0; i < _vertices.getVertexCount(); i++) {
    _vertices[i].color = _color;
  }
}

void Polygon::draw(sf::RenderTarget &window) { window.draw(_vertices); }

void Polygon::setCoordinate(const int IDX, sf::Vector2f pos) {
  _vertices[IDX].position = pos;
}

double Polygon::getSideLength(uint16_t idx1, uint16_t idx2) {
  return round(
      sqrt(pow(_vertices[idx1].position.x - _vertices[idx2].position.x, 2) +
           pow(_vertices[idx1].position.y - _vertices[idx2].position.y, 2)));
}