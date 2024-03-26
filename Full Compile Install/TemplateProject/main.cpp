#include <SFML\Graphics.hpp>

using namespace std;

int main() {
  sf::RenderWindow window(sf::VideoMode(1920, 1080), "Drawing Shapes",
                          sf::Style::Fullscreen);
  window.setFramerateLimit(144);
  sf::Event event;

  sf::CircleShape c1, c2, c3, c4, c5, c6;
  sf::RectangleShape r1;
  sf::Vector2f center(window.getSize().x / 2.f, window.getSize().y / 2.f);
  int radius = 50;
  int diameter = radius * 2;
  c1.setRadius(radius);
  c2.setRadius(radius);
  c3.setRadius(radius);
  c4.setRadius(radius);
  c5.setRadius(radius);
  c6.setRadius(radius);
  center.y -= radius;
  center.x -= radius;
  c1.setPosition(center);
  c2.setPosition(center.x, center.y - diameter);
  c3.setPosition(center.x + 0.866 * diameter, center.y + 0.5 * diameter);
  c4.setPosition(center.x + 0.866 * diameter, center.y - 0.5 * diameter);
  c5.setPosition(center.x - 0.866 * diameter, center.y + 0.5 * diameter);
  c6.setPosition(center.x - 0.866 * diameter, center.y - 0.5 * diameter);
  c1.setFillColor(sf::Color::Green);
  c2.setFillColor(sf::Color::Green);
  c3.setFillColor(sf::Color::Green);
  c4.setFillColor(sf::Color::Green);
  c5.setFillColor(sf::Color::Green);
  c6.setFillColor(sf::Color::Green);
  r1.setFillColor(sf::Color(165, 103, 41));
  r1.setSize(sf::Vector2f(50, 250));
  r1.setPosition(center.x + radius / 2.f, center.y + diameter);

  while (window.isOpen()) {
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed) {
        window.close();
      }

      if (sf::Keyboard::isKeyPressed(sf::Keyboard::LControl) || sf::Keyboard::isKeyPressed(sf::Keyboard::Q)) {
        window.close();
      }
    }

    window.clear(sf::Color::Black);

    window.draw(r1);
    window.draw(c1);
    window.draw(c2);
    window.draw(c3);
    window.draw(c4);
    window.draw(c5);
    window.draw(c6);

    window.display();
  }
}