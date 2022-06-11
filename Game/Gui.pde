public class Gui{
  int x,y;
  ArrayList<Button> buttons = new ArrayList<Button>(0);
  Gui prev;
  boolean on, overlay;
  PImage texture;
  Pokemon whichpokesdata;
  
  public Gui(PImage t,int X, int Y){
    texture = t;
    x = X;
    y = Y;
  }
  
  public Gui(int X, int Y){
    x = X;
    y = Y;
  }
  
  void display(){
    if (texture != null) image(texture,x,y);
    for (int i = 0; i < buttons.size(); i ++){
      buttons.get(i).display();
      buttons.get(i).processHover();
    }
    if (this == data.pokemondata) { //This is to display the pokemon data in the pokemondata gui
      Pokemon poke = whichpokesdata;
      PImage icon = data.frontSprites.get(poke.name).get(poke.mode).get();
      icon.resize(384,0);
      image(icon,933,77);
      icon = poke.pokeball;
      icon.resize(48,0);
      image(icon,10,49);
      fill(255);
      textSize(70);
      text(poke.name,60,90);
      text("Lv." + poke.level,420,90);
      text("DEX NO.",10,198);
      text(poke.id,360,198);
      text("HP",10,270);
      text(poke.hp+"/"+poke.stats.get("hp"),360,270);
      text("ATTACK",10,342);
      text(poke.stats.get("atk"),360,342);
      text("DEFENSE",10,414);
      text(poke.stats.get("def"),360,414);
      text("SP. ATK",10,486);
      text(poke.stats.get("spatk"),360,486);
      text("SP. DEF",10,558);
      text(poke.stats.get("spdef"),360,558);
      text("SPEED",10,630);
      text(poke.stats.get("spd"),360,630);
      text("NATURE",10,702);
      text(poke.nature,360,702);
      text("TYPE 1",10,774);
      text(poke.type1.toUpperCase(),360,774);
      text("TYPE 2",10,846);
      if (poke.type2.equals("")) { //if the pokemon has no type 2, puts the text as none instead
        text("NONE",360,846);
      } else {
        text(poke.type2.toUpperCase(),360,846);
      }
      text("MOVES LEARNED",760,558);
      if (poke.moves[0] != null) text(poke.moves[0].toString().toUpperCase(),800,630);
      if (poke.moves[1] != null) text(poke.moves[1].toString().toUpperCase(),800,702);
      if (poke.moves[2] != null) text(poke.moves[2].toString().toUpperCase(),800,774);
      if (poke.moves[3] != null) text(poke.moves[3].toString().toUpperCase(),800,846);
    }
  }
  
  void processButtons(){
    for (int i = 0; i < buttons.size(); i ++){
      buttons.get(i).processClick();
    }
  }
}
