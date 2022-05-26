public class Pokemon{
  String nickname,name;
  HashMap<String, Integer> basestats,IVs,EVs;
  int hp,atk,def,spatk,spdef,spd;
  String type1,type2;
  PImage sprite;
  
  public Pokemon(String n){
    name = n;
    basestats = new HashMap<String,Integer>();
    String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
    for (String stat:statnames){
      basestats.put(stat,parseInt(data.getPokeData(name,stat)));
    }
  }
}
