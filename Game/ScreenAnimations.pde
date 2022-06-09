public class ScreenAnimations {
  boolean inAnimation, fadein, fadeout, commenting, hp, exp, transition, faint, balling, ballshake, captured, battlestart;
  PImage savedSprite, ballType;
  Pokemon hplowerer, fainter;
  int prevHp,newHp,prevExp,gainedExp;
  String battlecomment;
  String choice;
  int frame, ballshakes;
  float effectiveness;
  
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
      if (balling) {
        if (frame < 50) {
          frame ++;
          pushMatrix();
          int x = 98+frame*20;
          int y = round(0.001030*pow(x,2)-1.361*x+623.5);
          translate(x,y);
          rotate(radians(frame*36));
          image(ballType,-48,-48);
          popMatrix();
        } else if (frame < 80) {
          frame ++;
          image(ballType,1050,330);
          fainter = battle.enemy;
        } else {
          balling = false;
          inAnimation = false;
          fainter = null;
          shakeball();
        }
      }
      if (ballshake) {
        pushMatrix();
        translate(1098,378);
        if (frame <= 9) {
          frame ++;
          rotate(radians(frame*5));
        } else if (frame <= 27) {
          frame ++;
          rotate(radians((frame-9)*-5+45));
        } else if (frame <= 36) {
          frame ++;
          rotate(radians((frame-27)*5-45));
        } else if (frame <= 120) {
          frame ++;
        } else {
          ballshake = false;
          inAnimation = false;
          shakeball();
        }
        image(ballType,-48,-48); 
        popMatrix();
      }
      if (captured) { //displays a dark ball when you captured the pokemon
        tint(120);
        image(ballType,1050,330);
        noTint();
      }
      if (battlestart) {
        if (frame < 40){
          frame ++;
          for (int i = 0; i < 12; i ++){
            noStroke();
            fill(0,frame*7);
            rect(0,i*72,frame*36,36);
            rect(1440-frame*36,36+i*72,frame*36,36);
          }
        } else if (frame < 60) {
          frame ++;
          fill(0);
          rect(0,0,1440,864);
        } else if (frame < 100) {
          frame ++;
          image(data.battleBG,0,0);
          for (int i = 0; i < 12; i ++) {
            int framediff = frame-60; //makes up for the animation of previous frames
            noStroke();
            fill(0,255-framediff*7);
            rect(0,i*72,1440-(frame-60)*36,36);
            rect(framediff*36,36+i*72,1440-framediff*36,36);
          }
        } else if (frame < 160) {
          frame++;
          int framediff = frame-100;
          image(data.battleBG,0,0);
          image(data.lefthalf,-1440+framediff*24,530);
          image(data.righthalf,1440-framediff*24,0);
          if (battle.opponent == null) {
            image(battle.enemy.sprite,2380-framediff*24,400-battle.enemy.sprite.height);
          }
        } else {
          currentGui = data.fightOptions;
          battlestart = false;
          inAnimation = false;
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
          setNewStatus(1);
        }
        else if (choice.equals("secondAttack")) {
          setNewStatus(2);
        }
      }
    }
    if (exp) {
      if (frame < 20) {
        frame ++;
        battle.ally.exp += gainedExp/20.0;
        if (battle.ally.exp > battle.ally.neededExp) {
          float expOver = battle.ally.exp - battle.ally.neededExp;
          battle.ally.levelUp();
          battle.ally.exp += expOver;
          println(battle.ally.exp);
        }
      } else {
        exp = false;
        if (battle.opponent == null) {
          battleComment("You have won the battle!","win");
        } else {
          //NPC SENDS OUT POKEMON HERE
        }
      }
    }
    
    if (frameCount % 2 == 0){ 
       if (commenting) {
        if (frame < battlecomment.length()) {
          frame++;
          //if (choice.equals("effective1")) println(frame);
        } else {
          commenting = false;
          inAnimation = false;
          
          if (choice.equals("skip1")) {
            effectivenessMessage(1,1);
          }
          
          else if (choice.equals("thaw1")) {
            animations.battleComment(battle.attacker.name + " used " + battle.attacker.currentMove + "!","fight");
          }
          
          else if (choice.equals("fight")) {
            if (!transition) hpBar(battle.attacker, battle.defender);
          } 
          
          else if (choice.equals("status1")) {
            effectivenessMessage(effectiveness,1);
          }
          
          else if (choice.equals("alreadystatus1")) {
            effectivenessMessage(effectiveness,1);
          }
          
          else if (choice.equals("effective1")) {
            if (battle.checkDefenderAlive()) {
              if (!statusSkip(battle.defender)) battleComment(battle.defender.name + " used " + battle.defender.currentMove + "!","secondAttack");
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
            effectivenessMessage(1,1);
          }
          
          else if (choice.equals("skip2")) {
            effectivenessMessage(1,2);
          }
          
          else if (choice.equals("thaw2")) {
            if (battle.checkDefenderAlive()) {
              battleComment(battle.defender.name + " used " + battle.defender.currentMove + "!","secondAttack");
            } else {
              faint(battle.defender);
            }
          }
          
          else if (choice.equals("secondAttack")) {
            if (!transition) hpBar(battle.defender, battle.attacker);
          }
          
          else if (choice.equals("status2")) {
            effectivenessMessage(effectiveness,2);
          }
          
          else if (choice.equals("alreadystatus2")) {
            effectivenessMessage(effectiveness,2);
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
            } else {
              expBar();
            }
          }
          
          else if (choice.equals("freed")) {
            battle.playerchoice = "bag";
            battle.doTurn();
            effectivenessMessage(1,1);
          }
          
          else if (choice.equals("capture")) {
            player.capturePoke(battle.enemy);
            expBar();
          }
          
          else if (choice.equals("exp")) {
            frame = 0;
            exp = true;
            inAnimation = true;
            transition = true;
          }
          
          
          else if (choice.equals("win")) {
            fainter = null;
            captured = false;
            returnHome();
          }
          
          else if (choice.equals("lose")) {
            fainter = null;
            captured = false;
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
      if (!hp && !faint && !exp && frame < battlecomment.length()) {
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
    else if (effectiveness > 1) comment = "It was super effective!";
    else if (effectiveness < 1) comment = "It wasn't very effective...";
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
    trainEVs();
    battleComment(battle.ally.name + " has gained " + gainedExp + " experience!", "exp");
  }
  
  private void trainEVs(){
    int sum = 0;
    HashMap<String,Integer> allyEVs = battle.ally.EVs;
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"}; //stats
    for (String stat:statnames){
      sum += allyEVs.get(stat); //finds the total value of all EVs combined first
    }
    for (String stat:statnames){
      if (allyEVs.get(stat) < 252 && sum < 510){ //max limit of EVs for a stat is 252, checks that, and max limit for total is 510
        int evGain = data.expGain.get(fainter.name).get(stat); //gets data for the exp gained from the enemy pokemon for that stat
        allyEVs.put(stat,allyEVs.get(stat)+evGain); //adds it to the current EV of that stat
        sum += evGain; //adds to sum too
        if (sum > 510) { //makes sure total evs dont go over 510 limit
          int difference = sum - 510;
          allyEVs.put(stat,allyEVs.get(stat)-difference);
        } else if (allyEVs.get(stat) > 252){ //make sure the stat's evs dont go over 252 limit
          int difference = 252 - allyEVs.get(stat);
          allyEVs.put(stat,allyEVs.get(stat)-difference);
        }
      }
    }
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
  
  void throwball(PImage balltype){
    ballType = balltype;
    currentGui = null;
    frame = 0;
    inAnimation = true;
    balling = true;
  }
  
  void shakeball(){ //USED THE FORMULA FROM https://bulbapedia.bulbagarden.net/wiki/Catch_rate
    fainter = battle.enemy; //does this so that enemy sprite doesnt appear (look display method in BattleMode)
    float rate = data.capturerates.get(battle.enemy.name);
    float ball = 1;
    float bonus = 1;
    String status = battle.enemy.nonvolStatus;
    if (status.equals("sleep") || status.equals("freeze")) bonus = 2.5;
    if (status.equals("paralysis") || status.equals("burn") || status.equals("poison")) bonus = 1.5;
    float a = ((3*battle.enemy.stats.get("hp")-2*battle.enemy.hp)*rate*ball)/(3.0*battle.enemy.stats.get("hp"))*bonus;
    int b = floor(65536.0/(sqrt(sqrt(255/a))));
    if (ballType == data.masterball) b = 65536; //masterball is always b value 65536
    println(b);
    int rand = (int)random(65536); //generates random value 0 to 65535 inclusive and if its less than b, shakes
    if (rand < b) {
      if (ballshakes == 3) { //needs to shake check 4 times successfully to capture
        battleComment("You have successfully captured " + battle.enemy.name + "!","capture");
        ballshakes = 0;
        ballshake = false;
        inAnimation = false;
        captured = true;
      } else {
        ballshake = true;
        inAnimation = true;
        frame = 1;
        ballshakes ++;
      }
    } else {
      battleComment("Oh, no! " + battle.enemy.name + " broke free!","freed");
      fainter = null;
      ballshakes = 0;
      ballshake = false;
      inAnimation = false;
    }
  }
  
  boolean statusSkip(Pokemon p){
    String status = p.nonvolStatus;
    int whichpoke = 1; //will check as attacker
    if (p == battle.defender) whichpoke = 2; //the pokemon is the defender, then it switches to defender 
    if (status.equals("freeze")) {
      if ((int)random(100) < 20) { //random chance of thawing out
        battleComment(p.name + " has thawed out!","thaw"+whichpoke);
        p.nonvolStatus = "none";
      } else { //random chance of not moving
        battleComment(p.name + " is frozen solid! It can't move!","skip"+whichpoke);
      }
      return true;
    } else if (status.equals("paralysis")) {
      if ((int)random(100) < 25) { //random chance of not moving
        battleComment(p.name + " is paralyzed! It can't move!","skip"+whichpoke);
        return true;
      }
    } else if (status.equals("sleep")) {
      p.nonvolTurns ++;
      if (p.nonvolTurns < 3) { //first turn is always asleep, second turn 50% to wake up, third turn always wakes up
        if (p.nonvolTurns == 2) {
          if ((int)random(100) < 50) { //calculates 50 chance to wake up 2nd turn
            battleComment(p.name + " is fast asleep!","skip"+whichpoke);
          } else { //fails the 50 50
            battleComment(p.name + " woke up!","thaw"+whichpoke);
          }
        } else { //first turn always asleep
          battleComment(p.name + " is fast asleep!","skip"+whichpoke);
        }
      } else { //3rd turn always wake up
        battleComment(p.name + " woke up!","thaw"+whichpoke);
      }
      return true;
    }
        
    return false;
  }
  
  void setNewStatus(int attack){
    Pokemon attacker = battle.attacker;
    Pokemon attacked = battle.defender;
    if (attack == 2) {
      attacker = battle.defender;
      attacked = battle.attacker;
    }
    Move usedmove = attacker.currentMove;
    if (usedmove.effect != 1) {
      println("HIII");
      if (usedmove.damageClass.equals("status")) effectiveness = 1; //if it's a status move, there will be no effectiveness message 
      if (attacked.nonvolStatus.equals("none")) { //checks for applying nonvolatile statuses
        
        String statuscomment = "";
        String newstatus = null;
        if (usedmove.effect == 7) {
          statuscomment = "became paralyzed!";
          newstatus = "paralysis";
        }
        else if (usedmove.effect == 6) {
          statuscomment = "became frozen!";
          newstatus = "freeze";
        }
        else if (usedmove.effect == 5) {
          statuscomment = "became burned!";
          newstatus = "burn";
        }
        else if (usedmove.effect == 3) {
          statuscomment = "became poisoned!";
          newstatus = "poison";
        }
        else if (usedmove.effect == 2) {
          statuscomment = "fell asleep!";
          newstatus = "sleep";
        }
        
        if (!(newstatus == null) && (int)random(100) < usedmove.effectChance) { //applies status based on effectchance of the move
          attacked.nonvolStatus = newstatus;
          print(attacked.nonvolStatus);
          battleComment(attacked.name + " " + statuscomment,"status"+attack);
        } else {
          effectivenessMessage(effectiveness,attack);
        }
      } else { //IF there is already a status effect, then it makes a comment that the pokemon already has that status and it can't gain a new one
        if (usedmove.effectChance == 100) { //only works at 100% chance or else that's weird that ice punch will say it sometimes at 10% and not
          String c1 = "";
          String c2 = "";
          if (attacked.nonvolStatus.equals("paralysis")) c1 = " paralyzed ";
          if (attacked.nonvolStatus.equals("freeze")) c1 = " frozen ";
          if (attacked.nonvolStatus.equals("burn")) c1 = " burned ";
          if (attacked.nonvolStatus.equals("poison")) c1 = " poisoned ";
          if (attacked.nonvolStatus.equals("sleep")) c1 = " asleep ";
          if (usedmove.effect == 7) c2 = " bcame paralyzed";
          if (usedmove.effect == 6) c2 = " become frozen";
          if (usedmove.effect == 5) c2 = " become burned";
          if (usedmove.effect == 3) c2 = " become poisoned";
          if (usedmove.effect == 2) c2 = " fall asleep";
          if (c2.equals("")) { //only works when the move being used applies another status condition
            effectivenessMessage(effectiveness,attack);
          } else {
            battleComment(attacked.name + " is already" + c1 + "they cannot" + c2 + "!","alreadystatus" + attack);
          }
        } else {
          effectivenessMessage(effectiveness,attack);
        }
      }
    } else {
      effectivenessMessage(effectiveness,attack);
    }
  }
  
  void startBattle(){
    frame = 0;
    battlestart = true;
    inAnimation = true;
    currentGui = null;
  }
}
