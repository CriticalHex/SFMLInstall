#ifndef RHOMBUS_H
#define RHOMBUS_H

#include "Quadrilateral.h"

class Rhombus : public Quadrilateral {
private:
public:
  Rhombus();
  bool validate() override;
};

#endif