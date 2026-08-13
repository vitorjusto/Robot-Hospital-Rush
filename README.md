# Robot Hospital Rush
Game made for [White Autumn Games Jam #1 🕹️](https://itch.io/jam/wag-jam-1)

You can play [here](https://vitorjusto.itch.io/robot-hospital-rush)!!!

## Game Concept
- The theme for the mentioned Game Jam was Glitch in the System, however, this concept I used only on the theme of the game, Like a Robot hospital in pandemic, where the pandemic was cause due to global servers errors.
- The game is a time-attack target shooter where the player fires projectiles at robots before the timer runs out.
### Power Ups
 - In this game, it have multiples power ups to assist the player:
     - **Score Multipliers**: mutiply the score by the number represented in the power up
     - **Timer Ups**: Add more time in the timer
     - **Freze**: slower down the robots
     - **Bomb**: Remove all robots on screen
     - **Score** Frenzy: Multiply the score of every target by an certain period of time
- The game can also spawn an "golden robot", when hit will start an explosion destroying every robot next to him.
## Technical Decisions
### Combo System
 - If you hit more targets with the same projectile, you gain more point by accumulating the quantity of robots you hit.
 - example: the first enemy gives 1 point, the second give 2, the third gives 3, and in total you gain 6 points.

The combo multiplier is stored directly in the player projectile. Each time it hits a target, the counter increments and is added to the final score. When the projectile leaves the screen, the counter resets. Simple but effective for a jam scope. 

## Object Pool and Reused Objects
The projectiles and regular robots are reused and instantiated once on the start of the game for performance to improve. They can be activated and deactivated every time.
All power ups share the same object since only one can appear on screen at a time. The same object is reused and reconfigured depending on which power up is selected, avoiding unnecessary instantiation. The golden robot also is instantiated once and have the same behavior, although, is an different object for the other power ups.

### Streak System
In this game, if you hit robots consecutively without misses, the game keep track in the Streak counter, with that, each robots you hit multiply by the streak counter.
The streak counter stacks with the combo system and the scores power ups, allowing the player to gain a lot of points in the process.

## Difficult Curve
In this game, the more time you are playing, more faster everything moves.
Even the timer runs faster. This decision was made to keep the player engaged to the game until the timer runs out, insead of ending up an infinite game forcing the player defeat itself. To keep fair, the game always spawn the timer power up when the timer is lower than 30.

## Running the project
Godot 4.5
Clone the repository, open project.godot in Godot
No external dependencies

## Credits
Developed and pixel art made by Vitorjusto

