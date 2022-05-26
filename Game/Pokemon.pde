public class Pokemon{
  String nickname,name;
  HashMap<String, Integer> basestats,IVs,EVs;
  int level,hp;
  int atk,def,spatk,spdef,spd;
  String type1,type2;
  PImage sprite;
  String evolution;
  int evolutionlevel;
  String mode;
  
  public Pokemon(String n){
    name = n;
    basestats = new HashMap<String,Integer>();
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
    for (String stat:statnames){
      basestats.put(stat,parseInt(data.getPokeData(name,stat)));
    }
    type1 = data.getPokeData(name,"type1");
    type2 = data.getPokeData(name,"type2");
    sprite = data.frontSprites.get(name).get(mode);
    evolution = data.getPokename(data.getPokeData(name,"evolved_id"));
    evolutionlevel = parseInt(data.getPokeData(name,"minimum_level")); 
    mode = "regular";
  }
  
  public Pokemon(String n, String m){
    this(n);
    mode = m;
    sprite = data.frontSprites.get(name).get(mode);
  }
  
  public Pokemon(String n, boolean ally){
    this(n);
    if (ally) {
      sprite = data.backSprites.get(name).get(mode);
    }
  }
  
  public Pokemon(String n, String m, boolean ally){
    this(n);
    mode = m;
    if (ally) sprite = data.backSprites.get(name).get(mode);
  }
}
