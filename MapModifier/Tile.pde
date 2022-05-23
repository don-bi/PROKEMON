public class Tile{
  boolean isWalkable;
  boolean isInteractable;
  boolean isWarp;
  boolean isDoor;
  boolean isEvent;
  boolean isForeground;
  boolean isGrass;
  int size;
  String comment;  
  PImage texture;
  String warpMap;
  int[] warpCoord;
  
  
  
  public Tile(int s){
    isWalkable = true;
    isInteractable = false;
    isWarp = false;
    isDoor = false;
    isEvent = false;
    isForeground = false;
    isGrass = false;
    size = s;
    comment = "";
    texture = colorChecker();
  }
  
  
  
  //determines size of combined image to place correctly
  
  char condenseData(boolean bool){
    if(bool) return 't';
    return 'f';
  }
  
  String toString(){
    return "" + condenseData(isWalkable) + ',' + condenseData(isInteractable)  + ',' + condenseData(isWarp) + ',' + condenseData(isDoor) + ',' + condenseData(isEvent) + ',' + condenseData(isForeground) + ',' + condenseData(isGrass);
  }
  
  PImage colorChecker(){
    PImage temp = createImage(size, size, ARGB);
    temp.loadPixels();
    color clr = color(0,1);
    
    if (!isWalkable) clr = color(255, 0, 0, 100);
    if (isInteractable) clr = color(232, 247, 89, 100);
    if (isWarp) clr = color(173, 44, 242, 100);
    if (isDoor) clr = color(176, 123, 99, 100);
    if (isEvent) clr = color(101, 235, 94, 100);
    if (isForeground) clr = color(8, 214, 255, 100);
    if (isGrass) clr = color(0,100);
    
    for (int i = 0; i < temp.pixels.length; i ++){
      temp.pixels[i] = clr;
    }
    temp.updatePixels();
    return temp;
  }
  
  void resetTile(){
    isWalkable = true;
    isInteractable = false;
    isWarp = false;
    isDoor = false;
    isEvent = false;
    isForeground = false;
    isGrass = false;
    texture = colorChecker();
  }
  
  void modifyTile(String mode, String s){
    boolean bool = s.equals("add");
    switch(mode){
      case "ERASE": resetTile(); break;
      case "BLOCK": isWalkable = !bool; break;
      case "INTERACT": isInteractable = bool; break;
      case "WARP": isWarp = bool; break;
      case "DOOR": isDoor = bool; break;
      case "EVENT": isEvent = bool; break;
      case "FOREGROUND": isForeground = bool; break;
      case "GRASS": isGrass = bool; break;
    }
    texture = colorChecker();
  }
  
  void printData(){
    println("isWalkable:"+isWalkable+" isInteractable:"+isInteractable+" isWarp:"+isWarp+" isDoor:"+isDoor+" isEvent:"+isEvent+" isForeground:"+isForeground+" isGrass:"+isGrass);
  }
  
}
