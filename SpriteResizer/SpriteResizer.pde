int scale = 5;

void setup(){
  size(480,480);
  for (int i = 1; i < 650; i++){
    String number = "";
    for (int zeros = 0; zeros < 3 - ("" + i).length(); zeros++){
      number += 0;
    }
    number += i;
    PImage sprite = loadImage("spr_bw_" + number + ".png");
  }
}
