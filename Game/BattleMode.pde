public class BattleMode{
  String weather = "none";
  NPC opponent;
  Pokemon ally, enemy;
  Pokemon winner;
  String playerchoice; //(switch,fight,run,bag so doturn can tell what to do)
  
  public BattleMode(NPC opp){ //Trainer encounter
    opponent = opp;
    int i = 0;
    while (player.team.get(i).hp == 0 && i != 6){
      i ++;
    }
    ally = player.team.get(i);
    enemy = opponent.team.get(i);
    addSwitchButtons();
  }
  
  public BattleMode(Pokemon p){ //Wild pokemon encounter
    int i = 0;
    while (player.team.get(i).hp == 0 && i != 6){
      i ++;
    }
    ally = player.team.get(i);
    enemy = p;
    addSwitchButtons();
  }
  
  void doTurn(){
    //TURN SYSTEM
    Move enemymove = null;
    while (enemymove == null) enemymove = enemy.moves[(int)random(4)];
    enemy.currentMove = enemymove;
    Pokemon attacker = ally;
    Pokemon defender = enemy;
    
    if (playerchoice.equals("fight")) {
      int allyPriority = ally.currentMove.priority;
      int enemyPriority = enemy.currentMove.priority;
      if (allyPriority < enemyPriority) {
        attacker = enemy;
        defender = ally;
      } else if (allyPriority == enemyPriority && ally.stats.get("spd") < enemy.stats.get("spd")) {
        attacker = enemy;
        defender = ally;
      }
      attacker.attack(defender);
    } else if (playerchoice.equals("bag")) {
    } else {
      ally = player.team.get(parseInt(playerchoice));
      attacker = ally;
    }
    
    //checks if defender is dead
    if (defender.hp == 0){
      winner = attacker;
    }
    if (winner == null) {
      defender.attack(attacker);
      //checks if attacker is dead
      if (attacker.hp == 0){
        winner = defender;
      }
      if (winner == null) {
        currentGui = data.fightOptions;
      }
    }
    
    if (winner == ally){
      battle = null;
      currentGui = data.homeScreen;
    }
    if (winner == enemy){
      battle = null;
      currentGui = data.homeScreen;
    }
  }
  
  void display(){
    image(data.battleBG,0,0);
    image(data.battleCircles,0,0);
    
    //The bottom transparent rectangle and options
    if (!animations.inAnimation) {
      textSize(40);
      fill(0);
      image(enemy.sprite,940,380-enemy.sprite.height);
      text(enemy.hp,940,400);
      image(ally.sprite,130,800-ally.sprite.height);
      text(ally.hp,130,800);
      fill(0,100);
      rect(0,650,1440,214);
    }
  }
  
  private void addSwitchButtons(){ //adds buttons for switching based on pokemon on team
    data.switchPokemon.buttons = new ArrayList<Button>();
    switch(player.team.size()){
      case(6):
        data.poke6 = new Button(data.switchPokemon,560,562,"poke6");
        data.poke6.texture = data.smallPoke;
      case(5):
        data.poke5 = new Button(data.switchPokemon,560,442,"poke5");
        data.poke5.texture = data.smallPoke;
      case(4):
        data.poke4 = new Button(data.switchPokemon,560,322,"poke4");
        data.poke4.texture = data.smallPoke;
      case(3):
        data.poke3 = new Button(data.switchPokemon,560,202,"poke3");
        data.poke3.texture = data.smallPoke;
      case(2):
        data.poke2 = new Button(data.switchPokemon,560,82,"poke2");
        data.poke2.texture = data.smallPoke;
      case(1):
        data.poke1 = new Button(data.switchPokemon,130,122,"poke1");
        data.poke1.texture = data.bigChosenPoke;
    }
    data.cancel = new Button(data.switchPokemon,data.fightOptions,1040,702);
    data.cancel.texture = loadImage("cancel.png");
  }
}
