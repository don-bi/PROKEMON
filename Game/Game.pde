import java.util.*;
import java.io.*;

Player player;

Data data;
ScreenAnimations animations;
Command command;

String currentMap;
Map currentMapTiles;
NPC[] npcs;

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
  data = new Data();
  command = new Command();
  
  //loads initial hometop map
  currentMap = "HomeTop";
  currentMapTiles = new Map();
  try {
    currentMapTiles.loadMap(getSubDir("Maps",currentMap+".txt"));
  } 
  catch (IOException e) {
    println("bad file");
  }
  //-------------------------
  textFont(data.font);
  currentGui = data.homeScreen;
  size(1440, 864);
  player = new Player();
  player.teleport(7, 7);
  
  //TESTING BATTLEMODE
  Pokemon poke2 = new Pokemon("Blissey", 100, true);
  poke2.moves[0] = new Move("79");
  poke2.moves[1] = new Move("261");
  poke2.moves[2] = new Move("86");
  poke2.moves[3] = new Move("58");
  poke2.moves[3].effectChance = 100;
  player.team.add(poke2);
  Pokemon poke3 = new Pokemon("Rayquaza", 40, true);
  player.team.add(poke3);
  Pokemon poke4 = new Pokemon("Arceus","dark", 45, true);
  player.team.add(poke4);
  Pokemon poke5 = new Pokemon("Mewtwo",40,true);
  player.team.add(poke5);
}

void draw() {
  if (battle == null){
    background(255);
    
    //push and pop matrices make it so that translating the screen only affects the screen and player
    pushMatrix();
    player.moveScreen();
    image(data.getMap(currentMap, "fg"), 0, 0);
    showCharacters();
    popMatrix();
    
    checkWASD();
    if (command.commandmode) command.display();
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

void keyPressed(){
  if (battle == null) {
    if (key == ENTER) {
      if (command.commandmode) {
        command.execute();
      } else {
        command.open();
      }
    }
    if (key == ' ') {
      if (player.getFrontTile().isInteractable){ //if the tile in front is an interactable, then it displays whatever its comment is, and if it's the one in the pokecenter, it heals all the pokemon too
        animations.overworldComment(player.getFrontTile().comment,"commanderror");
        if (player.getFrontTile().comment.equals("Your POKéMON has been healed!")) {
          for (Pokemon poke:player.team) {
            poke.hp = poke.stats.get("hp");
            poke.nonvolStatus = "none";
          }
        }
      }
    }
  }
}

void keyTyped(){
  if (command.commandmode){
    command.add();
  }
}

void fileSelected(File file){ //this is called by selectInput in button class when pressing the load button
  if (file != null) { //it loads in a file that was previously saved, if not previously saved, then it will do an error and be caught
    try {
      ArrayList<Pokemon> temp = new ArrayList<Pokemon>();
      BufferedReader reader = createReader(file);
      int pokeAmt = parseInt(reader.readLine());
      for (int i = 0; i < pokeAmt; i ++){
        String name = reader.readLine();
        int level = parseInt(reader.readLine());
        Pokemon newpoke = new Pokemon(name,level,true);
        newpoke.hp = parseInt(reader.readLine());
        newpoke.exp = parseInt(reader.readLine());
        newpoke.nature = reader.readLine();
        newpoke.nonvolStatus = reader.readLine();
        String pokeball = reader.readLine();
        if (pokeball.equals("pokeball")) { //gets pokeballtype the pokemon is in
          newpoke.pokeball = data.pokeball;
        } else {
          newpoke.pokeball = data.masterball;
        }
        String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
        for (String stat:statnames) {
          String data[] = reader.readLine().split(" "); //the saved data file will have 6 lines each 3 values each corresponding to stat, evs, and ivs
          newpoke.stats.put(stat,parseInt(data[0]));
          newpoke.EVs.put(stat,parseInt(data[1]));
          newpoke.IVs.put(stat,parseInt(data[2]));
        }
        int movesAmt = parseInt(reader.readLine());
        for (int m = 0; m < movesAmt; m ++){
          String moveid = reader.readLine();
          newpoke.moves[m] = new Move(moveid);
        }
        temp.add(newpoke);
      }
      player.team = temp;
    } catch (Exception e) {
      animations.overworldComment("BAD FILE!!","commanderror");
    }
  }
}

void checkWASD(){
  if (keyPressed){
    switch ((""+key).toUpperCase()) { //makes it so you can move even with caps lock on
    case "W": 
    case "A": 
    case "S": 
    case "D":
      if (!player.inWalkAnimation && !animations.inAnimation) {
        player.changeDirection();
        player.move();
      }
    }
  }
}
  
void showCharacters(){
  if (npcs.length > 0) {
    for (NPC npc:npcs){
      if (npc.ypos > player.ypos) {
        player.showPlayer();
        npc.display();
        npc.encounter();
      } else if (npc.ypos < player.ypos) {
        npc.display();
        npc.encounter();
        player.showPlayer();
      } else {
        npc.display();
        npc.encounter();
        player.showPlayer();
      }
    }
  } else {
    player.showPlayer();
  }
}

String getSubDir(String sub, String file){
  return dataPath(sub)+'/'+file;
}
