GameGUI game;

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
  
  color[] COLOR = new color[]{color(127,127,127), color(0,255,0), color(255,0,0)};
  
  void paint() {
    pushMatrix();
    scale(SCALE);
    for(int x = 0; x < map.w; ++x) {
        for(int y = 0; y < map.h; ++y) {
        fill(COLOR[map.cell_type(x,y)]);
        noStroke();
        rect(x, y, 1, 1);
      }
    }
    popMatrix();
  }
}