import java.util.*;
import java.io.*;

PImage currentMap;
Map map;
boolean commandmode = false;
String currentcommand = "";
String mode = "";
boolean modifymode = false;
final int tileSize = 16; //pixel size of each tile (HAS TO BE MULTIPLE OF 16)

void setup() {
  size(640, 640); //remember to change size to map width*16 by map height * 16 before start
  currentMap = loadImage("Woodbury_Town.png");
  currentMap.resize(width, height);
  map = new Map(width/tileSize, height/tileSize);
  for (int i = 0; i < map.HEIGHT; i ++) {
    for (int j = 0; j < map.WIDTH; j ++) {
      map.setTile(j, i, new Tile(tileSize));
    }
  }
}

void draw() {
  if (!commandmode) {
    stroke(255, 0);
    //fills the screen with tile textures
    background(255);
    image(currentMap, 0, 0);
    if (modifymode) {
      for (int i = 0; i < map.HEIGHT; i ++) {
        for (int j = 0; j < map.WIDTH; j ++) {
          int x = j*tileSize;
          int y = i*tileSize;
          image(map.getTile(j, i).texture, x, y);
        }
      }
    }
    textSize(15);
    fill(255);
    text(mode, 10, 40);
    //while left click is being pressed it places tile at spot, right click displays data
    if (mousePressed && mouseInBounds()) {
      if (mouseButton == LEFT) mouseTile();
      if (mouseButton == RIGHT) mouseTileData();
    }
  } else {
    fill(255);
    image(currentMap, 0, 0);
    rect(0, height/2, width, 20);
    textSize(15);
    fill(0);
    text(currentcommand, 0, height/2+15);
  }
}

//mouse methods
void mouseTileData() {
  int x = (((int)mouseX)/tileSize);
  int y = (((int)mouseY)/tileSize);
  map.getTile(x, y).printData();
}

void mouseTile() {
  int x = (((int)mouseX)/tileSize);
  int y = (((int)mouseY)/tileSize);
  map.getTile(x, y).modifyTile(mode, "add");
}

boolean mouseInBounds() {
  return mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height;
}



void keyPressed() {
  if (key == ENTER) {
    if (!commandmode) {
      commandmode = true;
    } else {
      try {
        execute();
      } //catch (NullPointerException e){
      //println("No such file to import");
      /*}*/      catch (IOException e) {
      }
      commandmode = false;
      currentcommand = "";
    }
  } else if (commandmode) {
    if (key == BACKSPACE && currentcommand.length()>0) {
      currentcommand = currentcommand.substring(0, currentcommand.length()-1);
    } else {
      currentcommand += key;
    }
  } else if (key == ' ') {
    modifymode = !modifymode;
  }
}

void execute() throws IOException, NullPointerException {
  if (currentcommand.length() > 0) {
    //for slash commands
    if (currentcommand.charAt(0) == '/') {

      //export current map data into a file named after what's typed next
      if (currentcommand.length() > 7 && currentcommand.substring(1, 7).equals("export")) {
        String exportfile = currentcommand.substring(8) + ".txt";
        PrintWriter export = createWriter(exportfile);
        export.println("PROKEMON DATAFILE");
        export.println(map.toString());
        export.flush();
        export.close();
      }

      //import
      if (currentcommand.length() > 7 && currentcommand.substring(1, 7).equals("import")) importData();
    } else {
      //if no slash command, sets mode to what's typed
      mode = currentcommand.toUpperCase();
    }
  }
}


void importData() throws IOException {
  BufferedReader reader = createReader(currentcommand.substring(8) + ".txt");
  String skip = reader.readLine(); //skips the PROKEMON DATAFILE first line
  String[] line = reader.readLine().split(" "); //creates array with  each block of t/f's as each element
  for (int imY = 0; imY < map.HEIGHT; imY++) {
    for (int imX = 0; imX < map.WIDTH; imX++) {
      String element = line[imX]; //element is each block of t,f,f,t,f,t,f's
      String[] modifiers = element.split(",");
      String[] mods = {"INTERACT", "WARP", "DOOR", "EVENT", "FOREGROUND", "GRASS"};
      String change = "remove";
      if (modifiers[0].equals("f")) change = "add"; //does 'BLOCK' separately because f in the data is what changes the tile
      map.getTile(imX, imY).modifyTile("BLOCK", change);
      for (int i = 0; i < mods.length; i ++) {
        change = "remove";
        if (modifiers[i+1].equals("t")) change = "add";
        map.getTile(imX, imY).modifyTile(mods[i], change);
      }
    }
    String lineString = reader.readLine();
    if (lineString != null) line = lineString.split(" ");
  }
}
