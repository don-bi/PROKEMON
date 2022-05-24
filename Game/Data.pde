public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();
  
  //Map maskings
  HashMap<String, PImage> mapMasks = new HashMap<String, PImage>();
  
  //Player animations
  HashMap<String, PImage> playerAnimations = new HashMap<String, PImage>();
  
  public Data() {
    //maps every map name to two images, its background nad its foreground
    String[] mapNames = {"HomeTop","Home"}; //REMEMBER TO ADD TO ARRAY WHENEVER ADDING NEW MAPS
    for (String name:mapNames){
      mapImages.put(name, new PImage[]{loadImage(name+"FG.png"), loadImage(name+"BG.png")});
    }
    
    //creates a map mask for every map
    String[] mapSet= mapImages.keySet().toArray(new String[0]);
    for (String map:mapSet){
      PImage currentFG = mapImages.get(map)[0];
      PImage currentBG = mapImages.get(map)[1];
      PImage mask = createImage(currentFG.width,currentBG.height,ARGB);
      loadPixels();
      color transparent = currentBG.get(0,0);
      for (int r = 0; r < currentFG.height; r ++){
        for (int c = 0; c < currentFG.width; c ++){
          if (currentBG.pixels[r*currentFG.width+c] != transparent && currentFG.pixels[r*currentFG.width+c] != currentBG.pixels[r*currentFG.width+c]){
            mask.pixels[r*currentFG.width+c] = currentFG.pixels[r*currentFG.width+c];
          } else {
            mask.pixels[r*currentFG.width+c] = color(255,0);
          }
        }
      }
      updatePixels();
      mapMasks.put(map, mask);
    }
    
    PImage playerSprites = loadImage("player.png");
    playerAnimations.put("playerDStand",playerSprites.get(0, 0, 84, 126));
    playerAnimations.put("playerDLeftWalk",playerSprites.get(0, 132, 84, 126));
    playerAnimations.put("playerDRightWalk",playerSprites.get(0, 264, 84, 126));
    playerAnimations.put("playerUStand",playerSprites.get(89, 0, 84, 126));
    playerAnimations.put("playerULeftWalk",playerSprites.get(89, 132, 84, 126));
    playerAnimations.put("playerURightWalk",playerSprites.get(89, 264, 84, 126));
    playerAnimations.put("playerLStand",playerSprites.get(179, 0, 84, 126));
    playerAnimations.put("playerLLeftWalk",playerSprites.get(179, 132, 84, 126));
    playerAnimations.put("playerLRightWalk",playerSprites.get(179, 264, 84, 126));
    playerAnimations.put("playerRStand",playerSprites.get(299, 0, 84, 126));
    playerAnimations.put("playerRLeftWalk",playerSprites.get(293, 132, 84, 126));
    playerAnimations.put("playerRRightWalk",playerSprites.get(299, 264, 84, 126));
  }
  
  PImage getMap(String m, String layer) {
    int lay = 0;
    if (layer == "bg") lay = 1; 
    return mapImages.get(m)[lay];
  }
}
