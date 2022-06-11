public class Command {
  boolean commandmode,ctrl;
  String currentcommand;
  
  public Command(){
    commandmode = false;
    currentcommand = "";
  }
  
  void open(){
    commandmode = true;
    animations.inAnimation = true;
  }
  
  void execute(){ //excutes the command when pressed enter again based on first word
    try {
      if (currentcommand.length() > 0) {
        String[] parts = currentcommand.split(" ");
        for (int i = 0; i < parts.length; i ++){
          parts[i] = parts[i].toLowerCase();
        }
        if (parts[0].equals("set")) {
          int whichpoke = parseInt(parts[1])-1;
          String pokename = parts[2].substring(0,1).toUpperCase() + parts[2].substring(1);
          int level = parseInt(parts[3]);
          if (whichpoke < player.team.size() && whichpoke > -1) player.team.set(whichpoke,new Pokemon(pokename,level,true));
        }
        if (parts[0].equals("setmove")) {
          Pokemon poke = player.team.get(parseInt(parts[1])-1);
          int whichmove = parseInt(parts[2])-1;
          String moveid = data.getMoveId(parts[3]);
          Move newmove = new Move(moveid);
          if (!newmove.damageClass.equals("status") || poke.checkMoveEffects(newmove) && newmove.power != -1) {
            poke.moves[whichmove] = new Move(moveid);
          } else {
            animations.overworldComment("That move is not implemented yet, sorry!","commanderror");
          }
        }
        if (parts[0].equals("fight")) {
          Pokemon poke = new Pokemon(parts[1].substring(0,1).toUpperCase() + parts[1].substring(1),parseInt(parts[2]));
          battle = new BattleMode(poke);
        }
        if (parts[0].equals("giveitems")) {
          player.bag.pokeballs += 5;
          player.bag.masterballs += 5;
          player.bag.potions += 5;
        }
          
      }
      commandmode = false;
      animations.inAnimation = false;
      currentcommand = "";
    } catch (Exception e) {
      animations.overworldComment("Bad command","commanderror");
      commandmode = false;
      animations.inAnimation = false;
      currentcommand = "";
    }
  }
  
  void display(){ //displays the command bar =
    fill(255);
    rect(0,392,1440,40);
    fill(0);
    textSize(40);
    String c = currentcommand;
    if (frameCount % 60 < 30) c += "_";
    text(c,10,422);
  }
    
  void add(){
    if (key == BACKSPACE) remove();
    else if (key != ENTER) currentcommand += key;
  }
  
  void remove(){
    if (currentcommand.length() > 0) currentcommand = currentcommand.substring(0,currentcommand.length()-1);
  }
}
