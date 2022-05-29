public class Pokemon{
  String nickname,name;
  String nature;
  HashMap<String, Integer> stats,IVs,EVs;
  int level,hp;
  String type1,type2;
  PImage sprite;
  String mode;
  Move[] moves;
  Move currentMove;
  String nonvolStatus;
  int nonvolTurns;
  ArrayList<String> volStatus;
  ArrayList<String> volTurns;
  
  public Pokemon(String n, int l){
    name = n;
    nature = data.natures[(int)random(data.natures.length)];
    stats = new HashMap<String,Integer>();
    IVs = new HashMap<String,Integer>();
    EVs = new HashMap<String,Integer>();
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
    for (String stat:statnames){
      IVs.put(stat,(Integer)(int)random(32));
    }
    for (String stat:statnames){
      EVs.put(stat,0);
    }
    for (String stat:statnames){
      stats.put(stat,calcStat(stat));
    }
    level = l;
    hp = stats.get("hp");
    mode = "regular";
    type1 = data.getPokeData(name,"type1");
    type2 = data.getPokeData(name,"type2");
    sprite = data.frontSprites.get(name).get(mode);
    moves = new Move[4];
    makeMoves();
    nonvolStatus = "none";
    nonvolTurns = 0;
  }
  
  public Pokemon(String n, String m, int l){
    this(n,l);
    mode = m;
    sprite = data.frontSprites.get(name).get(mode);
  }
  
  public Pokemon(String n, int l, boolean ally){
    this(n,l);
    if (ally) sprite = data.backSprites.get(name).get(mode);
  }
  
  public Pokemon(String n, String m, int l, boolean ally){
    this(n,l);
    mode = m;
    if (ally) sprite = data.backSprites.get(name).get(mode);
  }
  
  private void makeMoves(){ //makes a random moveset for the pokemon based on moves it can learn at its level
    Integer[] levels = data.learnMoves.get(name).keySet().toArray(new Integer[0]);
    ArrayList<String> possiblemoves = new ArrayList<String>();
    for (int learnlevel:levels){
      if (level >= learnlevel){
        ArrayList<String> temp = data.learnMoves.get(name).get(learnlevel); //temp to store all the moves that a certain level has
        for (int i = 0; i < temp.size(); i ++){
          if (!possiblemoves.contains(temp.get(i))) possiblemoves.add(temp.get(i)); //if the move is not in the list already, then add the move to the possible moves list
        }
      }
    }
    for (int i = 0; i < 4; i ++){
      if (possiblemoves.size() > 0){
        String randmoveid = possiblemoves.remove((int)random(possiblemoves.size()));
        Move randmove = new Move(randmoveid); //gets a random move from posiblemoves and removes it from the list
        if (checkMoveEffects(randmove) == 0) {
          moves[i] = randmove;
        } else {
          i --;
        }
      }
    }
  }
  
  private int calcStat(String statname){
    int base = parseInt(data.getPokeData(name,statname));
    int IV = parseInt(IVs.get(statname));
    int EV = parseInt(EVs.get(statname));
    String[] natureEffects = data.natureStats.get(nature);
    String natureInc = natureEffects[0];
    String natureDec = natureEffects[1];
    float natureVal = 1;
    if (statname == natureInc) natureVal += 0.1;
    if (statname == natureDec) natureVal -= 0.1;
    
    //got formulas from https://bulbapedia.bulbagarden.net/wiki/Stat#Permanent_stats
    if (statname.equals("hp")){
      return floor(((2*base+IV+floor(EV/4))*level)/100) + level + 10;
    } else {
      return floor(floor((((2*base+IV+floor(EV/4))*level)/100)+5) * natureVal);
    }
  }
  
  private float calcDamage(Pokemon other){    
    //A is the attack stat of attacker, D is defense stat of the other
    int A = stats.get("atk");
    int D = other.stats.get("def");
    if (currentMove.damageClass.equals("special")){
      A = stats.get("spatk");
      D = other.stats.get("spdef");
    }
    
    //Calculating weather damage modifier
    float weather = 1;
    if (battle.weather.equals("rain")){
      if (currentMove.type.equals("water")) weather = 1.5;
      if (currentMove.type.equals("fire")) weather = 0.5;
    }
    if (battle.weather.equals("harsh sunlight")){
      if (currentMove.type.equals("water")) weather = 0.5;
      if (currentMove.type.equals("fire")) weather = 1.5;
    }
    
    //Calculating crit damage modifier
    float crit = 1;
    if (currentMove.effect == 44){
      if (random(8) == 0) crit = 1.5;
    } else {
      if (random(24) == 0) crit = 1.5;
    }
    
    //Random modifier
    float random = ((int)random(16) + 85) / 100.0;
    
    //STAB modifier
    float STAB = 1;
    if (currentMove.type.equals(type1) || currentMove.type.equals(type2)) STAB = 1.5;
    
    float effectiveness = 1;
    effectiveness *= data.effectiveness.get(currentMove.type).get(other.type1); //gets effectiveness against other's type1
    if (other.type2.equals("")) effectiveness *= data.effectiveness.get(currentMove.type).get(other.type1); //gets effectiveness against other's type2
    
    float burn = 1;
    if (nonvolStatus.equals("burned") && currentMove.damageClass.equals("physical")) burn = 0.5;
    
    return ((((2*level)/5 + 2) * currentMove.power * A/D)/50 + 2) * weather * crit * random * STAB * effectiveness * burn;
  }
    
  private int checkMoveEffects(Move move){ //Checks for special move effects ie. swords dance and stuff and if it's not implemented, returns false
    return 0;
  }
  
  void attack(Pokemon other){
    int damage = 0;
    if (!currentMove.damageClass.equals("status")){
      damage = (int)calcDamage(other);
    } else {
      damage = checkMoveEffects(currentMove);
    }
    other.hp -= damage;
  }
  
  void pokemonChooser(int level, int min, int max, String[] names){
    //choose random pokemon from names
    //call constrcutors to create new pokemon
    //set level randomly between min and max
  }
}
