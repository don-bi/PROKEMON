public class Player extends Character {
  Bag bag;
  PC pc;
  
  public Player() {
    sprite = data.playerAnimations.get("playerDStand");
    direction = 'd';
    xpos = 0;
    ypos = 0;
    pixel = 0;
    delay = 0;
    isBiking = false;
    isRunning = false;
    bag = new Bag();
    pc = new PC();
    team = new ArrayList<Pokemon>();
  }
  
  void move() {
    if (battle == null) {
      if (getFrontTile().isWalkable) {
        super.move();
        if (leftFoot) {
          sprite = data.playerAnimations.get("player" + (""+direction).toUpperCase() + "LeftWalk");
        } else {
          sprite = data.playerAnimations.get("player" + (""+direction).toUpperCase() + "RightWalk");
        }
        try {
          if (pixel == 0) {
            leftFoot = !leftFoot;
            changeDirection();
            if (currentMapTiles.getTile(xpos,ypos).isGrass){ //20% chance to encounter random pokemon when on grass
              if ((int)random(100) < 20){
                int randnum = (int)random(649)+1;
                println(""+randnum);
                String randpokename = data.getPokename(""+randnum);
                println(randpokename);
                Pokemon randpoke = new Pokemon(randpokename,(int)random(20)+15);
                battle = new BattleMode(randpoke);
              }
            }
          }
        } catch (Exception e) {
          battle = null;
          animations.battleComment("An error has occurred, the battle has been aborted","commanderror");
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
  
  void capturePoke(Pokemon p){
    p.sprite = data.backSprites.get(p.name).get(p.mode);
    if (team.size() < 6) {
      team.add(p);
    } else {
      pc.put(p);
    }
  }
}
