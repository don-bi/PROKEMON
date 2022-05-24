int scale = 5;
PGraphics pg;

void setup(){
  pg = createGraphics(480,480); //made pgraphics to retain transparency
  pg.beginDraw();
  for (int i = 1; i < 2; i++){ //goes through all the pokemon
    String number = "";
    for (int zeros = 0; zeros < 3 - ("" + i).length(); zeros++){ //makes the numbers have 0's (001, 025, 623, 003, etc.)
      number += 0;
    }
    number += i;
    PImage sprite = loadImage("spr_bw_" + number + ".png");
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
    pg.save(i + ".png"); //saves to file
  }
  pg.endDraw();
}
