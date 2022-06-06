public class ScreenAnimations {
  boolean inAnimation, fadein, fadeout, commenting, hp, exp, transition, faint;
  PImage savedSprite;
  Pokemon hplowerer, fainter;
  int prevHp,newHp,prevExp;
  String battlecomment;
  String choice;
  int frame;
  float effectiveness, gainedExp;
  
  public ScreenAnimations() {
    inAnimation = false;
    fadein = false;
    fadeout = false;
    transition = false;
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
      if (faint) {
        if (frame < fainter.sprite.height/6){
          int x = 940;
          int y = 400;
          if (fainter == battle.ally) {
            x = 130;
            y = 800;
          }
          PImage faintsprite = fainter.sprite.get(0,0,fainter.sprite.width,fainter.sprite.height-frame*6);
          image(faintsprite,x,y-faintsprite.height);
          frame ++;
        } else {
          faint = false;
          inAnimation = false;
          battleComment(fainter.name + " has fainted.","faint");
        }
      }
    }
    if (hp) {
      if (frame < 20) {
        frame ++;
        int x = 1048;
        int y = 498;
        if (hplowerer == battle.enemy) {
          x = 476;
          y = 218;
        }
        image(data.miniHpBar.get(0,0,(int)(prevHp-(prevHp-newHp)/20.0*frame)*192/hplowerer.stats.get("hp"),8),x,y);
      } else {
        hplowerer.hp = newHp;
        image(data.miniHpBar.get(0,0,battle.ally.hp*192/battle.ally.stats.get("hp"),8),1048,498);
        image(data.miniHpBar.get(0,0,battle.enemy.hp*192/battle.enemy.stats.get("hp"),8),476,218);
        hplowerer = null;
        hp = false;
        if (choice.equals("fight")) {
          effectivenessMessage(effectiveness,1);
        }
        else if (choice.equals("secondAttack")) {
          effectivenessMessage(effectiveness,2);
        }
      }
    }
    if (exp) {
      if (frame < 20) {
        frame ++;
        battle.ally.exp += gainedExp/20;
        if (battle.ally.exp > battle.ally.neededExp) {
          float expOver = battle.ally.exp - battle.ally.neededExp;
          battle.ally.levelUp;
        }
      } else {
        
    
    if (frameCount % 2 == 0){ 
       if (commenting) {
        if (frame < battlecomment.length()) {
          frame++;
          if (choice.equals("effective1")) println(frame);
        } else {
          commenting = false;
          inAnimation = false;
          
          if (choice.equals("fight")) {
            if (!transition) hpBar(battle.attacker, battle.defender);
          } 
          
          else if (choice.equals("effective1")) {
            if (battle.checkDefenderAlive()) {
              battleComment(battle.defender.name + " used " + battle.defender.currentMove + ".","secondAttack");
            } else {
              faint(battle.defender);
            }
          }
          
          else if (choice.equals("switchPokemon")) {
            effectivenessMessage(1,1);
          }
          
          else if (choice.equals("deadPokemon")) {
            battleComment("What will " + battle.ally.name + " do?","");
          }
          
          else if (choice.equals("escape")) {
            returnHome();
          }
          
          else if (choice.equals("noescape")) {
            battleComment(battle.defender.name + " used " + battle.defender.currentMove + ".","secondAttack");
          }
          
          else if (choice.equals("secondAttack")) {
            if (!transition) hpBar(battle.defender, battle.attacker);
          }
          
          else if (choice.equals("effective2")) {
            if (battle != null && battle.checkAttackerAlive()) {
                battleComment("What will " + battle.ally.name + " do?","");
                currentGui = data.fightOptions;
            } 
            else if (!battle.checkAttackerAlive()){
              faint(battle.attacker);
            }
          }
          
          else if (choice.equals("faint")) {
            if (fainter == battle.ally) {
              checkAllyAlive();
            } else if (battle.opponent == null) {
              battleComment("You have won the battle!","win");
            } else {
              //NPC SENDS OUT POKEMON HERE
            }
          }
          
          else if (choice.equals("win")) {
            fainter = null;
            returnHome();
          }
          
          else if (choice.equals("lose")) {
            fainter = null;
            returnHome();
          }
          
        }
      }
    }
    if (battlecomment != null) {
      fill(255);
      textSize(30);
      textFont(data.font);
      String section = battlecomment;
      if (!hp && !faint && frame < battlecomment.length()) {
        section = battlecomment.substring(0,frame);
      }
      text(section,50,730);
    }
    popMatrix();
  }
  
  void battleComment(String s, String nextChoice){
    frame = 0;
    battlecomment = s + "             ";
    commenting = true;
    inAnimation = true;
    choice = nextChoice;
    transition = false;
    hp = false;
  }
  
  void returnHome(){
    battle = null;
    currentGui = data.homeScreen;
    battlecomment = null;
    inAnimation = false;
  }
  
  void effectivenessMessage(float effectiveness, int attack){
    String comment = "       ";
    if (effectiveness == 0) comment = "It had no effect...";
    if (effectiveness > 1) comment = "It was super effective!";
    if (effectiveness < 1) comment = "It wasn't very effective...";
    if (attack == 1){
      battleComment(comment,"effective1");
    } else if (attack == 2){
      battleComment(comment,"effective2");
    }
  }
  
  void hpBar(Pokemon attacker, Pokemon attacked){
    prevHp = attacked.hp;
    effectiveness = attacker.attack(attacked);
    newHp = attacked.hp;
    hplowerer = attacked;
    frame = 1;
    hp = true;
    inAnimation = true;
    transition = true;
  }
  
  void expBar(){
    prevExp = battle.ally.exp;
    gainedExp = battle.ally.gainExp(fainter);
    frame = 0;
    exp = true;
    inAnimation = true;
    transition = true;
  }
  
  void checkAllyAlive(){
    boolean alive = false;
    for (Pokemon pokemon:player.team) { //Checks remaining pokemon if they are alive
      if (pokemon.hp > 0) alive = true;
    }
    if (alive) { //able to choose what to switch to if there is an alive pokemon
      currentGui = data.deadPokemon;
      fainter = null;
      battlecomment = null;
    } else {
      battleComment("You have lost the battle...","lose");
    }
  }
  
  void faint(Pokemon f){
    fainter = f;
    frame = 0;
    faint = true;
    inAnimation = true;
  }
}
