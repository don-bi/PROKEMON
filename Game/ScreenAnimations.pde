public class ScreenAnimations {
  boolean inAnimation, fadein, fadeout, delay, commenting, hp, exp, transition;
  Pokemon attacker,defender,hplowerer;
  int prevHp,newHp,prevExp,newExp;
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
      if (hp) {
        if (frame < 20) {
          frame ++;
          hplowerer.hp += (newHp-prevHp)/20;
        } else {
          hplowerer.hp = newHp;
          inAnimation = false;
          hp = false;
        }
      }
    }
    if (frameCount % 2 == 0){
      if (commenting) {
        if (frame < battlecomment.length()) {
          frame++;
        } else {
          commenting = false;
          inAnimation = false;
          
          if (choice.equals("fight")) {
            if (!transition) {
              prevHp = defender.hp;
              battle.attacker.attack(battle.defender);
              newHp = defender.hp;
              hpBar(defender);
            }
            if (battle.checkDefenderAlive() && !hp) {
              battleComment(battle.defender.name + " used " + battle.defender.currentMove + "\n","secondAttack");
            } else {
              if (battle.opponent == null) {
                returnHome();
              }
            }
          } 
          
          else if (choice.equals("escape")) {
            returnHome();
          }
          
          else if (choice.equals("noescape")) {
            battleComment(battle.defender.name + " used " + battle.defender.currentMove + "\n","secondAttack");
          }
          
          else if (choice.equals("secondAttack")) {
            if (!transition) {
              prevHp = attacker.hp;
              battle.defender.attack(battle.attacker);
              newHp = attacker.hp;
              hpBar(attacker);
            }
            if (battle != null && battle.checkAttackerAlive() && !hp) {
              battleComment("What should " + battle.ally.name + " do?","");
              currentGui = data.fightOptions;
            } 
            
            else if (!battle.checkAttackerAlive()){
              boolean alive = false;
              for (Pokemon pokemon:player.team) { //Checks remaining pokemon if they are alive
                if (pokemon.hp > 0) alive = true;
              }
              if (alive) { //able to choose what to switch to if there is an alive pokemon
                currentGui = data.deadPokemon;
              }
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
    transition = false;
  }
  
  void returnHome(){
    battle = null;
    currentGui = data.homeScreen;
    battlecomment = null;
  }
  
  void hpBar(Pokemon p){
    hplowerer = p;
    frame = 1;
    hp = true;
    inAnimation = true;
    transition = true;
  }
}
