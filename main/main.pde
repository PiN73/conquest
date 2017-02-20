GameGUI game;

void setup() {
  size(640, 480);
  frameRate(30);
  game = new GameGUI(dataPath("testmap.dat"), 80);
}

void draw() {
  game.paint();
  game.step();
}

Selection selection;

void mousePressed() {
  // when mouse is pressed, save its coordinates to `selection`
  selection = new Selection(mouseX, mouseY);
}

void mouseDragged() {
  // when mouse is dragged, let `selection` know about this
  // to diifer mouse click and mouse move
  if (selection != null)
    selection.dragged = true;
  // show current selection?
}

void mouseReleased() {
  // when mouse is relased, save its coordinates to `selection`
  selection.finish(mouseX, mouseY);
  if (selection.dragged) {
    // tell `game` to select all `myUnits` inside selection rectangle
    game.select(selection);
  } else {
    // tell `game` to move all selected `myUnits` to the new place
    game.moveSelectedTo(mouseX, mouseY);
  }
  selection = null;
}



// GameGUI is Game with rendering
class GameGUI extends Game {
  int SCALE; // TODO: add autoscale
  
  GameGUI(String mapFileName, int SCALE) { // constructor of GameGUI
    super(mapFileName); // call constructor of Game
    this.SCALE = SCALE; // set scale
  }
  
  // colors of territory: 0)neutral-gray, 1)my-green, 2)enemy-red
  color[] COLOR = new color[]{#777777, #00FF00, #FF0000};
  
  private color darker(color c) {
    int a = (c >> 24) & 0xFF;
    int r = (c >> 16) & 0xFF;
    int g = (c >>  8) & 0xFF;
    int b = (c >>  0) & 0xFF;
    return color(r / 2, g / 2, b / 2, a);
  }
  
  void paint() { // rendering
    pushMatrix();
    scale(SCALE);
    
    for(int x = 0; x < map.w; ++x) {
        for(int y = 0; y < map.h; ++y) {
        fill(COLOR[map.cell_type(x,y)]);
        noStroke();
        rect(x, y, 1, 1);
      }
    }
    
    float myUnitSize = 0.2; // relative to cell
    fill(darker(COLOR[1]));
    noStroke();
    for (MyUnit myUnit: myUnits) {
      float a = myUnit.is_selected ? myUnitSize * 1.4 : myUnitSize;
      rect(myUnit.x - a / 2, myUnit.y - a / 2, a, a);
    }
    
    float enemySize = 0.2; // relative to cell
    fill(darker(COLOR[2]));
    noStroke();
    for (Enemy enemy: enemies) {
      rect(enemy.x - enemySize / 2, enemy.y - enemySize / 2, enemySize, enemySize);
    }
    
    popMatrix();
  }
  
  boolean nowSelecting = false;
  
  void select(Selection selection) { // select myUnits that are inside selection
    float selection_x1 = selection.x1 / (float)SCALE;
    float selection_y1 = selection.y1 / (float)SCALE;
    float selection_x2 = selection.x2 / (float)SCALE;
    float selection_y2 = selection.y2 / (float)SCALE;
    
    for (MyUnit myUnit: myUnits)
      if (selection_x1 <= myUnit.x && myUnit.x <= selection_x2 &&
          selection_y1 <= myUnit.y && myUnit.y <= selection_y2)
        myUnit.is_selected = true;
  }
  
  void moveSelectedTo(int x, int y) { // move myUnits that are selected to new place 
    super.moveSelectedTo(x / (float)SCALE, y / (float)SCALE);
  }
}


class Selection { //?
  int x1, y1, x2, y2;
  boolean dragged = false;
  Selection(int startX, int startY) {
    x1 = startX;
    y1 = startY;
  }
  void finish(int endX, int endY) {
    x2 = endX;
    y2 = endY;
    if (x1 > x2) x1 = x1 ^ x2 ^ (x2 = x1);
    if (y1 > y2) y1 = y1 ^ y2 ^ (y2 = y1);
  }
}