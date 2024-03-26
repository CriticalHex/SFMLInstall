#ifndef POLYGON_H
#define POLYGON_H

#include <SFML\Graphics.hpp>

class Polygon {
private:
  sf::Color _color;

public:
  // sets the color to white, specifies the number of vertices as 0, sets the
  // vertices array to be a nullptr
  Polygon();

  // deallocates the vertices array
  virtual ~Polygon();

  // sets the private color data member
  void setColor(const sf::Color);

  // creates a ConvexShape, sets the
  // points for each coordinate, sets the fill color, draws it to the
  // provided window
  void draw(sf::RenderTarget &);

  // function that sets the corresponding coordinate in the vertices array
  void setCoordinate(const int, sf::Vector2f);

  // function that returns true if the set coordinates form the
  // intended polygon
  virtual bool validate() = 0;

  double getSideLength(uint16_t, uint16_t);

protected:
  sf::VertexArray _vertices;
};

#endif