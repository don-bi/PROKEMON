public class Command {
  boolean commandmode;
  String currentcommand;
  
  public Command(){
    commandmode = false;
    currentcommand = "";
  }
  
  void open(){
    commandmode = true;
    inAnimation = true;
  }
  
  void display(){
    fill(255);
    rect(0,690,1440,60);
    fill(0);
    textSize(40);
    String c = currentcommand;
    if (frameCount % 2 == 0) c += "|";
    text(c,10,720);
  }
    
  void addLetter(){
  }
}
