public class Move{
  String name, id;
  String type;
  int pp;
  int power;
  int accuracy;
  int priority;
  int target;
  String damageClass;
  int effect;
  int effectChance;
  
  public Move(String ID){
    id = ID;
    name = data.moveData.get(ID).get("name");
    type = data.getMoveData(id, "type");
    pp = parseInt(data.getMoveData(id, "pp"));
    power = parseInt(data.getMoveData(id, "power"));
    accuracy = parseInt(data.getMoveData(id, "accuracy"));
    priority = parseInt(data.getMoveData(id, "priority"));
    target =  parseInt(data.getMoveData(id, "target_id"));
    damageClass = data.getMoveData(id, "damage_class");
    effect = parseInt(data.getMoveData(id, "effect_id"));
    effectChance = parseInt(data.getMoveData(id, "effect_chance"));
  }
  
  String toString(){
    String[] temp = new String[1];
    temp[0] = name;
    if (name.indexOf("-") != -1) temp = name.split("-");
    String result = "";
    for (String word:temp){
      result += word.substring(0, 1).toUpperCase() + word.substring(1) + " ";
    }
    return result;
  }
}
