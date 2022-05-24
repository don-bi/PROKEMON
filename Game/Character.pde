public class Character {
  PImage sprite;
  char direction;
  int xpos, ypos;
  int pixel;
  boolean isBiking, isRunning;
  boolean inWalkAnimation = false;
  boolean leftFoot = true;
  
  void move() {
    if (inWalkAnimation == false) inWalkAnimation = true;
    if (pixel < 16) {
      pixel ++;
    } else {
      pixel = 0;
      if (!isBiking && !isRunning) {
        switch (direction) {
        case 'u':
          ypos--;
          break;
        case 'd':
          ypos++;
          break;
        case 'l':
          xpos--;
          break;
        case 'r':
          xpos++;
          break;
        }
      }
      inWalkAnimation = false;
    }
  }
  
  void display() {
    //offsets for during move animation
    int[] movingOffsets = new int[2];
    if (direction == 'u') movingOffsets[1] = pixel*6;
    if (direction == 'd') movingOffsets[1] = -pixel*6;
    if (direction == 'l') movingOffsets[0] = -pixel*6;
    if (direction == 'r') movingOffsets[0] = pixel*6;
    //offsets for sprite size
    int YOffset = sprite.height - 90 + movingOffsets[1];
    int XOffset = (96 - sprite.width)/2 + movingOffsets[0];
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
  
  Tile getFrontTile(){
    switch (direction){
      case 'u':
        return currentMapTiles.getTile(xpos,ypos-1);
      case 'd':
        return currentMapTiles.getTile(xpos,ypos+1);
      case 'l':
        return currentMapTiles.getTile(xpos-1,ypos);
    }
    return currentMapTiles.getTile(xpos+1,ypos);
  }
}
