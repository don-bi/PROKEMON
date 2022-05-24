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
}
