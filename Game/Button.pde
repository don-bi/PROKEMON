public class Button{
  int x,y;
  PImage texture;
  Gui opensGui;
  boolean special;

  public Button(Gui in, Gui opens,int X,int Y){
    in.buttons.add(this);
    opensGui = opens;
    x = X;
    y = Y;
    special = false;
  }
  
  void display(){
    if (texture != null) image(texture,x,y);
  }
  
  void processClick(){
    if (!special){
      if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
        currentGui = opensGui;
      }
    }
  }
}
