public class Keyboard {
  ArrayList<String> WASD;
  
  public Keyboard(){
    WASD = new ArrayList<String>();
  }
  
  void keyPressed(){
    String pressed = (""+key).toUpperCase();
    switch (pressed) {
      case "W": case "A": case "S": case "D":
      if (!WASD.contains(pressed)) {
        WASD.add(pressed);
      }
    }
  }
  
  void keyReleased(){
    String pressed = (""+key).toUpperCase();
    switch (pressed) {
      case "W": case "A": case "S": case "D":
      if (WASD.contains(pressed)) {
        WASD.remove(find(pressed));
      }
    }
  }
  
  private int find(String wasd){
    for (int i = 0; i < 4; i ++){
      if (WASD.get(i).equals(wasd)){
        return i;
      }
    }
    return 0;
  }
  
  char getLast(){
    return WASD.get(WASD.size()-1).charAt(0);
  }
  
}
