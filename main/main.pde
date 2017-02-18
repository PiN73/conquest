Map map;

void setup() {
  println(dataPath(""));
  size(640, 480);
  frameRate(30);
  try {
    map = new Map(dataPath("testmap.dat"));
  }
  catch (Exception e) {
    // ...
  }
  
}

void draw() {
  map.paint();
}


import java.util.*;
import java.io.*;
public class Map {
  int w, h;
  int[][] cells;
  color[] COLOR = new color[]{color(127,127,127), color(0,255,0), color(255,0,0)};
  
  public Map(String fileName) throws IOException {
    Scanner in = new Scanner(new File(fileName));
    w = in.nextInt();
    h = in.nextInt();
    cells = new int[w][h];
    for(int y = 0; y < h; ++y)
        for(int x = 0; x < w; ++x)
            cells[x][y] = in.nextInt();
    in.close();
  }
  
  void paint() {
    final int SCALE = 80; // TODO: add autoscale
    pushMatrix();
    scale(SCALE);
    for(int x = 0; x < w; ++x) {
        for(int y = 0; y < h; ++y) {
        fill(COLOR[cells[x][y]]);
        noStroke();
        rect(x, y, 1, 1);
      }
    }
    popMatrix();
  }
}
