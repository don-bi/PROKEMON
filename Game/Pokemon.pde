public class Pokemon{
  String nickname,name;
  HashMap<String, Integer> basestats,IVs,EVs;
  int level,hp;
  int atk,def,spatk,spdef,spd;
  String type1,type2;
  PImage sprite;
  String mode;
  Move[] moves;
  
  public Pokemon(String n, int l){
    name = n;
    basestats = new HashMap<String,Integer>();
    IVs = new HashMap<String,Integer>();
    EVs = new HashMap<String,Integer>();
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
    for (String stat:statnames){
      basestats.put(stat,parseInt(data.getPokeData(name,stat)));
    }
    for (String stat:statnames){
      IVs.put(stat,(int)random(32));
    }
    for (String stat:statnames){
      EVs.put(stat,0);
    }
    level = l;
    mode = "regular";
    type1 = data.getPokeData(name,"type1");
    type2 = data.getPokeData(name,"type2");
    sprite = data.frontSprites.get(name).get(mode);
    moves = new Move[4];
    makeMoves();
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
        moves[i] = randmove;
      }
    }
  }
  
  void pokemonChooser(int level, int min, int max, String[] names){
    //choose random pokemon from names
    //call constrcutors to create new pokemon
    //set level randomly between min and max
  }
}
