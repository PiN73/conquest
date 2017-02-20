import java.util.Scanner;
import java.io.*;

class Map {
  int w, h;
  int[][] cells; // types of all cells at the map
  
  Map(String fileName) {
    try {
      // read map data from file:
      Scanner in = new Scanner(new File(fileName));
      w = in.nextInt();
      h = in.nextInt();
      cells = new int[w][h];
      for(int y = 0; y < h; ++y)
          for(int x = 0; x < w; ++x)
              cells[x][y] = in.nextInt();
      in.close();
    }
    catch (IOException e) {
      // error opening / reading the file:
      System.out.println("map file not found");
    }
  }
  
  public int cell_type(int x, int y) {
    // just getter for cell type
    return cells[x][y];
  }
} 