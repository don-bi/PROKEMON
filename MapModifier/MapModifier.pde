import java.util.*;
import java.io.*;

PImage currentMap;
Map map;
boolean commandmode = false;
String currentcommand = "";
String mode = "";

void setup() {
  size(256, 224); //remember to change size to map width*16 by map height * 16 before start
  currentMap = loadImage("HomeTopFG.png");
  currentMap.resize(256, 224); //same size as size()
  map = new Map(16, 14); //should be (width/16,height/16)
  for (int i = 0; i < map.HEIGHT; i ++) {
    for (int j = 0; j < map.WIDTH; j ++) {
      map.setTile(j, i, new Tile(16));
    }
  }
}

void draw() {
  if (!commandmode) {
    background(255);
    image(currentMap, 0, 0);
    image(map.getTile(0, 0).texture, 0, 0);
    for (int i = 0; i < map.HEIGHT; i ++) {
      for (int j = 0; j < map.WIDTH; j ++) {
        int x = j*16;
        int y = i*16;
        image(map.getTile(j, i).texture, x, y);
      }
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

void mouseTile() {
  int x = (((int)mouseX)/16);
  int y = (((int)mouseY)/16);
  map.getTile(x, y).modifyTile(mode, "add");
}

void mousePressed() {
  mouseTile();
}

void keyPressed() {
  if (key == ENTER) {
    if (!commandmode) {
      commandmode = true;
    } else {
      try {
        execute();
      } catch (IOException e){
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
  }
}

void execute() throws IOException, NullPointerException{
  if (currentcommand.length() > 0) {
    //for slash commands
    if (currentcommand.charAt(0) == '/') {

      //export current map data into a file named after what's typed next
      if (currentcommand.length() > 7 && currentcommand.substring(1, 7).equals("export")) {
        String exportfile = currentcommand.substring(8) + ".txt";
        PrintWriter export = createWriter(exportfile);
        export.println(map.toString());
        export.flush();
        export.close();
      }

      //import
      if (currentcommand.length() > 7 && currentcommand.substring(1, 7).equals("import")) {
        BufferedReader reader = createReader(currentcommand.substring(8) + ".txt");
        String[] line = reader.readLine().split(" ");
        for (int imY = 0; imY < map.HEIGHT; imY++) {
          for (int imX = 0; imX < map.WIDTH; imX++) {
            String element = line[imX];
            String[] modifiers = element.split(",");
            String[] mods = {"INTERACT", "WARP", "DOOR", "EVENT", "FOREGROUND"};
            String change = "remove";
            if (modifiers[0].equals("f")) change = "add";
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
    } else {
      mode = currentcommand.toUpperCase();
    }
  }
}
