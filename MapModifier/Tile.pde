public class Tile{
  boolean isWalkable;
  boolean isInteractable;
  boolean isWarp;

  public Tile(int s){
    isWalkable = true;
    isInteractable = false;
    isWarp = false;
  }

  void resetTile(){
    isWalkable = true;
    isInteractable = false;
    isWarp = false;
  }

  void modifyTile(String mode, boolean bool){
    if (mode == "isWalkable") {
      isWalkable = !isWalkable;
    }
  }
}
