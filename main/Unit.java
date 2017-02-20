import java.lang.Math;

abstract class Unit {
  float x, y;
  
  Unit(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  boolean is_moving = false;
  float target_x, target_y;
  
  private float myrnd(float max) { //?
    // small numbers appear more often
    float tmp = (float)Math.random() * max;
    return (float)Math.random() * tmp;
  }
  
  void set_target(float target_x, float target_y) { //?
    is_moving = true;
    this.target_x = target_x + myrnd(0.5f);
    this.target_y = target_y + myrnd(0.5f);
  }
  
  void stop() {
    is_moving = false;
  }
  
  void step() {
    if (!is_moving)
      return;
    
    float dx = target_x - x;
    float dy = target_y - y;
    float l2 = dx*dx + dy*dy;
    float step_l = 0.04f;
    
    if (l2 <= step_l * step_l) {
      x = target_x;
      y = target_y;
      is_moving = false;
      return;
    }
    
    float l = (float)Math.sqrt(l2);
    float k = step_l / l;
    x += dx * k;
    y += dy * k;
  }
}

class MyUnit extends Unit { //?
  MyUnit(float x, float y) {
    super(x, y);
  }
  
  boolean is_selected = false;
}

class Enemy extends Unit {
  Enemy(float x, float y) {
    super(x, y);
  }
}
