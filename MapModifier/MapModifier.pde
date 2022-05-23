import java.util.*;
import java.io.*;

PImage currentMap;
Map map;

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
  map.getTile(0,0).modifyTile("BLOCK",true);
}

void draw(){
  background(255);
  image(map.getTile(0,0).texture, 0, 0);
}
