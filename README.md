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

### 5/29/2022 ###
Donald: Made battle calculations such as damage for moves and also for pokemon stats. Made basic turn based attacking and started working on the switching pokemon mechanics.

Hanson: finished pokemon choosing method constructor

### 5/30/2022 ###
Donald: Finished the switch pokemon menu, added new maps, implemented choosing a new pokemon when current one dies, and made player tp to the pokecenter when all your pokemon is knocked out.

### 5/31/2022 ###
Donald: Added exp csv for later implementation and also added more images for battle uis and exp bar. Added a new pixel that'll be used for everything now.
