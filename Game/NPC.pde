public class NPC extends Character {
  String name;
  String type;
  String comment, losecomment, wincomment;
  boolean isEncounter,encountered,done;
  int range;
  int reward;

  public NPC(int x, int y, char dir, int r) {
    direction = dir;
    xpos = x;
    ypos = y;
    pixel = 0;
    delay = 0;
    range = r;
    isBiking = false;
    isRunning = false;
    team = new ArrayList<Pokemon>();
  }
  
  void move(){
    super.move();
    if (leftFoot) {
      sprite = data.npcAnimations.get(type).get((""+direction).toUpperCase() + "LeftWalk");
    } else {
      sprite = data.npcAnimations.get(type).get((""+direction).toUpperCase() + "RightWalk");
    }
    if (pixel == 0) {
      leftFoot = !leftFoot;
    }
  }
  
  void encounter(){
    if (!done) {
      if (delay < 20){
        if (delay < 10) {
          image(data.encounter
      if (!encountered) {
        if (direction == 'u' && player.xpos == xpos && player.ypos > ypos-range && player.ypos < ypos) encountered = true;
        if (direction == 'd' && player.xpos == xpos && player.ypos < ypos+range && player.ypos > ypos) encountered = true;
        if (direction == 'l' && player.ypos == ypos && player.xpos > xpos-range && player.xpos < xpos) encountered = true;
        if (direction == 'r' && player.ypos == ypos && player.xpos < xpos+range && player.xpos > xpos) encountered = true;
      } else {
        animations.inAnimation = true;
        encountered = true;
        int x = getFrontCoords()[0];
        int y = getFrontCoords()[1];
        if (x != player.xpos || y != player.ypos) {
          move();
        } else {
          done = true;
          loadSprite();
          animations.overworldComment(comment,"trainer");
          //battle = new BattleMode(this);
        }
      }
    }
  }
  
  void loadSprite(){
    sprite = data.npcAnimations.get(type).get((""+direction).toUpperCase() + "Stand");
  }
}
