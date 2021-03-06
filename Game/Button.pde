public class Button{
  int x,y;
  PImage texture;
  Gui opensGui;
  String special;

  public Button(Gui in,int X,int Y){
    in.buttons.add(this);
    x = X;
    y = Y;
  }
 
 public Button(Gui in, Gui opens, int X, int Y){
   this(in,X,Y);
   opensGui = opens;
 }
 
 public Button(Gui in, Gui opens, int X, int Y, String s){
   this(in,opens,X,Y);
   special = s;
 }
 
 public Button(Gui in, int X, int Y, String s){
   this(in,X,Y);
   special = s;
 }
 
  
  void display(){
    if (texture != null) image(texture,x,y);
    if (special != null){
      textSize(50);
      fill(255); 
      if (this == data.menubutton){ //these three are to display the text on the menu buttons
        text("MENU",1300,50);
      }
      if (this == data.menupokemon) {
        text("POKéMON",1275,50);
      }
      if (this == data.menuload) {
        text("LOAD",1300,125);
      }
      if (this == data.menusave) {
        text("SAVE",1300,200);
      }
      if (this == data.menuexit) {
        text("EXIT",1300,275);
      }
      Pokemon poke;
      textSize(40);
      fill(0);
      PImage icon;
      switch (special){ //Displays the pokemon name and level in the switchpokemon screen and in the menupokemon screen in the overworld
        case "poke1": case "menupoke1":
          poke = player.team.get(0);
          text(poke.name,270,250);
          text("Lv"+poke.level,300,290);
          int y = 327;
          if (special.equals("menupoke1")) y -= 10;
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),280,y);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,132,134+(96-icon.height)/2);
          break;
        case "poke2": case "menupoke2":
          poke = player.team.get(1);
          text(poke.name,690,120);
          text("Lv"+poke.level,720,160);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,122);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,562,89+(96-icon.height)/2);
          break;
        case "poke3": case "menupoke3":
          poke = player.team.get(2);
          text(poke.name,690,240);
          text("Lv"+poke.level,720,280);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,242);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,562,209+(96-icon.height)/2);
          break;
        case "poke4": case "menupoke4":
          poke = player.team.get(3);
          text(poke.name,690,360);
          text("Lv"+poke.level,720,400);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,362);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,562,329+(96-icon.height)/2);
          break;
        case "poke5": case "menupoke5":
          poke = player.team.get(4);
          text(poke.name,690,480);
          text("Lv"+poke.level,720,520);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,562,449+(96-icon.height)/2);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,482);
          break;
        case "poke6": case "menupoke6":
          poke = player.team.get(5);
          text(poke.name,690,600);
          text("Lv"+poke.level,720,640);
          image(data.hpBar.get(0,0,poke.hp*240/poke.stats.get("hp"),15),1040,602);
          icon = data.frontSprites.get(poke.name).get(poke.mode).get();
          icon.resize(96,0);
          image(icon,562,569+(96-icon.height)/2);
          break;
      }
      
      if (battle != null) {
        textSize(50);
        fill(0);
        poke = battle.ally;
        
        switch (special){ //displays the move buttons is battle
          case "move1":
            if (poke.moves[0] != null) text(poke.moves[0].toString(),x+10,y+texture.height/2);
            break;
          case "move2":
            if (poke.moves[1] != null) text(poke.moves[1].toString(),x+10,y+texture.height/2);
            break;
          case "move3":
            if (poke.moves[2] != null) text(poke.moves[2].toString(),x+10,y+texture.height/2);
            break;
          case "move4":
            if (poke.moves[3] != null) text(poke.moves[3].toString(),x+10,y+texture.height/2);
            break;
        }
        textSize(72);
        switch (special) {
          case "pokeball":
            text("POKé BALL",690,158);
            text("x"+player.bag.pokeballs,1170,158);
            break;
          case "masterball":
            text("MASTER BALL",690,216);
            text("x"+player.bag.masterballs,1170,216);
            break;
          case "potion":
            text("POTION",690,158);
            text("x"+player.bag.potions,1170,158);
            break;
        }
      }
    } //ends if (special !null)
  }
  
  void processHover(){
    if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
      if (special != null) {
        fill(0);
        textSize(80);
        if (special.equals("potion")) {
          image(data.potionhover,160,392);
          text("Heals your current\npokemon 50 HP.",150,600);
        }
        if (special.equals("pokeball")) {
          image(data.pokeballhover,160,392);
          text("A basic POKé BALL.",150,600);
        }
        if (special.equals("masterball")){
          image(data.masterballhover,160,392);
          text("Always captures the\nopposing pokemon.",150,600);
        }
      }
    }
  }
  
  void processClick(){
    if (mouseX > x && mouseX < x+texture.width && mouseY > y && mouseY < y+texture.height){
      if (special == null){
        currentGui = opensGui;
      } else {
        if(opensGui != null) {
          currentGui = opensGui;
        }
        
        if (special.equals("save")) { //when clicking the load button in the menu it calls this to export it into a file
          animations.overworldComment("SAVING....","commanderror");
          String exportfile = "prokemondata" + frameCount + ".txt";
          PrintWriter export = createWriter(exportfile);
          export.println(player.team.size());
          for (Pokemon poke:player.team){
            export.println(poke.name);
            export.println(poke.level);
            export.println(poke.hp);
            export.println(poke.exp);
            export.println(poke.nature);
            export.println(poke.nonvolStatus);
            if (poke.pokeball == data.pokeball) { //gets pokeballtype the pokemon is in
              export.println("pokeball");
            } else {
              export.println("masterball");
            }
            String[] statnames = {"hp","atk","def","spatk","spdef","spd"};
            for (String stat:statnames) {
              export.print(poke.stats.get(stat) + " ");
              export.print(poke.EVs.get(stat) + " ");
              export.print(poke.IVs.get(stat) + " ");
              export.println();
            }
            int movesAmt = 0;
            for (Move move:poke.moves) { //counts how many moves that are not null there are
              if (move != null) movesAmt ++;
            }
            export.println(movesAmt);
            for (Move move:poke.moves) {
              if (move != null) export.println(move.id);
            }
          }
          export.flush();
          export.close();
        }
        
        if (special.equals("load")) {
          player.team = new ArrayList<Pokemon>();
          selectInput("Select a file to load", "fileSelected");
        }
        
        switch(special) {
          case "menupoke1":
            data.pokemondata.whichpokesdata = player.team.get(0);
            data.pokemonevs.whichpokesdata = player.team.get(0);
            data.pokemonivs.whichpokesdata = player.team.get(0);
            break;
          case "menupoke2":
            data.pokemondata.whichpokesdata = player.team.get(1);
            data.pokemonevs.whichpokesdata = player.team.get(1);
            data.pokemonivs.whichpokesdata = player.team.get(1);
            break;
          case "menupoke3":
            data.pokemondata.whichpokesdata = player.team.get(2);
            data.pokemonevs.whichpokesdata = player.team.get(2);
            data.pokemonivs.whichpokesdata = player.team.get(2);
            break;
          case "menupoke4":
            data.pokemondata.whichpokesdata = player.team.get(3);
            data.pokemonevs.whichpokesdata = player.team.get(3);
            data.pokemonivs.whichpokesdata = player.team.get(3);
            break;
          case "menupoke5":
            data.pokemondata.whichpokesdata = player.team.get(4);
            data.pokemonevs.whichpokesdata = player.team.get(4);
            data.pokemonivs.whichpokesdata = player.team.get(4);
            break;
          case "menupoke6":
            data.pokemondata.whichpokesdata = player.team.get(5);
            data.pokemonevs.whichpokesdata = player.team.get(5);
            data.pokemonivs.whichpokesdata = player.team.get(5);
            break;
        }
        
        if (special.equals("menupokemon")) { //when opening the menu to view pokemon stats & stuff, it remakes the buttons according to current pokemon team
          data.pokemons.buttons = new ArrayList<Button>();
          switch(player.team.size()){
            case(6):
              data.menupoke6 = new Button(data.pokemons,data.pokemondata,560,562,"menupoke6");
              data.menupoke6.texture = data.smallPoke;
              data.pokemons.buttons.add(data.menupoke6);
            case(5):
              data.menupoke5 = new Button(data.pokemons,data.pokemondata,560,442,"menupoke5");
              data.menupoke5.texture = data.smallPoke;
              data.pokemons.buttons.add(data.menupoke5);
            case(4):
              data.menupoke4 = new Button(data.pokemons,data.pokemondata,560,322,"menupoke4");
              data.menupoke4.texture = data.smallPoke;
              data.pokemons.buttons.add(data.menupoke4);
            case(3):
              data.menupoke3 = new Button(data.pokemons,data.pokemondata,560,202,"menupoke3");
              data.menupoke3.texture = data.smallPoke;
              data.pokemons.buttons.add(data.menupoke3);
            case(2):
              data.menupoke2 = new Button(data.pokemons,data.pokemondata,560,82,"menupoke2");
              data.menupoke2.texture = data.smallPoke;
              data.pokemons.buttons.add(data.menupoke2);
            case(1):
              data.menupoke1 = new Button(data.pokemons,data.pokemondata,130,122,"menupoke1");
              data.menupoke1.texture = data.bigPoke;
              data.pokemons.buttons.add(data.menupoke1);
          }
          data.cancel = new Button(data.pokemons,data.menu,1040,702);
          data.cancel.texture = loadImage("cancel.png");
          data.pokemons.buttons.add(data.cancel);
        }
        
        if (battle != null) {
          Pokemon poke = battle.ally; //special cases for move buttons
          boolean endturn = false;
          String choice = "";
          poke.currentMove = null;
          
          if (special.equals("endComment")) { //for when clicking something and needs to make there be no comment
            animations.battlecomment = null;
            animations.inAnimation = false;
            animations.commenting = false;
            currentGui = opensGui;
          }
          
          if (special.equals("pokeball")) { //when choosing to throw regular pokeball
            if (player.bag.pokeballs <= 0){
              animations.battleComment("You have no more POKé BALLS!","fightoptions");
              currentGui = null;
              
            } else if (battle.opponent == null) { //cannot catch pokemon if you are fighting a trainer
              animations.throwball(data.pokeball);
              player.bag.pokeballs --;
            } else {
              animations.battleComment("You are unable to catch a trainer's POKéMON","fightoptions");
              currentGui = null;
            }
          } else if (special.equals("masterball")) { //when choosing to throw masterball
            if (player.bag.masterballs <= 0){
              animations.battleComment("You have no more MASTER BALLS!","fightoptions");
              currentGui = null;
            } else if (battle.opponent == null) { //cannot catch pokemon if you are fighting a trainer
              animations.throwball(data.masterball);
              player.bag.masterballs --;
            } else {
              animations.battleComment("You are unable to catch a trainer's POKéMON","fightoptions");
              currentGui = null;
            }
          }
          if (special.equals("potion")) { //when choosing to use a potion
            if (player.bag.potions <= 0){
              animations.battleComment("You have no more potions!","fightoptions");
              currentGui = null;
            } else {
              if (battle.ally.hp == battle.ally.stats.get("hp"))  {
                animations.battleComment(battle.ally.name + " already has full HP!","fightoptions");
                currentGui = null;
              } else {
                battle.playerchoice = "bag";
                battle.doTurn();
                animations.battleComment("Your potion healed " + battle.ally.name + " for 50HP!","potion");
                player.bag.potions--;
                currentGui = null;
              }
            }
          }
          
          if (special.length() > 3 && special.substring(0,4).equals("move")) { //special interactions for move option buttons
            if (special.equals("move1") && poke.moves[0] != null) poke.currentMove = poke.moves[0];
            if (special.equals("move2") && poke.moves[1] != null) poke.currentMove = poke.moves[1];
            if (special.equals("move3") && poke.moves[2] != null) poke.currentMove = poke.moves[2];
            if (special.equals("move4") && poke.moves[3] != null) poke.currentMove = poke.moves[3];
            if (poke.currentMove != null) {
              choice = "fight";
              endturn = true;
            }
          }
          
          if (special.length() > 3 && special.substring(0,4).equals("poke")) { //special interactions for switching pokemon buttons
            if (special.equals("poke1") && battle.ally != player.team.get(0) && player.team.get(0).hp > 0) {
              choice = "0";
              endturn = true;
              texture = data.bigChosenPoke;
              y -= 10;
              battle.chosenButton.texture = data.smallPoke;
              battle.chosenButton.y += 5;
              battle.chosenButton = this;
            } else {
              if (special.equals("poke2") && battle.ally != player.team.get(1) && player.team.get(1).hp > 0) choice = "1";
              if (special.equals("poke3") && battle.ally != player.team.get(2) && player.team.get(2).hp > 0) choice = "2";
              if (special.equals("poke4") && battle.ally != player.team.get(3) && player.team.get(3).hp > 0) choice = "3";
              if (special.equals("poke5") && battle.ally != player.team.get(4) && player.team.get(4).hp > 0) choice = "4";
              if (special.equals("poke6") && battle.ally != player.team.get(5) && player.team.get(5).hp > 0) choice = "5";
              if (!choice.equals("")) {
                println(choice);
                endturn = true;
                texture = data.smallChosenPoke;
                if (battle.chosenButton.special.equals("poke1")) {
                  battle.chosenButton.texture = data.bigPoke;
                  battle.chosenButton.y += 10;
                } else {
                  battle.chosenButton.texture = data.smallPoke;
                  battle.chosenButton.y += 5;
                }
                y -= 5;
                battle.chosenButton = this;
              }
            }
          }
          if (special.equals("run")){
            endturn = true;
            choice = "run";
          }
          if (endturn) {
            if (currentGui == data.deadPokemon){ //When choosing a pokemon after own died, it goes back to fight options
              currentGui = null;
              battle.ally = player.team.get(parseInt(choice));
              animations.switchPoke();
              animations.battleComment("Go! " + battle.ally.name + "!","deadpokemon");
            } else { //regular switching just ends turn
              currentGui = null;
              battle.playerchoice = choice;
              battle.doTurn();
            }
          }
        }
      }
    }
  }
  
  String toString(){
    return special;
  }
}
