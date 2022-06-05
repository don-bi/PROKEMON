public class BattleMode{
  String weather = "none";
  NPC opponent;
  Pokemon ally, enemy;
  Pokemon attacker, defender;
  Button chosenButton; //this is to track which pokemon is chosen in the switch menu;
  Pokemon winner;
  boolean escaped;
  int escapeAttempts = 0;
  String playerchoice; //(switch,fight,run,bag so doturn can tell what to do)
  String comment = "";
  
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
  }
  
  void doTurn(){
    //TURN SYSTEM
    Move enemymove = null;
    while (enemymove == null) enemymove = enemy.moves[(int)random(4)];
    enemy.currentMove = enemymove;
    attacker = ally;
    defender = enemy;
    boolean escaped = false;
    comment = "";
    
    //the four different options that happens depending on the button chosen
    if (playerchoice.equals("fight")) {
      fightOption();
    } else if (playerchoice.equals("bag")) {
    } else if (playerchoice.equals("run")) {
      int escapeOdds = (floor((ally.stats.get("spd")*128.0)/enemy.stats.get("spd")) + 30 * escapeAttempts) % 256;
      int rand = (int)random(256);
      if (rand < escapeOdds) {
        animations.battleComment("You have successfully escaped!","escape");
      } else {
        animations.battleComment("You couldn't successfully escape.","noescape");
        escapeAttempts ++;
      }
    } else {
      ally = player.team.get(parseInt(playerchoice));
      comment += "You sent out " + ally.name + "!\n";
      attacker = ally;
    }
    
    
    //checks if defender is dead
    
  }
  
  boolean checkDefenderAlive(){
    return defender.hp != 0;
  }
  boolean checkAttackerAlive(){
    return attacker.hp != 0;
  }
  
  void secondAttack() {
          animations.inAnimation = true;
          animations.fadein = true;
          animations.frame = -300;
          battle = null;
          currentGui = data.homeScreen;
          for (Pokemon pokemon:player.team){
            pokemon.hp = pokemon.stats.get("hp");
          }
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
    animations.battleComment(attacker.name + " used " + attacker.currentMove + ".","fight");
  }
  
  void display(){
    image(data.battleBG,0,0);
    image(data.battleCircles,0,0);
    
    //The bottom transparent rectangle and options
    textSize(40);
    fill(0);
    image(enemy.sprite,940,400-enemy.sprite.height);
    image(ally.sprite,130,800-ally.sprite.height);
    fill(0,100);
    rect(0,650,1440,214);
    fill(255);
    textSize(30);
    textFont(data.font);
    text(comment,50,730);
    
    //Displays hp bars
    textSize(45);
    fill(0);
    image(data.allyUi,860,430);
    image(data.enemyUi,320,150);
    
    if (animations.hplowerer != ally) image(data.miniHpBar.get(0,0,ally.hp*192/ally.stats.get("hp"),8),1048,498);
    if (animations.hplowerer != enemy) image(data.miniHpBar.get(0,0,enemy.hp*192/enemy.stats.get("hp"),8),476,218);
    
    image(data.expBar.get(0,0,ally.exp*124/ally.neededExp,8),984,562);
    text(ally.hp + "/ " + ally.stats.get("hp"),1120,545);
    
    text(ally.name,920,475);
    text(enemy.name,348,195);
    
    text("Lv"+ally.level,1160,475);
    text("Lv"+enemy.level,588,195);
  }
  
  private void addSwitchButtons(){ //adds buttons for switching based on pokemon on team and for when own pokemon dies
    data.switchPokemon.buttons = new ArrayList<Button>();
    data.deadPokemon.buttons = new ArrayList<Button>();
    ArrayList<Button> deadPokeButtons = data.deadPokemon.buttons;
    switch(player.team.size()){
      case(6):
        data.poke6 = new Button(data.switchPokemon,560,562,"poke6");
        data.poke6.texture = data.smallPoke;
        deadPokeButtons.add(data.poke6);
      case(5):
        data.poke5 = new Button(data.switchPokemon,560,442,"poke5");
        data.poke5.texture = data.smallPoke;
        deadPokeButtons.add(data.poke5);
      case(4):
        data.poke4 = new Button(data.switchPokemon,560,322,"poke4");
        data.poke4.texture = data.smallPoke;
        deadPokeButtons.add(data.poke4);
      case(3):
        data.poke3 = new Button(data.switchPokemon,560,202,"poke3");
        data.poke3.texture = data.smallPoke;
        deadPokeButtons.add(data.poke3);
      case(2):
        data.poke2 = new Button(data.switchPokemon,560,82,"poke2");
        data.poke2.texture = data.smallPoke;
        deadPokeButtons.add(data.poke2);
      case(1):
        data.poke1 = new Button(data.switchPokemon,130,122,"poke1");
        data.poke1.texture = data.bigChosenPoke;
        deadPokeButtons.add(data.poke1);
    }
    data.cancel = new Button(data.switchPokemon,data.fightOptions,1040,702);
    data.cancel.texture = loadImage("cancel.png");
    chosenButton = data.poke1;
  }
}
