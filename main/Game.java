import java.util.ArrayList;

public class Game {
  Map map;
  ArrayList<MyUnit> myUnits;
  ArrayList<Enemy> enemies;
  
  Game(String mapFileName) {
    map = new Map(mapFileName);
    myUnits = new ArrayList<MyUnit>();
    enemies = new ArrayList<Enemy>();
    
    for(int y = 0; y < map.h; ++y)
      for(int x = 0; x < map.w; ++x)
        if (map.cell_type(x, y) == 1)  
          myUnits.add(new MyUnit(x + 0.5f, y + 0.5f));
        else if (map.cell_type(x, y) == 2)
          enemies.add(new Enemy(x + 0.5f, y + 0.5f));
  }
  
  void step() {
    for (MyUnit myUnit: myUnits)
      myUnit.step();
    for (Enemy enemy: enemies)
      enemy.step();
  }
}