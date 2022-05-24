import java.util.*;
import java.io.*;

Player player;

Data data;
ScreenAnimations animations;

String currentMap;
Map currentMapTiles;

void setup() {
  frameRate(60);
  data = new Data();
  
  currentMapTiles = new Map();
  try {
    currentMapTiles.loadMap("HomeTop.txt");
  } 
  catch (IOException e) {
    println("bad file");
  }
  size(1440, 864);
}

void draw(){
  background(255);
  
  image(data.getMap(currentMap, "fg"), 0, 0);
}
