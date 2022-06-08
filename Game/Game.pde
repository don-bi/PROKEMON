import java.util.*;
import java.io.*;

Player player;

Data data;
ScreenAnimations animations;

String currentMap;
Map currentMapTiles;

BattleMode battle;
Gui currentGui;

/*REMINDERS***
resize map pngs to 6x the size in pixlr or another program first
add PDEKEMON DATAFILE to top of txt data files
map size right after, width height format
^ first two lines
after map data, add warp data
*/

void setup() {
  PFont.list();
  frameRate(60);
  background(0);
  textSize(100);
  fill(255);
  text("LOADING...", width/2-250, height/2);
  
  //info classes being loaded  
  animations = new ScreenAnimations();
  data = new Data();
  
  //loads initial hometop map
  currentMap = "Route1";
  currentMapTiles = new Map();
  try {
    currentMapTiles.loadMap(getSubDir("Maps",currentMap+".txt"));
  } 
  catch (IOException e) {
    println("bad file");
  }
  //-------------------------

  currentGui = data.homeScreen;
  size(1440, 864);
  player = new Player();
  player.teleport(7, 7);
  
  //TESTING BATTLEMODE
  Pokemon poke2 = new Pokemon("Lucario", 32, true);
  player.team.add(poke2);
  Pokemon poke3 = new Pokemon("Torterra", 34, true);
  player.team.add(poke3);
  Pokemon poke4 = new Pokemon("Zekrom", 20, true);
  player.team.add(poke4);
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
    
    checkWASD();
  } else {
    battle.display();
  }
  if (currentGui != null) currentGui.display();
  animations.animate();
  
  //println(currentMap);
  //currentMapTiles.getTile(player.xpos,player.ypos).printData();
  //println("(" + player.xpos + ", " + player.ypos + ")");
}

void mouseClicked(){
  if (currentGui != null) currentGui.processButtons();
}

void checkWASD(){
  if (keyPressed){
    switch ((""+key).toUpperCase()) { //makes it so you can move even with caps lock on
    case "W": 
    case "A": 
    case "S": 
    case "D":
      if (!player.inWalkAnimation) {
        player.changeDirection();
        //if (player.delay == 0 ){
        //  player.move();
        //} else {
        //  player.delay ++;
        //  if (player.delay == 1) player.delay = 0;
        //}
        player.move();
      }
    }
  }
}
  


String getSubDir(String sub, String file){
  return dataPath(sub)+'/'+file;
}
