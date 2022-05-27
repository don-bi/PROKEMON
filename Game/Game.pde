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
  frameRate(60);
  background(0);
  textSize(100);
  fill(255);
  text("LOADING...", width/2-250, height/2);
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
  Pokemon poke2 = new Pokemon("Charmeleon", true);
  Pokemon poke = new Pokemon("Kyogre");
  battle = new BattleMode(poke);
  battle.ally = poke2;
  currentGui = data.fightOptions;
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
    checkWASD();
  } else {
    battle.display();
  }
}

void mouseClicked(){
  currentGui.processButtons();
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
        if (player.delay == 0 ){
          player.move();
        } else {
          player.delay ++;
          if (player.delay == 4) player.delay = 0;
        }
      }
    }
  }
}
  


String getSubDir(String sub, String file){
  return dataPath(sub)+'/'+file;
}
