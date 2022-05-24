public class Character {
  PImage sprite;
  char direction;
  int xpos, ypos;
  int pixel;
  boolean isBiking, isRunning;
  boolean inWalkAnimation = false;
  boolean leftFoot = true;
  
  void display() {
    //offsets for sprite size
    int YOffset = sprite.height - 90;
    int XOffset = (96 - sprite.width)/2;
    if (currentMapTiles.getTile(player.xpos, player.ypos).isGrass) {
      image(sprite, xpos*16*6 + XOffset, ypos*16*6 - YOffset, sprite.width, sprite.height/2);
    } else {
      image(sprite, xpos*16*6 + XOffset, ypos*16*6 - YOffset);
    }
  }
  
  void teleport(int x, int y) {
    xpos = x;
    ypos = y;
  }
}
