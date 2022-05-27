public class Gui{
  int x,y;
  ArrayList<Button> buttons;
  Gui prev;
  boolean on, overlay;
  PImage texture;
  
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
    }
  }
  
  void processButtons(){
    for (int i = 0; i < buttons.size(); i ++){
      buttons.get(i).processClick();
    }
  }
}
