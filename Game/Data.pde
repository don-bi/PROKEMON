public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();
  
  //Player animations
  HashMap<String, PImage> playerAnimations = new HashMap<String, PImage>();
  
  public Data() {
    String[] mapNames = {"HomeTop"};
    
    for (String name:mapNames){
      mapImages.put(name, new PImage[]{loadImage(name+"FG.png"), loadImage(name+"BG.png")});
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
