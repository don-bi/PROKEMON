public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();

  //Map maskings
  HashMap<String, PImage> mapMasks = new HashMap<String, PImage>();

  //Player animations
  HashMap<String, PImage> playerAnimations = new HashMap<String, PImage>();

  //Pokemon data
  HashMap<String, HashMap<String, String>> pokemonData = new HashMap<String, HashMap<String, String>>();
  
  //When each pokemon learns each move data
  HashMap<String, HashMap<Integer, String>> learnMoves = new HashMap<String, HashMap<Integer, String>>();

  //All the moves and their data
  HashMap<String, HashMap<String, String>> moveData = new HashMap<String, HashMap<String, String>>();
  
  //Pokemon id to pokemon name data
  HashMap<String, String> idName = new HashMap<String, String>();

  //Pokemon sprites
  HashMap<String, HashMap<String, PImage>> frontSprites = new HashMap<String, HashMap<String, PImage>>();
  HashMap<String, HashMap<String, PImage>> backSprites = new HashMap<String, HashMap<String, PImage>>();

  PImage battleBG, battleCircles;
  
  //GUIS AND BUTTONS
  Gui fightOptions = new Gui(0,0);
  Gui moveOptions = new Gui(0,0);
  Button fight = new Button(moveOptions);


  public Data(){
    try {
      //maps every map name to two images, its background and its foreground
      String[] mapNames = {"HomeTop", "Home", "Woodbury_Town"}; //REMEMBER TO ADD TO ARRAY WHENEVER ADDING NEW MAPS
      for (String name : mapNames) {
        mapImages.put(name, new PImage[]{loadImage(getSubDir("Maps", name+"FG.png")), loadImage(getSubDir("Maps", name+"BG.png"))});
      }
  
      //creates a map mask for every map
      loadMapMasks();
  
      //loads player sprites
      loadPlayerSprites();
  
      //Sets images for battlemode
      battleBG = loadImage("battlebackground.png");
      battleCircles = loadImage("battlecircles.png");
  
  
      //makes keys pokemon names, makes value hashmaps with keys of the data (attack,id,etc.)
      loadPokemonData();
  
      String[] pokemonSet = pokemonData.keySet().toArray(new String[0]); //set of all the keys in pokemonData
      for (String pokemon : pokemonSet) { 
        String id = pokemonData.get(pokemon).get("id");
        idName.put(id, pokemon); //fills idName with pokemon ids as keys and pokemon names as values
      }
  
      //loads front sprites
      loadFrontSprites();
  
      //loads back sprites
      loadBackSprites();
    } catch (IOException e){}
  }

  private void loadMapMasks(){
    String[] mapSet= mapImages.keySet().toArray(new String[0]);
      for (String map : mapSet) {
        PImage currentFG = mapImages.get(map)[0];
        PImage currentBG = mapImages.get(map)[1];
        PImage mask = createImage(currentFG.width, currentBG.height, ARGB);
        loadPixels();
        color transparent = currentBG.get(0, 0);
        for (int r = 0; r < currentFG.height; r ++) {
          for (int c = 0; c < currentFG.width; c ++) {
            if (currentBG.pixels[r*currentFG.width+c] != transparent && currentFG.pixels[r*currentFG.width+c] != currentBG.pixels[r*currentFG.width+c]) {
              mask.pixels[r*currentFG.width+c] = currentFG.pixels[r*currentFG.width+c];
            } else {
              mask.pixels[r*currentFG.width+c] = color(255, 0);
            }
          }
        }
        updatePixels();
        mapMasks.put(map, mask);
      }
  }

  private void loadPlayerSprites(){
    PImage playerSprites = loadImage("player.png");
    playerAnimations.put("playerDStand", playerSprites.get(0, 0, 84, 126));
    playerAnimations.put("playerDLeftWalk", playerSprites.get(0, 132, 84, 126));
    playerAnimations.put("playerDRightWalk", playerSprites.get(0, 264, 84, 126));
    playerAnimations.put("playerUStand", playerSprites.get(89, 0, 84, 126));
    playerAnimations.put("playerULeftWalk", playerSprites.get(89, 132, 84, 126));
    playerAnimations.put("playerURightWalk", playerSprites.get(89, 264, 84, 126));
    playerAnimations.put("playerLStand", playerSprites.get(179, 0, 84, 126));
    playerAnimations.put("playerLLeftWalk", playerSprites.get(179, 132, 84, 126));
    playerAnimations.put("playerLRightWalk", playerSprites.get(179, 264, 84, 126));
    playerAnimations.put("playerRStand", playerSprites.get(299, 0, 84, 126));
    playerAnimations.put("playerRLeftWalk", playerSprites.get(293, 132, 84, 126));
    playerAnimations.put("playerRRightWalk", playerSprites.get(299, 264, 84, 126));
  }

  private void loadPokemonData() throws IOException{
    BufferedReader reader = createReader("pokemon.csv");
    String line = reader.readLine();
    String[] categories = line.split(","); //categories are attack,id,etc.
    line = reader.readLine();
    while (line != null) {
      String[] data = line.split(","); //data are the data values
      HashMap<String, String> speciedata = new HashMap<String, String>();
      String speciename = data[data.length-1];
      for (int i = 0; i < data.length-1; i++) {
        speciedata.put(categories[i], data[i]);
      }
      pokemonData.put(speciename, speciedata);
      line = reader.readLine();
    }
    reader.close();
  }

  private void loadFrontSprites(){
    String frontSpritePath = dataPath("Front Sprites");
    File dir = new File(frontSpritePath);
    File[] files = dir.listFiles();
    for (File file : files) {
      String filename = file.getName(); //"386-speed.png"
      String pokeid = ""+parseInt(filename.substring(0, 3)); //"386"
      String pokename = getPokename(pokeid); //"deoxys"
      String form = "regular";
      if (filename.charAt(3) != '.') {
        form = filename.substring(4, filename.indexOf("."));
      }
      HashMap<String, PImage> forms = new HashMap<String, PImage>();
      if (frontSprites.containsKey(pokename)) { //if the pokemon already has a form, gets the hashmap it's mapped to and puts another form
        frontSprites.get(pokename).put(form, loadImage(frontSpritePath + '/' + filename));
      } else { //else, puts into temp hashmap forms and maps the pokename to it
        forms.put(form, loadImage(frontSpritePath + '/' + filename));
        frontSprites.put(pokename, forms);
      }
    }
  }
  
  private void loadBackSprites(){
    String backSpritePath = dataPath("Back Sprites");
    File dir = new File(backSpritePath);
    File[] files = dir.listFiles();
    for (File file : files) {
      String filename = file.getName(); //"386-speed.png"
      String pokeid = ""+parseInt(filename.substring(0, 3)); //"386"
      String pokename = getPokename(pokeid); //"deoxys"
      String form = "regular";
      if (filename.charAt(3) != '.') {
        form = filename.substring(4, filename.indexOf("."));
      }
      HashMap<String, PImage> forms = new HashMap<String, PImage>();
      if (backSprites.containsKey(pokename)) { //if the pokemon already has a form, gets the hashmap it's mapped to and puts another form
        backSprites.get(pokename).put(form, loadImage(backSpritePath + '/' + filename));
      } else { //else, puts into temp hashmap forms and maps the pokename to it
        forms.put(form, loadImage(backSpritePath + '/' + filename));
        backSprites.put(pokename, forms);
      }
    }
  }
  
  private void loadGuis(){}
    
  
  PImage getMap(String m, String layer) {
    int lay = 0;
    if (layer == "bg") lay = 1; 
    return mapImages.get(m)[lay];
  }

  private String getPokename(String id) {
    return idName.get(id);
  }

  String getPokeData(String name, String dataname) {
    return pokemonData.get(name).get(dataname);
  }
  
  
  
  
  /*reader = createReader("pokemon_evolution.csv");  //POKEMON EVOLUTION DATA WRONG RN, MIGHT COME BACK TO FIX LATER IDK
      line = reader.readLine();
      categories = line.split(",");
      line = reader.readLine();
      while (line != null) {
        String[] data = line.split(",");
        String id = data[0];
        String pokemon = getPokename(id);
        pokemonData.get(pokemon).put(categories[1], data[1]); //puts evolved_species_id 
        pokemonData.get(pokemon).put(categories[2], data[2]); //puts minimum_level id
        line = reader.readLine();
      }*/ 
}
