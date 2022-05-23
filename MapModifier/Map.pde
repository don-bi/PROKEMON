public class Map{
  int WIDTH;
  int HEIGHT;
  Tile[][] map;
  
  public Map(int w, int h){
    WIDTH = w;
    HEIGHT = h;
    map = new Tile[h][w];
  }
  
  String toString(){
    String s = "";
    for (Tile[] tilerow:map){
      for (int tile = 0; tile < tilerow.length; tile ++){
        s += tilerow[tile].toString();
        if (tile != tilerow.length-1) s += " ";
      }
      trim(s);
      s += "\n";
    }
    return trim(s);
  }
  
  void setTile(int x, int y, Tile tile){
    if (inBounds(x,y)) map[y][x] = tile;
  }
  
  Tile getTile(int x, int y){
    return map[y][x];
  }
  
  boolean inBounds(int x, int y){
    return x > -1 && x < WIDTH && y > -1 && y < HEIGHT;
  }
}
