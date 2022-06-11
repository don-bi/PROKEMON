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
    
    if (confirmation.equals("PROKEMON DATAFILE")){ //confirms that the file is legit
      String[] size = reader.readLine().split(" "); 
      //the two numbers below confirmation give the width and height
      WIDTH = parseInt(size[0]);
      HEIGHT = parseInt(size[1]);
      map = new Tile[HEIGHT][WIDTH];
      fillTiles();
      
      //reads tiletypes that doesn't have extra booleans
      for (int imY = 0; imY < HEIGHT; imY++) {
        String[] line = reader.readLine().split(" "); 
        for (int imX = 0; imX < WIDTH; imX++) {
          String element = line[imX]; //elements are a single string of (t,f,f,f,f,f,f) or other t/f's
          String[] modifiers = element.split(",");
          String[] mods = {"INTERACT", "WARP", "DOOR", "EVENT", "FOREGROUND", "GRASS"};
          String change = "remove"; //if the modifier is f, removes it
          if (modifiers[0].equals("f")) change = "add";
          getTile(imX, imY).modifyTile("BLOCK", change);
          for (int i = 0; i < mods.length; i ++) { //goes through modifier list
            change = "remove";
            if (modifiers[i+1].equals("t")) change = "add";
            getTile(imX, imY).modifyTile(mods[i], change);
          }
        }
      }
      //reads in doors
      int doors = parseInt(reader.readLine());
      for (int i = 0; i < doors; i ++){
        String[] doorInfo = reader.readLine().split(" ");
        int doorX = parseInt(doorInfo[0]);
        int doorY = parseInt(doorInfo[1]);
        int warpX = parseInt(doorInfo[2]);
        int warpY = parseInt(doorInfo[3]);
        getTile(doorX,doorY).modifyTile("DOOR","add");
        getTile(doorX,doorY).setWarp(warpX,warpY,doorInfo[4]);
      }
      
      int trainers = parseInt(reader.readLine());
      npcs = new NPC[trainers];
      for (int i = 0; i < trainers; i ++) {
        String[] coords = reader.readLine().split(" ");
        int x = parseInt(coords[0]);
        int y = parseInt(coords[1]);
        char dir = reader.readLine().charAt(0);
        int range = parseInt(reader.readLine());
        NPC newguy = new NPC(x, y, dir, range);
        newguy.name = reader.readLine();
        newguy.type = reader.readLine();
        newguy.comment = reader.readLine();
        newguy.losecomment = reader.readLine();
        newguy.wincomment = reader.readLine();
        newguy.isEncounter = reader.readLine().equals("encounter");
        newguy.reward = parseInt(reader.readLine();
        int pokemons = parseInt(reader.readLine();
        for (int p = 0; p < pokemons); p ++) {
          String pokename = reader.readLine();
          int lev = parseInt(reader.readLine());
          newguy.team.add(new Pokemon(pokename,lev));
        }
        npcs[i] = newguy;
      }
      
    } else {
      println("File format not supported");
    }
  }
  
  Tile getTile(int x, int y){
    if (x > -1 && x < WIDTH && y > -1 && y < HEIGHT){
      return map[y][x];
    } else {
      return new Tile(96);
    }
  }
  
  void fillTiles(){
    for (int y = 0; y < HEIGHT; y ++){
      for (int x = 0; x < WIDTH; x ++){
        map[y][x] = new Tile(96);
      }
    }
  }
  
}
