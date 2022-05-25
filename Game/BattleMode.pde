public class BattleMode{
  String weather;
  NPC opponent;
  Pokemon ally, enemy;
  
  public BattleMode(NPC opp){
    opponent = opp;
    int i = 0;
    while (player.team[i].hp == 0 && i != 6){
      i ++;
    }
    ally = player.team[i];
    enemy = opponent.team[i];
  }
  
  void display(){}
}
