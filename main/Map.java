import java.util.Scanner;
import java.io.*;

class Map { //?
  int w, h;
  int[][] cells; //?
  
  Map(String fileName) { //?
    try {
      Scanner in = new Scanner(new File(fileName)); //?
      w = in.nextInt();
      h = in.nextInt();
      cells = new int[w][h];
      for(int y = 0; y < h; ++y)
          for(int x = 0; x < w; ++x)
              cells[x][y] = in.nextInt();
      in.close();
    }
    catch (IOException e) {
      System.out.println("map file not found"); //?
    }
  }
  
  public int cell_type(int x, int y) { //?
    return cells[x][y];
  }
} 
