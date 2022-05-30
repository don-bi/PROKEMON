public class BattleMode{
  String weather = "none";
  NPC opponent;
  Pokemon ally, enemy;
  
  public BattleMode(NPC opp){ //Trainer encounter
    opponent = opp;
    int i = 0;
    while (player.team[i].hp == 0 && i != 6){
      i ++;
    }
    ally = player.team[i];
    enemy = opponent.team[i];
  }
  
  public BattleMode(Pokemon p){ //Wild pokemon encounter
    int i = 0;
    /*while (player.team[i].hp == 0 && i != 6){
      i ++;
    }*/
    ally = player.team[i];
    enemy = p;
  }
  
  void doTurn(){
    //TURN SYSTEM
    Move enemymove = enemy.moves[(int)random(4)];
    enemy.currentMove = enemymove;
    Pokemon attacker = ally;
    Pokemon defender = enemy;
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
    //checks if defender is dead
    if (defender.hp == 0){
      animations.wait(300);
      battle = null;
      currentGui = data.homeScreen;
    }
    if (battle != null) {
      defender.attack(attacker);
      //checks if attacker is dead
      if (attacker.hp == 0){
        animations.wait(300);
        battle = null;
        currentGui = data.homeScreen;
      }
      if (battle != null) {
        currentGui = data.fightOptions;
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
      image(enemy.sprite,940,380-enemy.sprite.height);
      text(enemy.hp,940,400);
      image(ally.sprite,130,800-ally.sprite.height);
      text(ally.hp,130,800);
      fill(0,100);
      rect(0,650,1440,214);
    }
  }
}
