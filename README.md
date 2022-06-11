# PROKEMON
**Group Name**: The Prokémon Masters

**Members**: Donald Bi, Hanson He

## Brief Description ##
We will be creating a Pokémon remake with some main features, mainly from Pokémon Emerald, using Processing. The game will include the player walking around and exploring the map, encountering wild Pokémon in the grass, and fighting NPC trainers that have their own teams. Every Pokémon up to Generation 5 will be available to use and implemented through different datasets found online, and moves that don't have special conditions, such as solar beam that requires a few turns to use or TMs and egg moves that are learned differently, could also be learned through leveling.

**Full Documentation**:  
https://docs.google.com/document/d/1yVzZRDgaRQPYU-O_Df970VfCovaV3XTKwuiIwCcpgyU/edit?usp=sharing

### 5/22/2022 ###
Donald: Made MapModifier and finished the display, with color and tile classes. Added changing to different modes of placing and ways to print the map data too.

Hanson: Added color when tile has modifier by updating texture, edited mouseTile() and mousePressed() for whatever mode is given, made commandline appear, haven't resolved merge

### 5/23/2022 ###
Donald: Finished MapModifier and finished walking animations and teleportation through doors for player

Hanson: Fixed importing issues and added nullpointer exception otherwise

### 5/24/2022 ###
Donald: Made two new programs, pokemon_moves_fixer to get rid of useless data in pokemon_moves.csv and SpriteResizer to resize the sprites that were originally 96x96(too small). Started on battlemode, but not much done yet.

Hanson: Testing merge from lessons in class

### 5/25/2022 ###
Donald: Changed SpriteResizer to make images be has high as it has colors and also added loading in pokemon stats and other data

Hanson: Starting sounds hashmap and creating battlesounds/ researching hashmaps with sound osc

### 5/26/2022 ###
Donald: Added loading in the sprites for both front and back, fixed walking animation, and started Guis and Buttons

Hanson: Sounds class and working with library downloads for sounds

### 5/27/2022 ###
Donald: Finished Gui and Buttons, Buttons could open up Guis now and Guis properly contain buttons, also started to load in the two move csvs

Hanson: resolved sounds conflict and started pokemon choosing method

### 5/28/2022 ###
Donald: Finished loading in the move csvs
Hanson: finished pokemon choosing method constructor

### 5/29/2022 ###
Donald: Made battle calculations such as damage for moves and also for pokemon stats. Made basic turn based attacking and started working on the switching pokemon mechanics.

Hanson: finished pokemon choosing method constructor

### 5/30/2022 ###
Donald: Finished the switch pokemon menu, added new maps, implemented choosing a new pokemon when current one dies, and made player tp to the pokecenter when all your pokemon is knocked out.

Hanson: displayed MVP, researched methods and calculations after

### 5/31/2022 ###
Donald: Added exp csv for later implementation and also added more images for battle uis and exp bar. Added a new pixel that'll be used for everything now.

### 6/1/2022 ###
Donald: Started working on loading in exp.csv for level ups.

Hanson: updated documentation with battle mechanics and switch phases

### 6/2/2022 ###
Donald: Finished loading in exp.csv and initialized the data for Pokemon classes. Changed battle Uis to better ones and made the exp bar show on them. Started working on battle comments slowly animating.

Hanson: fixed memory problems and updated used functions

### 6/3/2022 ###
Donald: Started working on the hp bar animation.

### 6/4/2022 ###
Donald: N/A

### 6/5/2022 ###
Donald: Finished fixing up hp bar animation and also finished effectiveness messages. Started working on using items, currently only have the images.

### 6/6/2022 ###
Donald: Finished implementing exp gain after defeating a pokemon. Also finished the animation for the exp bar moving with the exp gain, along with leveling up. Started working on the bag for catching and potions, only made the buttons so far.

Hanson: Fighting/bag changes + bug testing :)

### 6/7/2022 ###
Donald: Implented catching pokemon and animated it using the parabolic equation for a very nice curve.

### 6/8/2022 ###
Donald: Finished status effects being applied and hurting/skipping the pokemon's turns. Finished animating the start of the battle, with throwing pokeballs at the start of the battle and when switching pokemon.

### 6/9/2022 ###
Donald: Touched up on the start throwing pokeball animation and also implemented the coming in of the wild pokemon sprite and their ui. Finished status effects by implementing sleep mechanics and fixed some bugs.

### 6/10/2022 ###
Donald: Made a command class to cheat and set pokemons and set moves. Made trainers actually appear and load into the map, and be able to encounter them. Started working on the battle mechanics against trainers ie. the swapping and other stuff.

Hanson: Out of building moving into barrier- stops character and cannot move
