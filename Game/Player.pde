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
}
