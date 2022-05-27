public class Button{
  int x,y;
  PImage texture;
  Gui opensGui;
  boolean special;

  public Button(Gui o){
    opensGui = o;
    special = false;
  }
  
  void display(){
    image(texture,x,y);
  }
  
  void processClick(){
    if (!special){
      if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
        opensGui.on = true;
        opensGui.prev.on = false;
      }
    }
  }
}
