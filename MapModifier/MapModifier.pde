import java.util.*;
import java.io.*;

PImage currentMap;
Map map;

<<<<<<< HEAD
void setup(){
  size(256,224); //remember to change size to map width*16 by map height * 16 before start
  currentMap = loadImage("HomeTopFG.png");
  currentMap.resize(256,224); //same size as size()
  map = new Map(16,14); //should be (width/16,height/16)
  for (int i = 0; i < map.HEIGHT; i ++){
    for (int j = 0; j < map.WIDTH; j ++){
      map.setTile(j,i,new Tile(16));
    }
  }
  map.getTile(0,0).modifyTile("BLOCK","add");
}

void draw(){
  background(255);
  image(map.getTile(0,0).texture, 0, 0);
=======
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
  map.getTile(0, 0).modifyTile("BLOCK", "add");
}

void draw() {
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
}

void mouseTile() {
  int x = (((int)mouseX)/16);
  int y = (((int)mouseY)/16);
  map.getTile(x, y).modifyTile("BLOCK", "add");
}

void mousePressed() {
  mouseTile();
>>>>>>> editingHanson
}
