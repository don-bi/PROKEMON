public class Player extends Character {
  public Player() {
    sprite = data.playerAnimations.get("playerDStand");
    direction = 'd';
    xpos = 0;
    ypos = 0;
    int pixel = 0;
    isBiking = false;
    isRunning = false;
  }
  
  void move() {
    if (getFrontTile().isWalkable) {
      super.move();
      if (leftFoot) {
        sprite = data.playerAnimations.get("player" + (""+direction).toUpperCase() + "LeftWalk");
      } else {
        sprite = data.playerAnimations.get("player" + (""+direction).toUpperCase() + "RightWalk");
      }
      if (pixel == 0) {
        leftFoot = !leftFoot;
        changeDirection();
      }
    }
  }
  
  void changeDirection() {
    switch ((""+key).toUpperCase()) { //makes it so you can move even with caps lock on
    case "W":
      direction = 'u';
      break;
    case "A":
      direction = 'l';
      break;
    case "S":
      direction = 'd';
      break;
    case  "D":
      direction = 'r';
      break;
    }
    sprite = data.playerAnimations.get("player" + (""+direction).toUpperCase() + "Stand");
  }
  
  void moveScreen() {

    int xmoveOffset = pixel*6;
    int ymoveOffset = pixel*6;
    int playerxpos = -xpos*16*6 + width/2 - sprite.width/2 - 6;
    int playerypos = -ypos*16*6 + height/2 - sprite.height/2 + 15;
    switch (direction) {
    case 'u':
      translate(playerxpos, playerypos + ymoveOffset);
      break;
    case 'd':
      translate(playerxpos, playerypos - ymoveOffset);
      break;
    case 'r':
      translate(playerxpos - xmoveOffset, playerypos);
      break;
    case 'l':
      translate(playerxpos + xmoveOffset, playerypos);
      break;
    }
  }
  
  void showPlayer() {
    if (frameCount > 0  && inWalkAnimation) {
      move();
      display();
    } else { 
      display();
    }
  }
}
