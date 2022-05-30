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
      textSize(40);
      fill(0);
      switch (special){
        case "poke1":
          poke = player.team.get(0);
          text(poke.name,270,250);
          text("Lv"+poke.level,300,290);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),280,327);
          break;
        case "poke2":
          poke = player.team.get(1);
          text(poke.name,690,120);
          text("Lv"+poke.level,720,160);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,122);
          break;
        case "poke3":
          poke = player.team.get(2);
          text(poke.name,690,200);
          text("Lv"+poke.level,720,240);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,202);
          break;
        case "poke4":
          poke = player.team.get(3);
          text(poke.name,690,280);
          text("Lv"+poke.level,720,320);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,282);
          break;
        case "poke5":
          poke = player.team.get(4);
          text(poke.name,690,360);
          text("Lv"+poke.level,720,400);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,362);
          break;
        case "poke6":
          poke = player.team.get(5);
          text(poke.name,690,440);
          text("Lv"+poke.level,720,480);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,442);
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
