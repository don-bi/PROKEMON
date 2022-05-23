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

<<<<<<< HEAD
=======


>>>>>>> editingHanson
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

<<<<<<< HEAD
=======


  //determines size of combined image to place correctly

>>>>>>> editingHanson
  PImage colorChecker(){
    PImage temp = createImage(size, size, ARGB);
    temp.loadPixels();
    color clr = color(0,1);

    if (!isWalkable) clr = color(255, 0, 0, 100);
<<<<<<< HEAD
=======
    if (isInteractable) clr = color(232, 247, 89, 100);
    if (isWarp) clr = color(173, 44, 242, 100);
    if (isDoor) clr = color(176, 123, 99, 100);
    if (isEvent) clr = color(101, 235, 94, 100);
    if (isForeground) clr = color(8, 214, 255, 100);
    if (isGrass) clr = color(0,100);
>>>>>>> editingHanson

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
<<<<<<< HEAD
  }

  void modifyTile(String mode, boolean b){
    boolean bool = b;
=======
    texture = colorChecker();
  }

  void modifyTile(String mode, String s){
    boolean bool = s.equals("add");
>>>>>>> editingHanson
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
<<<<<<< HEAD
=======

  void printData(){
    println("isWalkable:"+isWalkable+" isInteractable:"+isInteractable+" isWarp:"+isWarp+" isDoor:"+isDoor+" isEvent:"+isEvent+" isForeground:"+isForeground+" isGrass:"+isGrass);
  }

>>>>>>> editingHanson
}
