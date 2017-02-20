import java.util.ArrayList;

public class Game {
  Map map;
  ArrayList<MyUnit> myUnits;
  ArrayList<Enemy> enemies;
  
  Game(String mapFileName) { // 
    map = new Map(mapFileName);
    myUnits = new ArrayList<MyUnit>();
    enemies = new ArrayList<Enemy>();
    
    // add one unit in every my and enemy's territory:
    for(int y = 0; y < map.h; ++y)
      for(int x = 0; x < map.w; ++x)
        if (map.cell_type(x, y) == 1)  
          myUnits.add(new MyUnit(x + 0.5f, y + 0.5f));
        else if (map.cell_type(x, y) == 2)
          enemies.add(new Enemy(x + 0.5f, y + 0.5f));
  }
  
  void moveSelectedTo(float x, float y) {
    for (MyUnit myUnit: myUnits) {
      if (myUnit.is_selected) {
        myUnit.set_target(x, y);
        myUnit.is_selected = false;
      }
    }
  }
  
  void step() {
    // at each tick: let all units make steps
    for (MyUnit myUnit: myUnits)
      myUnit.step();
    for (Enemy enemy: enemies)
      enemy.step();
  }
}