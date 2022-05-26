import java.io.File;

int scale = 4;
PGraphics pg;

void setup() {
  File dir = new File(sketchPath("data"));
  File[] files = dir.listFiles();  //creates array of all the files, gonna use this to get the names
  
  pg = createGraphics(384, 384); //made pgraphics to retain transparency
  pg.beginDraw();
  for (int i = 0; i < files.length; i++) { //goes through all the pokemon
    String filename = files[i].getName();
    pg.background(0, 0);
    PImage sprite = loadImage(filename);
    
    color transparent = sprite.get(0,0);
    int startingrow = sprite.height; //first row with color
    int endingrow = 0; //last row with color
    
    for (int y = 0; y < sprite.height; y ++) {
      boolean rowhascolor = false;
      for (int x = 0; x < sprite.width; x ++){
        if (sprite.get(x,y) != transparent) rowhascolor = true;
      }
      if (rowhascolor){
        if (y < startingrow) startingrow = y;
        if (y > endingrow) endingrow = y;
    }
    
    for (int x = 0; x < sprite.width; x ++) {
      for (int y = startingrow; y <= endingrow; y++) {
        color c = sprite.get(x, y);
        PImage pixel = createImage(scale, scale, ARGB); //creates a new pixel dilated to scale
        for (int pixelx = 0; pixelx < scale; pixelx++) {
          for (int pixely = 0; pixely < scale; pixely++) {
            pixel.set(pixelx, pixely, c); //makes each small pixel of new giant pixel the same color as the sprite's
          }
        }
        pg.image(pixel, x*scale, y*scale); //puts giant pixels on the pgraphics
      }
    }
    String ending = filename.substring(filename.indexOf("_", filename.indexOf("_")+1)+1);
    if (filename.substring(filename.length()-6,filename.length()-4).equals("_m")) {
      pg.save(ending.substring(0,3)+".png"); //doesn't save _m endings
    } else {
      pg.save(ending); //saves to file
    }
  }
  pg.endDraw();
  println("DONE RESIZING");
}
