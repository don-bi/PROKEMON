public class ScreenAnimations {
  boolean inAnimation, fadein, fadeout;
  int frame;
  
  public ScreenAnimations() {
    inAnimation = false;
    fadein = false;
    fadeout = false;
    frame = 0;
  }
  
  void animate() {
    Tile currentTile = currentMapTiles.getTile(player.xpos, player.ypos);
    //animation conditions
    if (currentTile.isDoor) {
      animations.inAnimation = true;
      animations.fadein = true;
    }
    
    if (frameCount > 0) {
      if (fadein) {
        if (frame >= 255) {
          fadein = false;
          currentMap = currentTile.warpMap;
          try {
            currentMapTiles.loadMap(currentMap + ".txt");
          } 
          catch (IOException e) {
            println("bad file");
          }
          player.teleport(currentTile.warpCoord[0], currentTile.warpCoord[1]);
          fadeout = true;
        } else {
          fill(0, frame);
          rect(0, 0, 1440, 864);
          frame += 25;
        }
      }
      if (fadeout) {
        if (frame <= 0) {
          fadeout = false;
          inAnimation = false;
        } else {
          fill(0, frame);
          rect(0, 0, 1440, 864);
          frame -= 25;
        }
      }
    }
  }
}
