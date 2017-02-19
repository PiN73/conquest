abstract class Unit {
  float x, y;
  
  Unit(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class MyUnit extends Unit {
  MyUnit(int x, int y) {
    super(x, y);
  }
}

class Enemy extends Unit {
  Enemy(int x, int y) {
    super(x, y);
  }
}