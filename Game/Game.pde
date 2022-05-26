import java.util.*;
import java.io.*;

Player player;

Data data;
ScreenAnimations animations;

String currentMap;
Map currentMapTiles;

BattleMode battle;

/*REMINDERS***
resize map pngs to 6x the size in pixlr or another program first
add PDEKEMON DATAFILE to top of txt data files
map size right after, width height format
^ first two lines
after map data, add warp data
*/

void setup() {
  frameRate(60);
  //info classes being loaded  
  animations = new ScreenAnimations();

  //loads initial hometop map
  currentMap = "HomeTop";
  currentMapTiles = new Map();
  try {
    data = new Data();
    currentMapTiles.loadMap(getSubDir("Maps","HomeTop.txt"));
  } 
  catch (IOException e) {
    println("bad file");
  }
  //-------------------------

  size(1440, 864);
  player = new Player();
  player.teleport(7, 7);
  
  //TESTING BATTLEMODE
  Pokemon poke2 = new Pokemon("Venusaur", true);
  Pokemon poke = new Pokemon("Arceus", "water");
  battle = new BattleMode(poke);
  battle.ally = poke2;
}

void draw() {
  if (battle == null){
    background(255);
    
    //push and pop matrices make it so that translating the screen only affects the screen and player
    pushMatrix();
    player.moveScreen();
    image(data.getMap(currentMap, "fg"), 0, 0);
    player.showPlayer();
    popMatrix();
    
    animations.animate();
  } else {
    battle.display();
  }
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

String getSubDir(String sub, String file){
  return dataPath(sub)+'/'+file;
}
