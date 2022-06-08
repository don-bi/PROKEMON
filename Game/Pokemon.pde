public class Pokemon{
  String nickname,name;
  String nature;
  HashMap<String, Integer> stats,IVs,EVs;
  int level,hp,exp,neededExp;
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
    stats = new HashMap<String,Integer>(); //initializes stat data structures
    IVs = new HashMap<String,Integer>();
    EVs = new HashMap<String,Integer>();
    level = l;
    exp = 500;
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"}; //stats
    for (String stat:statnames){
      IVs.put(stat,(Integer)(int)random(32));
      EVs.put(stat,0);
      stats.put(stat,calcStat(stat));
    }
    stats.put("exp",Integer.parseInt(data.getPokeData(name,"experience_growth"))); //initializes total exp needed
    neededExp = data.expData.get(level).get(stats.get("exp")); //initializes needed exp for the current level
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
        if (!(randmove.damageClass.equals("status") && checkMoveEffects(randmove) == 0)) { //if the effect is not implemented, then it won't be added as a move
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
      return floor(((2.0*base+IV+floor(EV/4.0))*level)/100.0) + level + 10;
    } else {
      return floor(floor((((2.0*base+IV+floor(EV/4.0))*level)/100.0)+5) * natureVal);
    }
  }
  
  private float[] calcDamage(Pokemon other){    
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
    if (!other.type2.equals("")) effectiveness *= data.effectiveness.get(currentMove.type).get(other.type2); //gets effectiveness against other's type2
    
    
    float burn = 1;
    if (nonvolStatus.equals("burned") && currentMove.damageClass.equals("physical")) burn = 0.5;
    
    return new float[]{((((2*level)/5.0 + 2) * currentMove.power * A/(1.0*D))/50.0 + 2) * weather * crit * random * STAB * effectiveness * burn,effectiveness}; //returns an array because the effectiveness is needed later for the comment
  }
    
  private int checkMoveEffects(Move move){ //Checks for special move effects ie. swords dance and stuff and if it's not implemented, returns false
    return 0;
  }
  
  float attack(Pokemon other){
    int damage = 0;
    float effectiveness = -1;
    if (!currentMove.damageClass.equals("status")){
      float[] holder = calcDamage(other);
      damage = (int)holder[0];
      effectiveness = holder[1]; //if the pokemon successfully attacks, the effectiveness is changed to what the move effectiveness is
    } else {
      damage = checkMoveEffects(currentMove);
    }
    other.hp -= damage;
    if (other.hp < 0) other.hp = 0;
    println(name + ' ' + currentMove + ' ' + damage + ' ' + currentMove.effect);
    return  effectiveness;
  }
  
  int gainExp(Pokemon other){ //formula from https://bulbapedia.bulbagarden.net/wiki/Experience
    float a = 1.0;
    if (battle.opponent != null) a = 1.5; // a is 1 if wild pokemon, 1.5 if trainer owned
    int b = data.expGain.get(other.name).get("exp"); //base exp of the enemy pokemon
    println(b);
    float e = 1;
    float f = 1;
    float L = other.level;
    println(L);
    float Lp = level;
    println(level);
    float p  = 1;
    float s = 1;
    float t = 1;
    float v = 1;
    return (int)(((b*L*f*v)/(5.0*s)*pow(((2.0*L+10)/(L+Lp+10.0)),2.5))*t*e*p);
  }
    
  void recalcStats(){
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"}; //stats
    for (String stat:statnames){
      stats.put(stat,calcStat(stat));
    }
  }
  
  void levelUp(){
    level ++;
    exp = 0;
    neededExp = data.expData.get(level).get(stats.get("exp")); //when leveling up, sets the new exp required based on expData
    recalcStats();
  }
    
}
