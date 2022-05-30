public class Player extends Character {
  public Player() {
    sprite = data.playerAnimations.get("playerDStand");
    direction = 'd';
    xpos = 0;
    ypos = 0;
    pixel = 0;
    delay = 0;
    isBiking = false;
    isRunning = false;
    team = new ArrayList<Pokemon>();
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
      if (currentMapTiles.getTile(xpos,ypos).isGrass){
        if ((int)random(10) == 2){
          Pokemon randpoke = new Pokemon(data.getPokename(""+(int)random(649)+1),10);
          battle = new BattleMode(randpoke);
        }
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
    
    //math to make it so the view never moves past the border, only moving the character
    if (xpos < 7) {
      playerxpos = -7*16*6 + width/2 - sprite.width/2 - 6;
    }
    if (ypos < 4) {
      playerypos = -4*16*6 + height/2 - sprite.height/2 + 15;
    }
    int xborder = currentMapTiles.WIDTH-8;
    if (xpos > xborder) {
      playerxpos = -(xborder)*16*6 + width/2 - sprite.width/2 - 6;
    }
    int yborder = currentMapTiles.HEIGHT-5;
    if (ypos > yborder) {
      playerypos = -(yborder)*16*6 + height/2 - sprite.height/2 + 15;
    }
    if ((xpos <= 7 && !(xpos == 7 && direction == 'r')) 
      || (xpos >= xborder && !(xpos == xborder && direction == 'l'))) xmoveOffset = 0;
    if ((ypos <= 4 && !(ypos == 4 && direction == 'd')) 
      || (ypos >= yborder && !(ypos == yborder && direction == 'u'))) ymoveOffset = 0;
    //---------------------------------------------------------------------------------
      
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
    if (frameCount > 0  && inWalkAnimation && !animations.inAnimation && battle == null) {
      move();
      display();
    } else { 
      display();
    }
    image(data.mapMasks.get(currentMap), 0, 0);
  }
}
