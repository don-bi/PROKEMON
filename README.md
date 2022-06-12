# PROKEMON
**Group Name**: The Prokémon Masters

**Members**: Donald Bi, Hanson He

## Brief Description ##
We will be creating a Pokémon remake with some main features, mainly from Pokémon Emerald, using Processing. The game will include the player walking around and exploring the map, encountering wild Pokémon in the grass, and fighting NPC trainers that have their own teams. Every Pokémon up to Generation 5 will be available to use and implemented through different datasets found online, and moves that don't have special conditions, such as solar beam that requires a few turns to use or TMs and egg moves that are learned differently, could also be learned through leveling.

**Full Documentation**:  
https://docs.google.com/document/d/1yVzZRDgaRQPYU-O_Df970VfCovaV3XTKwuiIwCcpgyU/edit?usp=sharing

## Compile/Run Instructions ##
Pull from main branch and run Game.pde in processing.

## Cheat Commands ##
*set partyNumber(1-6) pokemonName level(1-100)
  *Ex. set 1 arceus 100 - sets your party slot 1 to a level 100 Arceus
*setmove partyNumber(1-6) moveNumber(1-4) moveName
  *Non-implemented status moves will display a message saying the move is not implemented yet
  *If the move name has a space, replace the space with a -, ie. hyper beam -> hyper-beam
  *Ex. setmove 1 1 thunder-wave - sets your party slot 1's first move to Thunder Wave
*giveitems - gives 5 pokeballs, 5 masterballs, and 5 potions to the player
*teleport - teleports the player to Route 1 instantly

## Gameplay ##
The game is mostly just standard pokemon. You could walk around, interact with signs and go inside buildings while you're in the map. When your pokemon are low on hp, you could go to the pokemon center to heal it by interacting with the desk.

We also mimicked the pokemon battling to a large degree, except with certain move effects such as bone rush and water shuriken hitting for multiple times, or leech seed having a lingering effect. To battle, simply choose one of the four options: fight, pokemon, bag, run when prompted. 

When choosing fight, there will be four moves to choose from for your pokemon's learned moves before initiating the turn and causing each pokemon to attack each other.

When choosing pokemon, you are able to select from all the pokemon in your current party except if they're dead, and choose one to swap with your on-field pokemon. This forfeits your attack turn and the opposing pokemon attacks your's instantly.

When choosing bag, there will be a gui that pops up to select the item you want to use. A potion will heal your own pokemon for 50 HP, while a pokeball will attempt to capture the opposing pokemon if it's wild and add it to your team. If the capture fails, you will forfeit your turn and the opposing pokemon will instantly attack.

When choosing run, you will escape from the battle if your pokemon's speed is higher than the opposing pokemon's speed, otherwise, an escape odds chance is calculated to see if you will successfully escape from the battle. If not, you will forfeit your turn and the opposing pokemon will instantly attack.

You can also encounter trainers (only one, Rich Guy William) and fight a preset team that he has. There's nothing much different from fighting wild pokemon, but you can't capture and run in trainer battles.

If you somehow lose and all your pokemon dies, you will automatically be teleported to the pokemon center where all your pokemon are healed.

### 5/22/2022 ###
**Donald**: Made MapModifier and finished the display, with color and tile classes. Added changing to different modes of placing and ways to print the map data too.

**Hanson**: Added color when tile has modifier by updating texture, edited mouseTile() and mousePressed() for whatever mode is given, made commandline appear, haven't resolved merge

### 5/23/2022 ###
**Donald**: Finished MapModifier and finished walking animations and teleportation through doors for player

**Hanson**: Fixed importing issues and added nullpointer exception otherwise

### 5/24/2022 ###
**Donald**: Made two new programs, pokemon_moves_fixer to get rid of useless data in pokemon_moves.csv and SpriteResizer to resize the sprites that were originally 96x96(too small). Started on battlemode, but not much done yet.

**Hanson**: Testing merge from lessons in class

### 5/25/2022 ###
**Donald**: Changed SpriteResizer to make images be has high as it has colors and also added loading in pokemon stats and other data

**Hanson**: Starting sounds hashmap and creating battlesounds/ researching hashmaps with sound osc

### 5/26/2022 ###
**Donald**: Added loading in the sprites for both front and back, fixed walking animation, and started Guis and Buttons

**Hanson**: Sounds class and working with library downloads for sounds

### 5/27/2022 ###
**Donald**: Finished Gui and Buttons, Buttons could open up Guis now and Guis properly contain buttons, also started to load in the two move csvs

**Hanson**: resolved sounds conflict and started pokemon choosing method

### 5/28/2022 ###
**Donald**: Finished loading in the move csvs

**Hanson**: finished pokemon choosing method constructor

### 5/29/2022 ###
**Donald**: Made battle calculations such as damage for moves and also for pokemon stats. Made basic turn based attacking and started working on the switching pokemon mechanics.

**Hanson**: finished pokemon choosing method constructor

### 5/30/2022 ###
**Donald**: Finished the switch pokemon menu, added new maps, implemented choosing a new pokemon when current one dies, and made player tp to the pokecenter when all your pokemon is knocked out.

**Hanson**: displayed MVP, researched methods and calculations after

### 5/31/2022 ###
**Donald**: Added exp csv for later implementation and also added more images for battle uis and exp bar. Added a new pixel that'll be used for everything now.

### 6/1/2022 ###
**Donald**: Started working on loading in exp.csv for level ups.

**Hanson**: updated documentation with battle mechanics and switch phases

### 6/2/2022 ###
**Donald**: Finished loading in exp.csv and initialized the data for Pokemon classes. Changed battle Uis to better ones and made the exp bar show on them. Started working on battle comments slowly animating.

**Hanson**: fixed memory problems and updated used functions

### 6/3/2022 ###
**Donald**: Started working on the hp bar animation.

### 6/4/2022 ###
**Donald**: N/A

### 6/5/2022 ###
**Donald**: Finished fixing up hp bar animation and also finished effectiveness messages. Started working on using items, currently only have the images.

### 6/6/2022 ###
**Donald**: Finished implementing exp gain after defeating a pokemon. Also finished the animation for the exp bar moving with the exp gain, along with leveling up. Started working on the bag for catching and potions, only made the buttons so far.

**Hanson**: Fighting/bag changes + bug testing :)

### 6/7/2022 ###
**Donald**: Implented catching pokemon and animated it using the parabolic equation for a very nice curve.

### 6/8/2022 ###
**Donald**: Finished status effects being applied and hurting/skipping the pokemon's turns. Finished animating the start of the battle, with throwing pokeballs at the start of the battle and when switching pokemon.

### 6/9/2022 ###
**Donald**: Touched up on the start throwing pokeball animation and also implemented the coming in of the wild pokemon sprite and their ui. Finished status effects by implementing sleep mechanics and fixed some bugs.

### 6/10/2022 ###
**Donald**: Made a command class to cheat and set pokemons and set moves. Made trainers actually appear and load into the map, and be able to encounter them. Started working on the battle mechanics against trainers ie. the swapping and other stuff.

**Hanson**: Out of building moving into barrier- stops character and cannot move

### 6/11/2022 ###
**Donald**: Fixed remaining bugs with trainer battles, and many other remaining bugs. Finished making potion mechanics. Made menu buttons and pokemondata Gui that shows the data of pokemon in your party. ALso implemented save and load buttons and made interactable tiles actually interactable now. Added nurse joy to the pokecenter.
