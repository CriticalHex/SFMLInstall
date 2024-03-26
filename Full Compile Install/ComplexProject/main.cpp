#include "EquilateralTriangle.h"
#include "IsoscelesTriangle.h"
#include "Rhombus.h"
#include "ScaleneTriangle.h"
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

int main() {
  vector<Polygon *> polygons;
  ifstream file("polygons.dat");
  double c1x, c1y, c2x, c2y, c3x, c3y, c4x, c4y;
  char type;
  int r, g, b;
  Polygon *shape;
  while (file >> type) {
    file >> c1x >> c1y >> c2x >> c2y >> c3x >> c3y;
    if (type == 'R')
      file >> c4x >> c4y;
    file >> r >> g >> b;
    switch (type) {
    case 'R': {
      shape = new Rhombus();
      shape->setCoordinate(3, sf::Vector2f(c4x, c4y));
      break;
    }
    case 'E': {
      shape = new EquilateralTriangle();
      break;
    }
    case 'I': {
      shape = new IsoscelesTriangle();
      break;
    }
    case 'S': {
      shape = new ScaleneTriangle();
      break;
    }
    }
    shape->setCoordinate(0, sf::Vector2f(c1x, c1y));
    shape->setCoordinate(1, sf::Vector2f(c2x, c2y));
    shape->setCoordinate(2, sf::Vector2f(c3x, c3y));
    shape->setColor(sf::Color(r, g, b));
    if (shape->validate())
      polygons.push_back(shape);
    else {
      cout << "polygon is invalid - \"" << type << " " << c1x << " " << c1y
           << " " << c2x << " " << c2y << " " << c3x << " " << c3y << " ";
      if (type == 'R')
        cout << c4x << " " << c4y << " ";
      cout << r << " " << g << " " << b << "\"" << endl;
    }
  }
  sf::RenderWindow window(sf::VideoMode(1920, 1080), "Shapes", sf::Style::None);
  sf::Event event;
  while (window.isOpen()) {
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed)
        window.close();
      if (event.type == sf::Event::KeyPressed) {
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Q)) {
          window.close();
        }
      }
    }
    window.clear(sf::Color::Black);

    for (auto shape : polygons) {
      shape->draw(window);
    }

    window.display();
  }
  for (auto shape : polygons) {
    delete shape;
    shape = nullptr;
  }
  polygons.clear();
  return 0;
}