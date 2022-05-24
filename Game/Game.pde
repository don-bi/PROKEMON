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

  //loads initial hometop map
  currentMap = "HomeTop";
  currentMapTiles = new Map();
  try {
    currentMapTiles.loadMap("HomeTop.txt");
  } 
  catch (IOException e) {
    println("bad file");
  }
  //-------------------------

  size(1440, 864);
  player = new Player();
  player.teleport(7, 7);
}

void draw() {
  background(255);

  image(data.getMap(currentMap, "fg"), 0, 0);
  player.display();
  player.showPlayer();
}

void keyPressed() {
  switch ((""+key).toUpperCase()) { //makes it so you can move even with caps lock on
  case "W": 
  case "A": 
  case "S": 
  case "D":
    if (!player.inWalkAnimation) {
      player.changeDirection();
      player.move();
    }
  }
}
