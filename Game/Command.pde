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
  
  void execute(){
    try {
      if (currentcommand.length() > 0) {
        String[] parts = currentcommand.split(" ");
        for (int i = 0; i < parts.length; i ++){
          parts[i] = parts[i].toLowerCase();
        }
        if (parts[0].equals("set")) {
          printArray(parts);
          int whichpoke = parseInt(parts[1])-1;
          String pokename = parts[2].substring(0,1).toUpperCase() + parts[2].substring(1);
          int level = parseInt(parts[3]);
          if (whichpoke < 6 && whichpoke > -1) player.team.set(whichpoke,new Pokemon(pokename,level,true));
        }
        if (parts[1].equals("setmove")) {
          int whichpoke = parseInt(parts[1])-1;
          int whichmove = parseInt(parts[2])-1;
          String moveid = data.getMoveId(parts[3]);
          player.team.get(whichpoke).moves[whichmove] = new Move(moveid);
        }
          
      }
      commandmode = false;
      animations.inAnimation = false;
      currentcommand = "";
    } catch (Exception e) {
      println("bad command");
      commandmode = false;
      animations.inAnimation = false;
      currentcommand = "";
    }
  }
  
  void display(){
    fill(255);
    rect(0,402,1440,60);
    fill(0);
    textSize(40);
    String c = currentcommand;
    if (frameCount % 60 < 30) c += "_";
    text(c,10,412);
  }
    
  void add(){
    if (key == BACKSPACE) remove();
    else if (key != ENTER) currentcommand += key;
  }
  
  void remove(){
    if (currentcommand.length() > 1) currentcommand = currentcommand.substring(0,currentcommand.length()-1);
  }
}
