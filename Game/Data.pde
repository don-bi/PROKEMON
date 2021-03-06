public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();

  //Map maskings
  HashMap<String, PImage> mapMasks = new HashMap<String, PImage>();

  //Player animations
  HashMap<String, PImage> playerAnimations = new HashMap<String, PImage>();
  
  //NPC animations
  HashMap<String, HashMap<String, PImage>> npcAnimations = new HashMap<String, HashMap<String, PImage>>();

  //Pokemon data
  HashMap<String, HashMap<String, String>> pokemonData = new HashMap<String, HashMap<String, String>>();
  
  //When each pokemon learns each move data
  HashMap<String, HashMap<Integer, ArrayList<String>>> learnMoves = new HashMap<String, HashMap<Integer, ArrayList<String>>>();

  //All the moves and their data
  HashMap<String, HashMap<String, String>> moveData = new HashMap<String, HashMap<String, String>>();
  
  //exp data
  HashMap<Integer, HashMap<Integer, Integer>> expData = new HashMap<Integer, HashMap<Integer, Integer>>();
  
  //the exp each pokemon gives when beaten
  HashMap<String, HashMap<String, Integer>> expGain = new HashMap<String, HashMap<String, Integer>>();
  
  //capture rates for different pokemon
  HashMap<String, Integer> capturerates = new HashMap<String, Integer>();
  
  //Pokemon id to pokemon name data
  HashMap<String, String> idName = new HashMap<String, String>();
  
  //Move names to move ids
  HashMap<String, String> moveNameId = new HashMap<String, String>();
  
  //Natures
  String[] natures = {"Adamant","Bashful","Bold","Brave","Calm","Careful","Docile","Gentle","Hardy","Hasty","Impish","Jolly","Lax","Lonely","Mild","Modest","Naive","Naughty","Quiet","Quirky","Rash","Relaxed","Sassy","Serious","Timid"};
  
  HashMap<String, String[]> natureStats = new HashMap<String, String[]>();
  
  //Type effectivenesses
  HashMap<String, HashMap<String, Float>> effectiveness = new HashMap<String, HashMap<String, Float>>();

  //Pokemon sprites
  HashMap<String, HashMap<String, PImage>> frontSprites = new HashMap<String, HashMap<String, PImage>>();
  HashMap<String, HashMap<String, PImage>> backSprites = new HashMap<String, HashMap<String, PImage>>();
  
  //effects tags
  HashMap<String, PImage> effects = new HashMap<String, PImage>(); 

  PImage encounter, battleBG, battleCircles, lefthalf, righthalf, bigChosenPoke, bigPoke, smallChosenPoke, smallPoke, hpBar, miniHpBar, enemyUi, allyUi, levelUp, expBar, pokeball, masterball;
  PImage player1,player2,player3,player4;
  PImage potionhover,pokeballhover,masterballhover;
  PFont font;
  
  //GUIS AND BUTTONS
  Gui homeScreen;
  Gui menu;
  Gui pokemons;
  Gui pokemondata;
  Gui pokemonevs;
  Gui pokemonivs;
  Gui fightOptions;
  Gui moveOptions;
  Gui switchPokemon;
  Gui deadPokemon;
  Gui itembag;
  Gui pokeballbag;
  
  Button menupokemon;
  Button menubutton;
  Button menuload;
  Button menusave;
  Button menuexit;
  
  Button menupoke1;
  Button menupoke2;
  Button menupoke3;
  Button menupoke4;
  Button menupoke5;
  Button menupoke6;
  Button menucancel;
  
  Button statswitch;
  Button evswitch;
  Button ivswitch;
  
  Button pokemondataexit;
  Button itembagexit;
  Button pokeballbagexit;
  
  Button fight;
  Button pokemon;
  Button bag;
  Button run;
  
  Button move1;
  Button move2;
  Button move3;
  Button move4;

  Button poke1;
  Button poke2;
  Button poke3;
  Button poke4;
  Button poke5;
  Button poke6;
  Button cancel;
  
  Button rightButton;
  Button leftButton;
  Button pokeballButton;
  Button masterballButton;
  Button potionButton;
  
  public Data(){
    try {
      //maps every map name to two images, its background and its foreground
      String[] mapNames = {"HomeTop", "Home", "Woodbury_Town", "RightHouse", "LeftHouse", "Route1", "PokeCenter"}; //REMEMBER TO ADD TO ARRAY WHENEVER ADDING NEW MAPS
      for (String name : mapNames) {
        mapImages.put(name, new PImage[]{loadImage(getSubDir("Maps", name+"FG.png")), loadImage(getSubDir("Maps", name+"BG.png"))});
      }
  
      //creates a map mask for every map
      loadMapMasks();
  
      //loads player sprites
      loadPlayerSprites();
      
      //loads npc sprites
      loadnpcSprites();
  
      //Sets images for battlemode
      PImage playerSprites = loadImage("player.png");
      battleBG = loadImage("battlebackground.png");
      battleCircles = loadImage("battlecircles.png");
      lefthalf = battleCircles.get(0,530,1440,334);
      righthalf = battleCircles.get(0,0,1440,530);
      bigChosenPoke = loadImage("bigchosenpoke.png");
      bigPoke = loadImage("bigpoke.png");
      smallChosenPoke = loadImage("smallchosenpoke.png");
      smallPoke = loadImage("smallpoke.png");
      hpBar = loadImage("hpbar.png");
      miniHpBar = loadImage("minihpbar.png");
      enemyUi = loadImage("enemyui.png");
      allyUi = loadImage("allyui.png");
      expBar = loadImage("expbar.png");
      PImage pokeballSet = loadImage("pokeballs.png"); //The pokeball set for being thrown when capturing
      pokeball = pokeballSet.get(192,0,96,96);
      masterball = pokeballSet.get(576,0,96,96);
      player1 = playerSprites.get(839,1056,288,312);
      player2 = playerSprites.get(1139,1062,384,306);
      player3 = playerSprites.get(1529,1068,228,300);
      player4 = playerSprites.get(1811,1074,384,294);
      potionhover = loadImage("potion.png");
      pokeballhover = loadImage("pokeball.png");
      masterballhover = loadImage("masterball.png");
      encounter = loadImage("encounter.png");
      
      //loads the font
      font = createFont("font.ttf",72);
      
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
      
      //loads guis and buttons
      loadGuis();
      
      //loads move data
      loadMoveData();
      
      String[] moveidSet = moveData.keySet().toArray(new String[0]); //set of all the move ids in moveData
      for (String id : moveidSet) { 
        String move = moveData.get(id).get("name");
        moveNameId.put(move, id); //maps moves to their ids in moveNameId
      }
      
      //loads nature data
      loadNatures();
      
      //loads move effectiveness data
      loadEffectiveness();
      
      //loads exp data
      loadExp();
      
      //loads exp and EVs gained from each pokemon data
      loadExpGain();
      
      //loads in capture rates of pokemon
      loadCaptureRates();
      
      //loads in effect tags
      loadEffectTags();
    } catch (IOException e){}
  }


  private void loadMapMasks(){
    String[] mapSet= mapImages.keySet().toArray(new String[0]);
      for (String map : mapSet) {
        PImage currentFG = mapImages.get(map)[0];
        PImage currentBG = mapImages.get(map)[1];
        PImage mask = createImage(currentFG.width, currentBG.height, ARGB);
        loadPixels();
        color transparent = currentBG.get(0, 0); //gets transparent color
        for (int r = 0; r < currentFG.height; r ++) {
          for (int c = 0; c < currentFG.width; c ++) {
            if (currentBG.pixels[r*currentFG.width+c] != transparent && currentFG.pixels[r*currentFG.width+c] != currentBG.pixels[r*currentFG.width+c]) {
              mask.pixels[r*currentFG.width+c] = currentFG.pixels[r*currentFG.width+c]; //if the colors are not equalin the foreground and background, then it adds the color from the foregound to the mask
            } else {
              mask.pixels[r*currentFG.width+c] = color(255, 0); //if the color in the foreground matches the one in the background, then it makes that pixel in the mask transparents
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
  
  private void loadnpcSprites() {
    PImage npcSprites = loadImage("NPCsprites.png");
    HashMap<String, PImage> richguy = new HashMap<String, PImage>();
    richguy.put("DStand", npcSprites.get(2040,3726,84,120));
    richguy.put("DLeftWalk", npcSprites.get(2478,3726,84,120));
    richguy.put("DRightWalk", npcSprites.get(2376,3726,84,120));
    npcAnimations.put("Rich Guy",richguy);
    HashMap<String, PImage> nurse = new HashMap<String, PImage>();
    nurse.put("DStand", npcSprites.get(6,2424,96,126));
    nurse.put("DLeftWalk", npcSprites.get(6,2424,96,126));
    nurse.put("DRightWalk", npcSprites.get(6,2424,96,126));
    npcAnimations.put("Nurse",nurse);
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
  
  private void loadMoveData() throws IOException{
    BufferedReader reader = createReader("pokemon_moves.csv");
    String line = reader.readLine(); //just to get past the category headings
    line = reader.readLine();
    while (line != null) { //READING IN POKEMON_MOVES RIGHT NOW(THE LEVEL EACH POKEMON LEARNS EACH MOVE)
      String[] data = line.split(","); //[pokemon,level,move_id] (actual values)
      String pokename = getPokename(data[0]);
      int level = parseInt(data[1]);
      if (learnMoves.containsKey(pokename)) { //if there is already a bulbasaur
        HashMap<Integer, ArrayList<String>> leveltomove = learnMoves.get(pokename);
        if (leveltomove.containsKey(level)){ //if there is already a move bulbasaur learns at level 9
          leveltomove.get(level).add(data[2]); //add the new move to the arraylist level 9 is mapped to
        } else { //otherwise, make a new arraylist with the new level 13 move and add it to bulbasaur
          ArrayList<String> moveid = new ArrayList<String>();
          moveid.add(data[2]);
          learnMoves.get(pokename).put(level,moveid);
        }
      } else { //if there is no bulbasaur, map bulbasaur to a new move
        HashMap<Integer, ArrayList<String>> leveltomove = new HashMap<Integer,ArrayList<String>>(); 
        ArrayList<String> moveid = new ArrayList<String>();
        moveid.add(data[2]);
        leveltomove.put(level, moveid);
        learnMoves.put(pokename,leveltomove);
      }
      line = reader.readLine();
    }
    reader.close();
    
    //reading in data such as power, accuracy, etc. of moves now
    reader = createReader("moves.csv");
    line = reader.readLine();
    String[] categories = line.split(","); //[id,name,type,power,etc.]
    line = reader.readLine();
    while (line != null) {
      String[] data = line.split(",");
      String moveid = data[0];
      moveData.put(moveid,new HashMap<String, String>());
      for (int i = 1; i < categories.length; i ++){
        moveData.get(moveid).put(categories[i],data[i]); //final hashMap {"1"={"name"="pound","type"="normal",...}...
      }
      line = reader.readLine();
    }
    reader.close();
  }
  
  private void loadNatures() throws IOException{
    BufferedReader reader = createReader("natures.csv");
    String line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //[nature,stat increase, statdecrease]
      natureStats.put(data[0],new String[]{data[1],data[2]}); // {"Gentle"=[spdef,def],...}
      line = reader.readLine();
    }
    reader.close();
  }
  
  private void loadEffectiveness() throws IOException{
    BufferedReader reader = createReader("effectiveness.csv");
    String line = reader.readLine();
    String[] categories = line.split(","); //type names ([attacking normal, fire,...]
    line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //values of [normal, fire, water,...]
      String attackingtype = data[0];
      HashMap<String, Float> defensetype = new HashMap<String, Float>();
      defensetype.put(categories[1],parseFloat(data[1]));
      effectiveness.put(attackingtype,defensetype); // puts normal effectivness first to initialize what attackingtype maps to
      for (int i = 2; i < categories.length; i ++){
        effectiveness.get(attackingtype).put(categories[i],parseFloat(data[i]));
      }
      line = reader.readLine();
    }
    reader.close();
  }
      
  private void loadGuis(){
    //rect(0,650,1440,214);
    homeScreen = new Gui(0,0);
    menu = new Gui(0,0);
    pokemons = new Gui(loadImage("pokemonmenu.png"),0,0);
    pokemondata = new Gui(loadImage("pokemondata.png"),0,0);
    pokemonevs = new Gui(loadImage("pokemonevs.png"),0,0);
    pokemonivs = new Gui(loadImage("pokemonivs.png"),0,0);
    fightOptions = new Gui(0,0);
    moveOptions = new Gui(0,0);
    switchPokemon = new Gui(loadImage("pokemonmenu.png"),0,0);
    deadPokemon = new Gui(loadImage("deadpokemonmenu.png"),0,0);
    itembag = new Gui(loadImage("items.png"),0,0);
    pokeballbag = new Gui(loadImage("pokeballbag.png"),0,0);
    pokemons = new Gui(loadImage("pokemonmenu.png"),0,0);
    
    menubutton = new Button(homeScreen,menu,1240,0,"");
    menubutton.texture = loadImage("menu.png");
    menupokemon = new Button(menu,pokemons,1240,0,"menupokemon");
    menupokemon.texture = loadImage("menu.png");
    menuload = new Button(menu,homeScreen,1240,75,"load");
    menuload.texture = loadImage("menu.png");
    menusave = new Button(menu,homeScreen,1240,150,"save");
    menusave.texture = loadImage("menu.png");
    menuexit = new Button(menu,homeScreen,1240,225,"");
    menuexit.texture = loadImage("menu.png");
    
    statswitch = new Button(pokemonevs,pokemondata,846,437);
    pokemonivs.buttons.add(statswitch);
    statswitch.texture = loadImage("dataswitch.png");
    evswitch = new Button(pokemondata,pokemonevs,995,437);
    pokemonivs.buttons.add(evswitch);
    evswitch.texture = loadImage("dataswitch.png");
    ivswitch = new Button(pokemondata,pokemonivs,1144,437);
    pokemonevs.buttons.add(ivswitch);
    ivswitch.texture = loadImage("dataswitch.png");
    
    pokemondataexit = new Button(pokemondata,pokemons,1375,0);
    pokemonevs.buttons.add(pokemondataexit);
    pokemonivs.buttons.add(pokemondataexit);
    pokemondataexit.texture = loadImage("x.png");
    itembagexit = new Button(itembag,fightOptions,1375,0);
    itembagexit.texture = loadImage("x.png");
    pokeballbagexit = new Button(pokeballbag,fightOptions,1375,0);
    pokeballbagexit.texture = loadImage("x.png");
    
    fight = new Button(fightOptions,moveOptions,1000,650);
    fight.texture = loadImage("fight.png");
    pokemon = new Button(fightOptions,switchPokemon,1220,650,"endComment");
    pokemon.texture = loadImage("pokemon.png");
    bag = new Button(fightOptions,itembag,1000,757,"endComment");
    bag.texture = loadImage("bag.png");
    run = new Button(fightOptions,1220,757,"run");
    run.texture = loadImage("run.png");
    
    move1 = new Button(moveOptions,1000,650,"move1");
    move1.texture = loadImage("blank.png");
    move2 = new Button(moveOptions,1220,650,"move2");
    move2.texture = loadImage("blank.png");
    move3 = new Button(moveOptions,1000,757,"move3");
    move3.texture = loadImage("blank.png");
    move4 = new Button(moveOptions,1220,757,"move4");
    move4.texture = loadImage("blank.png");
  
    rightButton = new Button(itembag,pokeballbag,580,72);
    rightButton.texture = loadImage("rightbutton.png");
    leftButton = new Button(pokeballbag,itembag,220,72);
    leftButton.texture = loadImage("leftbutton.png");
    pokeballButton = new Button(pokeballbag,680,112,"pokeball");
    pokeballButton.texture = createImage(600,58,ARGB);
    masterballButton = new Button(pokeballbag,680,170,"masterball");
    masterballButton.texture = createImage(600,58,ARGB);
    potionButton = new Button(itembag,680,112,"potion");
    potionButton.texture = createImage(600,58,ARGB);
  }
  
  private void loadExp() throws IOException{
    BufferedReader reader = createReader("exp.csv");
    String[] categories = reader.readLine().split(",");
    String line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //exp needed for the level
      int currentLevel = parseInt(data[0]);
      HashMap<Integer,Integer> totalToLevel = new HashMap<Integer,Integer>(); //creates the value hashmaps for expData
      totalToLevel.put(parseInt(categories[1]),parseInt(data[1])); //keys will be the total exp of the pokemon(found in pokemonData), values will be what's required for the level
      expData.put(currentLevel, totalToLevel);
      for (int i = 2; i < categories.length; i ++){
        expData.get(currentLevel).put(parseInt(categories[i]),parseInt(data[i]));
      }
      line = reader.readLine();
    }
  }
  
  private void loadExpGain() throws IOException{
    BufferedReader reader = createReader("expgain.csv");
    String[] categories = reader.readLine().split(",");
    String line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //exp given for each pokemon and also their evs given
      String pokename = data[0];
      HashMap<String,Integer> statToEVs = new HashMap<String,Integer>(); //creates the value hashmaps for expGain
      statToEVs.put(categories[1],parseInt(data[1])); //keys will be the total exp of the pokemon(found in pokemonData), values will be what's required for the level
      expGain.put(pokename, statToEVs);
      for (int i = 2; i < categories.length; i ++){
        expGain.get(pokename).put(categories[i],parseInt(data[i]));
      }
      line = reader.readLine();
    }
  }
  
  private void loadCaptureRates() throws IOException{
    BufferedReader reader = createReader("capturerates.csv");
    String line = reader.readLine();
    while (line != null){
      String[] data = line.split(","); //[pokemon,rate]
      try {
      capturerates.put(data[0],parseInt(data[1]));
      } catch (ArrayIndexOutOfBoundsException e) {
      println(data[0]);
      }
      line = reader.readLine();
    }
  }
  
  private void loadEffectTags() {
    PImage effectsheet = loadImage("effects.png");
    effects.put("poison",effectsheet.get(18,288,60,24));
    effects.put("burn",effectsheet.get(18,312,60,24));
    effects.put("paralysis",effectsheet.get(114,288,60,24));
    effects.put("sleep",effectsheet.get(210,288,60,24));
    effects.put("freeze",effectsheet.get(306,288,60,24));
  }
    
  
  PImage getMap(String m, String layer) {
    int lay = 0;
    if (layer == "bg") lay = 1; 
    return mapImages.get(m)[lay];
  }

  private String getPokename(String id) {
    return idName.get(id);
  }
  
  String getMoveId(String name) {
    return moveNameId.get(name);
  }

  String getPokeData(String name, String dataname) {
    return pokemonData.get(name).get(dataname);
  }
  
  String getMoveData(String id, String dataname) {
    return moveData.get(id).get(dataname);
  }
}
