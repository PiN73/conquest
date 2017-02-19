GameGUI game; //<>//

void setup() {
  size(640, 480);
  frameRate(30);
  game = new GameGUI(dataPath("testmap.dat"), 80);
}

void draw() {
  game.paint();
}



// GameGUI is Game with rendering
class GameGUI extends Game {
  int SCALE; // TODO: add autoscale
  
  GameGUI(String mapFileName, int SCALE) {
    super(mapFileName);
    this.SCALE = SCALE;
  }
  
  color[] COLOR = new color[]{#777777, #00FF00, #FF0000};
  
  private color darker(color c) {
    int a = (c >> 24) & 0xFF;
    int r = (c >> 16) & 0xFF;
    int g = (c >>  8) & 0xFF;
    int b = (c >>  0) & 0xFF;
    return color(r / 2, g / 2, b / 2, a);
  }
  
  void paint() {
    pushMatrix();
    scale(SCALE);
    
    for(int x = 0; x < map.w; ++x) {
        for(int y = 0; y < map.h; ++y) {
        fill(COLOR[map.cell_type(x,y)]);
        noStroke();
        rect(x, y, 1, 1);
      }
    } //<>//
    
    float myUnitSize = 0.2; // relative to cell
    fill(darker(COLOR[1]));
    noStroke();
    for (MyUnit myUnit: myUnits) {
      rect(myUnit.x - myUnitSize / 2 + 0.5, myUnit.y - myUnitSize / 2 + 0.5, myUnitSize, myUnitSize);
    }
    
    float enemySize = 0.2; // relative to cell
    fill(darker(COLOR[2]));
    noStroke();
    for (Enemy enemy: enemies) {
      rect(enemy.x - enemySize / 2 + 0.5, enemy.y - enemySize / 2 + 0.5, enemySize, enemySize);
    }
    
    popMatrix();
  }
}