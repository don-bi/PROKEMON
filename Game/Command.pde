public class Command {
  boolean commandmode;
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
    commandmode = false;
    animations.inAnimation = false;
  }
  
  void display(){
    fill(255);
    rect(0,402,1440,60);
    fill(0);
    textSize(40);
    String c = currentcommand;
    if (frameCount % 60 < 30) c += "|";
    text(c,10,412);
  }
    
  void add(){
    currentcommand += key;
  }
}
