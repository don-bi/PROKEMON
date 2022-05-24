public class Map {
  int WIDTH;
  int HEIGHT;
  Tile[][] map;
  
  public Map() {
    map = new Tile[0][0];
  }

  void loadMap(String file) throws IOException{
    BufferedReader reader = createReader(file);
    String confirmation = reader.readLine();
    
    if (confirmation.equals("PDEKEMON DATAFILE")){
      String[] size = reader.readLine().split(" ");
      WIDTH = parseInt(size[0]);
      HEIGHT = parseInt(size[1]);
      map = new Tile[HEIGHT][WIDTH];
      fillTiles();
      
      //reads tiletypes that doesn't have extra booleans
      for (int imY = 0; imY < HEIGHT; imY++) {
        String[] line = reader.readLine().split(" ");
        for (int imX = 0; imX < WIDTH; imX++) {
          String element = line[imX];
          String[] modifiers = element.split(",");
          String[] mods = {"INTERACT", "WARP", "DOOR", "EVENT", "FOREGROUND", "GRASS"};
          String change = "remove";
          if (modifiers[0].equals("f")) change = "add";
          getTile(imX, imY).modifyTile("BLOCK", change);
          for (int i = 0; i < mods.length; i ++) {
            change = "remove";
            if (modifiers[i+1].equals("t")) change = "add";
            getTile(imX, imY).modifyTile(mods[i], change);
          }
        }
      }
    } else {
      println("File format not supported");
    }
  }
  
  Tile getTile(int x, int y){
    return map[y][x];
  }
  
  void fillTiles(){
    for (int y = 0; y < HEIGHT; y ++){
      for (int x = 0; x < WIDTH; x ++){
        map[y][x] = new Tile(96);
      }
    }
  }
}
