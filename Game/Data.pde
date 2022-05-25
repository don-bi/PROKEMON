public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();
  
  //Map maskings
  HashMap<String, PImage> mapMasks = new HashMap<String, PImage>();
  
  //Player animations
  HashMap<String, PImage> playerAnimations = new HashMap<String, PImage>();

  //Pokemon data
  HashMap<String, HashMap<String, String>> pokemonData = new HashMap<String, HashMap<String, String>>();
  
  //Pokemon id to pokemon name data
  HashMap<String, String> idName = new HashMap<String, String>();
  
  PImage battleBG, battleCircles;
  
  
  public Data() throws IOException{
    //maps every map name to two images, its background nad its foreground
    String[] mapNames = {"HomeTop","Home","Woodbury_Town"}; //REMEMBER TO ADD TO ARRAY WHENEVER ADDING NEW MAPS
    for (String name:mapNames){
      mapImages.put(name, new PImage[]{loadImage(getSubDir("Maps",name+"FG.png")), loadImage(getSubDir("Maps",name+"BG.png"))});
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
    
    //Sets images for battlemode
    battleBG = loadImage("battlebackground.png");
    battleCircles = loadImage("battlecircles.png");
    
    
    //makes keys pokemon names, makes value hashmaps with keys of the data (attack,id,etc.)
    BufferedReader reader = createReader("pokemon.csv");
    String line = reader.readLine();
    String[] categories = line.split(","); //categories are attack,id,etc.
    line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //data are the data values
      HashMap<String, String> speciedata = new HashMap<String, String>();
      String speciename = data[data.length-1];
      for (int i = 0; i < data.length-1; i++){
        speciedata.put(categories[i],data[i]);
      }
      pokemonData.put(speciename,speciedata);
      line = reader.readLine();
    }
    
    String[] pokemonSet = pokemonData.keySet().toArray(new String[0]); //set of all the keys in pokemonData
    for (String pokemon:pokemonSet){ 
      String id = pokemonData.get(pokemon).get("id");
      idName.put(id,pokemon); //fills idName with pokemon ids as keys and pokemon names as values
    }
    
    reader = createReader("pokemon_evolution.csv");
    line = reader.readLine();
    categories = line.split(",");
    line = reader.readLine();
    while (line != null){
      String[] data = line.split(",");
      String id = data[0];
      String pokemon = getPokename(id);
      pokemonData.get(pokemon).put(categories[1],data[1]); //puts evolved_species_id 
      pokemonData.get(pokemon).put(categories[2],data[2]); //puts minimum_level id
      line = reader.readLine();
    }
      
      
      
      
      
    
  }
  
  PImage getMap(String m, String layer) {
    int lay = 0;
    if (layer == "bg") lay = 1; 
    return mapImages.get(m)[lay];
  }
  
  private String getPokename(String id){
    return idName.get(id);
  }
}
