public class BattleMode{
  String weather;
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
  
  void display(){
    image(data.battleBG,0,0);
    image(data.battleCircles,0,0);
    image(enemy.sprite,940,380-enemy.sprite.height);
    image(ally.sprite,130,800-ally.sprite.height);
    fill(0,100);
    rect(0,650,1440,214);
  }
}
