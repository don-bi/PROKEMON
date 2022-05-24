int scale = 5;

void setup(){
  size(480,480); // set this to 96 * scale
  for (int i = 1; i < 2; i++){
    String number = "";
    for (int zeros = 0; zeros < 3 - ("" + i).length(); zeros++){
      number += 0;
    }
    number += i;
    PImage sprite = loadImage("spr_bw_" + number + ".png");
    for (int x = 0; x < sprite.width; x ++){
      for (int y = 0; y < sprite.height; y++){
        color c = sprite.get(x,y);
        PImage pixel = createImage(scale,scale,ARGB);
        for (int pixelx = 0; pixelx < scale; pixelx++){
          for (int pixely = 0; pixely < scale; pixely++){
            pixel.set(pixelx,pixely,c);
          }
        }
        image(pixel,x*scale,y*scale);
      }
    }
    save("test_spr_bw_" + number + ".png");
  }
}
