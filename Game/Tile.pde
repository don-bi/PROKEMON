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
  }
  
  void resetTile(){
    isWalkable = true;
    isInteractable = false;
    isWarp = false;
    isDoor = false;
    isEvent = false;
    isForeground = false;
    isGrass = false;
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
  }
  
  void setWarp(int x, int y, String loc){
    warpMap = loc;
    warpCoord = new int[]{x,y};
  }
  
  char condenseData(boolean bool){
    if(bool) return 't';
    return 'f';
  }
  
  String toString(){
    return "" + condenseData(isWalkable) + ',' + condenseData(isInteractable)  + ',' + condenseData(isWarp) + ',' + condenseData(isDoor) + ',' + condenseData(isEvent) + ',' + condenseData(isForeground);
  }
  
  void printData(){
    println("isWalkable:"+isWalkable+" isInteractable:"+isInteractable+" isWarp:"+isWarp+" isDoor:"+isDoor+" isEvent:"+isEvent+" isForeground:"+isForeground + " isGrass:"+isGrass);
  }
}
