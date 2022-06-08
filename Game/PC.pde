public class PC{
  
  Pokemon[][] box;
  PImage texture;
  
  public PC(){
    box = new Pokemon[10][10];
  }
  
  void put(Pokemon p){
    int r = 0;
    int c = 0;
    while (box[r][c] != null){
      c ++;
      if (c == box.length){
        c = 0;
        r ++;
        if (r == box[0].length) { //if box is full, it deletes first pokemon
          r = 0;
          c = 0;
          box[0][0] = null;
        }
      }
    }
    box[r][c] = p;
  }
}
