public class BattleMode{
  String weather = "none";
  NPC opponent;
  Pokemon ally, enemy;
  Button chosenButton; //this is to track which pokemon is chosen in the switch menu;
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
    
    if (opponent == null && winner == ally){ //if there is no npc being fought, battle ends after enemy is dead
      battle = null;
      currentGui = data.homeScreen;
    } else if (winner == enemy){
      boolean alive = false;
      for (Pokemon pokemon:player.team) {
        if (pokemon.hp > 0) alive = true;
      }
      if (alive) {
        currentGui = data.deadPokemon;
      } else {
        battle = null;
        currentGui = data.homeScreen;
      }
    }
  }
  
  void display(){
    image(data.battleBG,0,0);
    image(data.battleCircles,0,0);
    
    //The bottom transparent rectangle and options
    if (!animations.inAnimation) {
      textSize(40);
      fill(0);
      image(enemy.sprite,940,400-enemy.sprite.height);
      text(enemy.hp,940,400);
      image(ally.sprite,130,800-ally.sprite.height);
      text(ally.hp,130,800);
      fill(0,100);
      rect(0,650,1440,214);
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
