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
  
  void showPlayer() {
    if (frameCount > 0  && inWalkAnimation) {
      move();
      display();
    } else { 
      display();
    }
  }
}
