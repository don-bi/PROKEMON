public class Button{
  int x,y;
  PImage texture;
  Gui opensGui;
  String special;

  public Button(Gui in,int X,int Y){
    in.buttons.add(this);
    x = X;
    y = Y;
  }
 
 public Button(Gui in, Gui opens, int X, int Y){
   this(in,X,Y);
   opensGui = opens;
 }
 
 public Button(Gui in, Gui opens, int X, int Y, String s){
   this(in,opens,X,Y);
   special = s;
 }
 
 public Button(Gui in, int X, int Y, String s){
   this(in,X,Y);
   special = s;
 }
 
  
  void display(){
    if (texture != null) image(texture,x,y);
    if (special != null){
      textSize(50);
      fill(0);
      Pokemon poke = battle.ally;
      switch (special){ //displays the move buttons is battle
        case "move1":
          if (poke.moves[0] != null) text(poke.moves[0].toString(),x+10,y+texture.height/2);
          break;
        case "move2":
          if (poke.moves[1] != null) text(poke.moves[1].toString(),x+10,y+texture.height/2);
          break;
        case "move3":
          if (poke.moves[2] != null) text(poke.moves[2].toString(),x+10,y+texture.height/2);
          break;
        case "move4":
          if (poke.moves[3] != null) text(poke.moves[3].toString(),x+10,y+texture.height/2);
          break;
      }
    }
  }
  
  void processClick(){
    if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
      if (special == null){
        currentGui = opensGui;
      } else {
        Pokemon poke = battle.ally; //special cases for move buttons
        boolean endturn = false;
        if (special.equals("move1") && poke.moves[0] != null) {
          poke.currentMove = poke.moves[0];
          endturn = true;
        }
        if (special.equals("move2") && poke.moves[0] != null) {
          poke.currentMove = poke.moves[1];
          endturn = true;
        }
        if (special.equals("move3") && poke.moves[0] != null) {
          poke.currentMove = poke.moves[2];
          endturn = true;
        }
        if (special.equals("move4") && poke.moves[0] != null) {
          poke.currentMove = poke.moves[3];
          endturn = true;
        }
        if (endturn) {
          currentGui = null;
          battle.doTurn();
        }
      }
    }
  }
}
