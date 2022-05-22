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

  void modifyTile(String mode, boolean b){
    boolean bool = b;
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
}
