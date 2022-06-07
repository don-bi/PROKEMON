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
      switch (special){ //Displays the pokemon name and level in the switchpokemon screen
        case "poke1":
          poke = player.team.get(0);
          text(poke.name,270,250);
          text("Lv"+poke.level,300,290);
          PImage icon = data.frontSprites.get(poke.name).get(poke.mode);
          icon.resize(96,96);
          image(icon,100,100);
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
          text(poke.name,690,240);
          text("Lv"+poke.level,720,280);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,242);
          break;
        case "poke4":
          poke = player.team.get(3);
          text(poke.name,690,360);
          text("Lv"+poke.level,720,400);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,362);
          break;
        case "poke5":
          poke = player.team.get(4);
          text(poke.name,690,480);
          text("Lv"+poke.level,720,520);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,482);
          break;
        case "poke6":
          poke = player.team.get(5);
          text(poke.name,690,600);
          text("Lv"+poke.level,720,640);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,602);
          break;
      }
      textSize(72);
      switch (special) {
        case "pokeball":
          text("POKé BALL",690,158);
          text("x"+player.bag.pokeballs,1170,158);
          break;
        case "masterball":
          text("MASTER BALL",690,216);
          text("x"+player.bag.masterballs,1170,216);
          break;
        case "potion":
          text("POTION",690,158);
          text("x"+player.bag.potions,1170,158);
          break;
      }
    } //ends if (special !null)
  }
  
  void processHover(){
  }
  
  void processClick(){
    if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
      if (special == null){
        currentGui = opensGui;
      } else {
        Pokemon poke = battle.ally; //special cases for move buttons
        boolean endturn = false;
        String choice = "";
        poke.currentMove = null;
        
        if (special.equals("endComment")) {
          animations.battlecomment = null;
          animations.inAnimation = false;
          animations.commenting = false;
          currentGui = opensGui;
        }
        
        if (special.equals("pokeball")) {
          animations.throwball(data.pokeball);
        }
        if (special.equals("masterball")) {
          animations.throwball(data.masterball);
        }
        if (special.equals("potion")) {
        }
        
        if (special.length() > 3 && special.substring(0,4).equals("move")) { //special interactions for move option buttons
          if (special.equals("move1") && poke.moves[0] != null) poke.currentMove = poke.moves[0];
          if (special.equals("move2") && poke.moves[1] != null) poke.currentMove = poke.moves[1];
          if (special.equals("move3") && poke.moves[2] != null) poke.currentMove = poke.moves[2];
          if (special.equals("move4") && poke.moves[3] != null) poke.currentMove = poke.moves[3];
          if (poke.currentMove != null) {
            choice = "fight";
            endturn = true;
          }
        }
        
        if (special.length() > 3 && special.substring(0,4).equals("poke")) { //special interactions for switching pokemon buttons
          if (special.equals("poke1") && battle.ally != player.team.get(0) && player.team.get(0).hp > 0) {
            choice = "0";
            endturn = true;
            texture = data.bigChosenPoke;
            y -= 10;
            battle.chosenButton.texture = data.smallPoke;
            battle.chosenButton.y += 5;
            battle.chosenButton = this;
          } else {
            if (special.equals("poke2") && battle.ally != player.team.get(1) && player.team.get(1).hp > 0) choice = "1";
            if (special.equals("poke3") && battle.ally != player.team.get(2) && player.team.get(2).hp > 0) choice = "2";
            if (special.equals("poke4") && battle.ally != player.team.get(3) && player.team.get(3).hp > 0) choice = "3";
            if (special.equals("poke5") && battle.ally != player.team.get(4) && player.team.get(4).hp > 0) choice = "4";
            if (special.equals("poke6") && battle.ally != player.team.get(5) && player.team.get(5).hp > 0) choice = "5";
            if (!choice.equals("")) {
              println(choice);
              endturn = true;
              texture = data.smallChosenPoke;
              if (battle.chosenButton.special.equals("poke1")) {
                battle.chosenButton.texture = data.bigPoke;
                battle.chosenButton.y += 10;
              } else {
                battle.chosenButton.texture = data.smallPoke;
                battle.chosenButton.y += 5;
              }
              y -= 5;
              battle.chosenButton = this;
            }
          }
        }
        if (special.equals("run")){
          endturn = true;
          choice = "run";
        }
        if (endturn) {
          if (currentGui == data.deadPokemon){ //When choosing a pokemon after own died, it goes back to fight options
            currentGui = data.fightOptions;
            battle.ally = player.team.get(parseInt(choice));
            animations.battleComment("You sent out " + battle.ally.name + "!","deadPokemon");
          } else { //regular switching just ends turn
            currentGui = null;
            battle.playerchoice = choice;
            battle.doTurn();
          }
        }
      }
    }
  }
  
  String toString(){
    return special;
  }
}
