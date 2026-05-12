
---
![Screenshot](Assets/dice_catcher.gif)	

# DiceCatcher 🎲

**DiceCatcher** is a fast-paced, arcade-style 2D game built with **Godot 4**. Test your reflexes as you scramble to catch falling dice, rack up combos, and aim for the high score! Featuring custom pixel art and a clean, modular codebase.

## Gameplay

The rules are simple: dice fall from the top of the screen, and you must catch them before they hit the ground.

* **Catching:** Move your bucket/character to collect falling dice.
* **Scoring:** Different dice values provide different point rewards.
* **Game Over:** Don't let too many dice slip past you!

## Key Features

* **Custom Pixel Art:** Unique, handcrafted dice and environment assets.
* **Session Persistence:** High scores are saved locally using Godot's **Resource Management** system (supporting both `.tres` for debugging and `.res` for production).
* **Signal-Driven UI:** Decoupled architecture where the UI listens to a `SignalHub` for score updates and game states.
* **Responsive Controls:** Smooth movement logic optimized for both keyboard and touch input.

## Technical Overview

* **Engine:** Godot 4.x
* **Architecture:** * **Global Signal Bus:** All major game events (scoring, catching, failing) are broadcast through a central `SignalHub`.
* **Autoload Singletons:** Persistent managers handle audio, scoring logic, and scene transitions (`GameManager`, `ScoreManager`).
* **Object Pooling:** Efficiently handles the spawning and despawning of numerous falling dice objects.


* **Audio:** Dynamic sound effects that vary in pitch or volume based on the dice value caught.

## Project Structure

* `/Scenes`: Modular scenes for the Player, Dice, and UI.
* `/Scripts`: Clean GDScript files following the **Single Responsibility Principle**.
* `/Assets`: Original pixel art and sound effects.
* `/Resources`: Custom Godot Resources for saving player data.

---

### 🎨 Artist's Note

All visual assets in DiceCatcher were created using [Your Pixel Art Tool, e.g., Aseprite]. I focused on creating clear, readable silhouettes for the dice to ensure the gameplay feels fair and responsive.

---

### Tips for your GitHub:

1. **Screenshots:** Just like with Tappy, add an `img` folder and include a GIF of the dice falling. It makes the repository much more attractive to recruiters or other devs.
2. **License:** Consider adding a `LICENSE` file (like MIT) if you want people to be able to learn from or use your code.
3. 
**The Score Logic:** Since you already have a `ScoreManager` from the Tappy project , you can easily drop that same logic into DiceCatcher to handle the high scores! 



**How does the scoring work in DiceCatcher—do you get more points for catching a '6' than a '1'?**