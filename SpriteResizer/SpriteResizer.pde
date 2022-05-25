import java.io.File;

int scale = 4;
PGraphics pg;

void setup(){
  File dir = new File("C:/CS hw junior/github/PROKEMON/SpriteResizer/data");
  File[] files = dir.listFiles();  //creates array of all the files, gonna use this to get the names
  
  pg = createGraphics(384,384); //made pgraphics to retain transparency
  pg.beginDraw();
  for (int i = 0; i < files.length; i++){ //goes through all the pokemon
    pg.background(0,0);
    String filename = files[i].getName();
    PImage sprite = loadImage(filename);
    for (int x = 0; x < sprite.width; x ++){
      for (int y = 0; y < sprite.height; y++){
        color c = sprite.get(x,y);
        PImage pixel = createImage(scale,scale,ARGB); //creates a new pixel dilated to scale
        for (int pixelx = 0; pixelx < scale; pixelx++){
          for (int pixely = 0; pixely < scale; pixely++){
            pixel.set(pixelx,pixely,c); //makes each small pixel of new giant pixel the same color as the sprite's
          }
        }
        pg.image(pixel,x*scale,y*scale); //puts giant pixels on the pgraphics
      }
    }
    String ending = filename.substring(filename.indexOf("_",filename.indexOf("_")+1)+1);
    pg.save(ending); //saves to file
  }
  pg.endDraw();
  println("DONE RESIZING");
}
