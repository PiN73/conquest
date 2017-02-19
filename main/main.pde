GameGUI game; //<>//

void setup() {
  size(640, 480);
  frameRate(30);
  game = new GameGUI("testmap.dat", 80);
}

void draw() {
  game.paint();
}



import java.util.*;
import java.io.*;

public class Game {
  Map map;
  
  public Game(String mapFileName) {
    map = new Map(mapFileName);
  }
}

class Map {
  int w, h;
  int[][] cells;
  color[] COLOR = new color[]{color(127,127,127), color(0,255,0), color(255,0,0)};
  
  Map(String fileName) {
    try {
      Scanner in = new Scanner(new File(dataPath(fileName)));
      w = in.nextInt();
      h = in.nextInt();
      cells = new int[w][h];
      for(int y = 0; y < h; ++y)
          for(int x = 0; x < w; ++x)
              cells[x][y] = in.nextInt(); //<>//
      in.close();
    }
    catch (IOException e) {
      println("map file not found");
    } //<>//
  }
  
  public color cell_color(int x, int y) {
    return COLOR[cells[x][y]];
  }
}

class GameGUI extends Game {
  int SCALE; // TODO: add autoscale
  
  GameGUI(String mapFileName, int SCALE) {
    super(mapFileName);
    this.SCALE = SCALE;
  }
  
  void paint() {
    pushMatrix();
    scale(SCALE);
    for(int x = 0; x < map.w; ++x) {
        for(int y = 0; y < map.h; ++y) {
        fill(map.cell_color(x,y));
        noStroke();
        rect(x, y, 1, 1);
      }
    }
    popMatrix();
  }
}