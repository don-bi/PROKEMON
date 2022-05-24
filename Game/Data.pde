public class Data {
  //Maps
  HashMap<String, PImage[]> mapImages = new HashMap<String, PImage[]>();
  
  public Data() {
    String[] mapNames = {"HomeTop"};
    
    for (String name:mapNames){
      mapImages.put(name, new PImage[]{loadImage(name+"FG.png"), loadImage(name+"BG.png")});
    }
  }
  
  PImage getMap(String m, String layer) {
    int lay = 0;
    if (layer == "bg") lay = 1; 
    return mapImages.get(m)[lay];
  }
}
