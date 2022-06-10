public class BattleMode{
  String weather = "none";
  NPC opponent;
  Pokemon ally, enemy;
  Pokemon attacker, defender;
  Button chosenButton; //this is to track which pokemon is chosen in the switch menu;
  int escapeAttempts = 0;
  String playerchoice; //(switch,fight,run,bag so doturn can tell what to do)
  
  public BattleMode(NPC opp){ //Trainer encounter
    opponent = opp;
    int i = 0;
    while (player.team.get(i).hp == 0 && i != 6){
      i ++;
    }
    ally = player.team.get(i);
    enemy = opponent.team.get(0);
    currentGui = data.fightOptions;
    addSwitchButtons();
    animations.startBattle();
  }
  
  public BattleMode(Pokemon p){ //Wild pokemon encounter
    int i = 0;
    while (player.team.get(i).hp == 0 && i != 6){
      i ++;
    }
    ally = player.team.get(i);
    enemy = p;
    currentGui = data.fightOptions;
    addSwitchButtons();
    animations.startBattle();
  }
  
  void doTurn(){
    //TURN SYSTEM
    Move enemymove = null;
    while (enemymove == null) enemymove = enemy.moves[(int)random(4)];
    enemy.currentMove = enemymove;
    attacker = ally;
    defender = enemy;
    
    //the four different options that happens depending on the button chosen
    if (playerchoice.equals("fight")) {
      fightOption();
    } else if (playerchoice.equals("bag")) {
    } else if (playerchoice.equals("run")) { //escape odds formula found in https://bulbapedia.bulbagarden.net/wiki/Escape
      int escapeOdds = (floor((ally.stats.get("spd")*128.0)/(1.0*enemy.stats.get("spd"))) + 30 * escapeAttempts ) % 256;
      int rand = (int)random(256);
      if (ally.stats.get("spd") > enemy.stats.get("spd") || escapeOdds > 255 || rand < escapeOdds) {
        animations.battleComment("You have successfully escaped!","escape");
      } else {
        animations.battleComment("You couldn't successfully escape.","noescape");
        escapeAttempts ++;
      }
    } else {
      ally = player.team.get(parseInt(playerchoice));
      battle.attacker = ally;
      animations.battleComment("Go! " + battle.ally.name + "!","switchPokemon");
      animations.switchPoke();
    }

  }
  
  boolean checkDefenderAlive(){
    return defender.hp != 0;
  }
  boolean checkAttackerAlive(){
    return attacker.hp != 0;
  }
  
  void fightOption(){
    int allyPriority = ally.currentMove.priority;
    int enemyPriority = enemy.currentMove.priority;
    if (allyPriority < enemyPriority) {
      attacker = enemy;
      defender = ally;
    } else if (allyPriority == enemyPriority && ally.stats.get("spd") < enemy.stats.get("spd")) {
      attacker = enemy;
      defender = ally;
    }
    if (!animations.statusSkip(attacker)) animations.battleComment(attacker.name + " used " + attacker.currentMove + "!","fight");
  }
  
  void display(){
    if (!animations.battlestart) { //when it's doing the battlestart animation, it doesn't show the stuffs
      image(data.battleBG,0,0);
      image(data.battleCircles,0,0);
      
      //The bottom transparent rectangle and options
      textSize(40);
      fill(0);
      if (animations.fainter != enemy) image(enemy.sprite,940,400-enemy.sprite.height);
      if (animations.fainter != ally && !animations.switchpoke || (animations.switchpoke && animations.allywhiteflash)) image(ally.sprite,130,830-ally.sprite.height);
      fill(0,100);
      rect(0,650,1440,214);
      fill(255);
      
      fill(0);
      //displays ally stuff
      if (!animations.allywhiteflash && !animations.switchpoke) {
        textSize(40);
        image(data.allyUi,860,430); //ui
        image(data.expBar.get(0,0,ally.exp*256/ally.neededExp,8),984,562); //expbar
        text(ally.hp + "/ " + ally.stats.get("hp"),1120,545); //hp value out of max
        text(ally.name,920,475); //name
        text("Lv"+ally.level,1160,475); //level
        if (!ally.nonvolStatus.equals("none")) image(data.effects.get(ally.nonvolStatus),914,490); //effect tag
        if (animations.hplowerer != ally) image(data.miniHpBar.get(0,0,ally.hp*192/ally.stats.get("hp"),8),1048,498); //hpbar
      }
      
      //displays enemy stuff
      image(data.enemyUi,320,150); //ui
      text("Lv"+enemy.level,588,195); //level
      text(enemy.name,348,195); //name
      if (!enemy.nonvolStatus.equals("none")) image(data.effects.get(enemy.nonvolStatus),342,210); //effect tag
      if (animations.hplowerer != enemy) image(data.miniHpBar.get(0,0,enemy.hp*192/enemy.stats.get("hp"),8),476,218); //hpbar
      
    }
  }
  
  private void addSwitchButtons(){ //adds buttons for switching based on pokemon on team and for when own pokemon dies
    data.switchPokemon.buttons = new ArrayList<Button>();
    data.deadPokemon.buttons = new ArrayList<Button>();
    ArrayList<Button> deadPokeButtons = data.deadPokemon.buttons;
    switch(player.team.size()){
      case(6):
        data.poke6 = new Button(data.switchPokemon,560,562,"poke6");
        data.poke6.texture = data.smallPoke;
        if (ally == player.team.get(5)) {
          data.poke6.y -= 5;
          data.poke6.texture = data.smallChosenPoke;
          chosenButton = data.poke6;
        }
        deadPokeButtons.add(data.poke6);
      case(5):
        data.poke5 = new Button(data.switchPokemon,560,442,"poke5");
        data.poke5.texture = data.smallPoke;
        if (ally == player.team.get(4)) {
          data.poke5.y -= 5;
          data.poke5.texture = data.smallChosenPoke;
          chosenButton = data.poke5;
        }
        deadPokeButtons.add(data.poke5);
      case(4):
        data.poke4 = new Button(data.switchPokemon,560,322,"poke4");
        data.poke4.texture = data.smallPoke;
        if (ally == player.team.get(3)) {
          data.poke4.y -= 5;
          data.poke4.texture = data.smallChosenPoke;
          chosenButton = data.poke4;
        }
        deadPokeButtons.add(data.poke4);
      case(3):
        data.poke3 = new Button(data.switchPokemon,560,202,"poke3");
        data.poke3.texture = data.smallPoke;
        if (ally == player.team.get(2)) {
          data.poke3.y -= 5;
          data.poke3.texture = data.smallChosenPoke;
          chosenButton = data.poke3;
        }
        deadPokeButtons.add(data.poke3);
      case(2):
        data.poke2 = new Button(data.switchPokemon,560,82,"poke2");
        data.poke2.texture = data.smallPoke;
        if (ally == player.team.get(1)) {
          data.poke2.y -= 5;
          data.poke2.texture = data.smallChosenPoke;
          chosenButton = data.poke2;
        }
        deadPokeButtons.add(data.poke2);
      case(1):
        data.poke1 = new Button(data.switchPokemon,130,122,"poke1");
        data.poke1.texture = data.bigPoke;
        if (ally == player.team.get(0)) {
          data.poke1.texture = data.bigChosenPoke;
          chosenButton = data.poke1;
        }
        deadPokeButtons.add(data.poke1);
    }
    data.cancel = new Button(data.switchPokemon,data.fightOptions,1040,702);
    data.cancel.texture = loadImage("cancel.png");
  }
}
