public class Map{
  int WIDTH;
  int HEIGHT;
  Tile[][] map;
  
  public Map(int w, int h){
    WIDTH = w;
    HEIGHT = h;
    map = new Tile[h][w];
  }
  void setTile(int x, int y, Tile tile){
    map[y][x] = tile;
  }
  Tile getTile(int x, int y){
    return map[y][x];
  }
}
