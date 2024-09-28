## Showcase ##
- Gif of user encountering a Pokemon and capturing it
![](https://github.com/don-bi/PROKEMON/blob/main/java_Yflx8cMWa9.gif)

- Gif of user encountering a trainer and being affected by the paralysis status
![](https://github.com/don-bi/PROKEMON/blob/main/java_JRwXEduIJ3.gif)

- Gif of user swapping Pokemon out and using an attack
![](https://github.com/don-bi/PROKEMON/blob/main/java_6bg5sfiQs7.gif)

## Brief Description ##
We created a Pokémon remake with some main features, mainly from Pokémon Emerald and Black and White, using Processing. The game will include the player walking around and exploring the map, encountering wild Pokémon in the grass, and fighting NPC trainers that have their own teams. Every Pokémon up to Generation 5 will be available to use and implemented through different datasets found online, and moves that don't have special conditions, such as solar beam that requires a few turns to use or TMs and egg moves that are learned differently, could be used.

## Compile/Run Instructions ##
Pull from main branch and run Game.pde in processing.

## Cheat Commands ##
**Press ENTER to open command line**
* set partyNumber(1-6) pokemonName level(1-100)
  * Ex. set 1 arceus 100 - sets your party slot 1 to a level 100 Arceus
* setmove partyNumber(1-6) moveNumber(1-4) moveName
  * Non-implemented status moves will display a message saying the move is not implemented yet
  * If the move name has a space, replace the space with a -, ie. hyper beam -> hyper-beam
  * Ex. setmove 1 1 thunder-wave - sets your party slot 1's first move to Thunder Wave
* giveitems
  * gives 5 pokeballs, 5 masterballs, and 5 potions to the player
* teleport
  * teleports the player to Route 1 instantly

## Gameplay ##
The game is mostly just standard pokemon. You could walk around, interact with signs and go inside buildings while you're in the map. When your pokemon are low on hp, you could go to the pokemon center to heal it by interacting with the desk.

We also mimicked the pokemon battling to a large degree, except with certain move effects such as bone rush and water shuriken hitting for multiple times, or leech seed having a lingering effect. To battle, simply choose one of the four options: fight, pokemon, bag, run when prompted.

When choosing fight, there will be four moves to choose from for your pokemon's learned moves before initiating the turn and causing each pokemon to attack each other.

When choosing pokemon, you are able to select from all the pokemon in your current party except if they're dead, and choose one to swap with your on-field pokemon. This forfeits your attack turn and the opposing pokemon attacks your's instantly.

When choosing bag, there will be a gui that pops up to select the item you want to use. A potion will heal your own pokemon for 50 HP, while a pokeball will attempt to capture the opposing pokemon if it's wild and add it to your team. If the capture fails, you will forfeit your turn and the opposing pokemon will instantly attack.

When choosing run, you will escape from the battle if your pokemon's speed is higher than the opposing pokemon's speed, otherwise, an escape odds chance is calculated to see if you will successfully escape from the battle. If not, you will forfeit your turn and the opposing pokemon will instantly attack.

You can also encounter trainers (only one, Rich Guy William) and fight a preset team that he has. There's nothing much different from fighting wild pokemon, but you can't capture and run in trainer battles.

If you somehow lose and all your pokemon dies, you will automatically be teleported to the pokemon center where all your pokemon are healed.

If you want to save your team, just click the save button in the menu and then load it later using the file that was saved.

**PRESS SPACEBAR WHEN FACING SIGNS OR INTERACTABLE STUFF TO INTERACT WITH THEM**

## Most of the mechanics we implemented ##
- Main status effects (freeze, sleep, paralysis, poison, toxic, burn)
- Super effectiveness, ineffectiveness, immunities, quadruple effectiveness
- Healing at the pokecenter
- Healing Pokemon with potions
- Capturing Pokemon with correct odds based on each specific Pokemon
- Pokemon leveling system
- Pokemon fainting at 0 hp
- Teleported to pokecenter when all your Pokemon die
- Trainer encounters where the guy walks up to you, and you can't flee
- Save and load using text files
- Wild Pokemon spawn with randomized IVs
- When you faint opposing Pokemon your own Pokemon gain the correct EV values, affecting stats
- *SIGNS* are readable by pressing space bar
- Certain objects on the map that have models that only cover half of the tile (eg. trees/ boxes) cover the respective player model part but doesn't obstruct the walking
- Walking animations
- Every Pokemon and move (not all of ones with special effects work) up to Gen 5 (Included)
- Implemented stat stage icreases (eg. swords dance sharply raising attack)
- Built my own custom maps using the tiler software with free tile maps I found online
- Added an interactive map such as blocing  the player movement and teleportation zones through the MapModifier software in this repo, that lets me make a csv file with terms like BLOCK, BLOCK, GRASS, DOOR, to portray the map
- Made every Pokemon sprite fit on that circle in the battle background by making a software to chop excess top and bottom pixels
- Scraped the sprite images off some website
