public class ScreenAnimations {
  boolean inAnimation, fadein, fadeout, delay, commenting;
  Pokemon attacker,defender;
  String battlecomment;
  String choice;
  int frame;
  
  public ScreenAnimations() {
    inAnimation = false;
    fadein = false;
    fadeout = false;
    frame = 0;
  }
  
  void animate() {
    Tile currentTile = currentMapTiles.getTile(player.xpos, player.ypos);
    //animation conditions
    if (currentTile.isDoor && !inAnimation) {
      inAnimation = true;
      fadein = true;
    }
    
    pushMatrix();
    if (frameCount > 0) {
      if (fadein) {
        if (frame >= 250) {
          fadein = false;
          if (currentTile.isDoor) {
            currentMap = currentTile.warpMap;
            try {
              currentMapTiles.loadMap(getSubDir("Maps",currentMap + ".txt"));
            } catch (IOException e) {}
            player.teleport(currentTile.warpCoord[0], currentTile.warpCoord[1]);
          } else { //TPS TO POKECENTER AFTER ALL POKEMON DIES
            player.teleport(8,5);
            currentMap = "PokeCenter";
            try {
              currentMapTiles.loadMap(getSubDir("Maps",currentMap + ".txt"));
            } catch (IOException e){}
          }
          fadeout = true;
        } else {
          fill(0, frame);
          rect(0, 0, 1440, 864);
          frame += 25;
        }
      }
      if (fadeout) {
        if (frame <= 0) {
          fadeout = false;
          inAnimation = false;
        } else {
          fill(0, frame);
          rect(0, 0, 1440, 864);
          frame -= 25;
        }
      }
    }
    if (frameCount % 1 == 0){
      if (commenting) {
        if (frame < battlecomment.length()) {
          frame++;
        } else {
          commenting = false;
          inAnimation = false;
          
          if (choice.equals("fight")) {
            battle.attacker.attack(battle.defender);
            if (battle.checkDefenderAlive()) {
              battleComment(battle.defender.name + " used " + battle.defender.currentMove + "\n","secondAttack");
            } else {
              if (battle.opponent == null) {
                battle = null;
                currentGui = data.homeScreen;
              }
            }
          }
          
          if (choice.equals("secondAttack")) {
            battle.defender.attack(battle.attacker);
            if (battle != null && battle.checkAttackerAlive()) {
              battleComment("What should " + battle.ally.name + " do?","");
              currentGui = data.fightOptions;
            }
          }
          
        }
      }
    }
    if (battlecomment != null) {
      fill(255);
      textSize(30);
      textFont(data.font);
      String section = battlecomment.substring(0,frame);
      text(section,50,730);
    }
    popMatrix();
  }
  
  void battleComment(String s, String nextChoice){
    frame = 0;
    battlecomment = s;
    commenting = true;
    inAnimation = true;
    choice = nextChoice;
  }
}
