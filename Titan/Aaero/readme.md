# General Information

These are some tools to assist with the Aaero completion, which I started about halfway through advanced difficulty.

As is often the case, I likely spent more time on developing this than time saved, so knowing if it saved other people time too really helps make it worth it!

Now, onto the goodies.
# LED Key

RED - Script loaded but not active

GREEN - Macro Running

BLUE - Fire on Beat active

# Auto Fire On Beat

This is the primary use of the script. It uses the bpm to determine when to shoot to maximise points and minimise time to hit.

## Usage

1. Change the `bpm` value as per the list below (also included in script)
2. Load up onto device (but don't set active yet)
3. Navigate aaero menus and select level
4. On "Press A to Begin", you can load the script and press A to begin, this is important so the beat timing is in sync

For most levels, it seems the sweet spot was automatically firing on _every other beat_ (which is achieved by the `2 x beatInterval` i.e. `int shotDelay = 2*beatInterval - sixteenth;`). Trying to fire on every beat seemed to cause the script to desync and fire slightly late, a.k.a. extremely early for the subequent beat. I suspect this to be due to polling limitations.

Guides on TA focus on keeping your combo throughout the level to get 5 stars. **Using this script, I was able to 5 stars on several levels even though I broke combo and even died in some places.**

# Manually shoot but delay to beat

On some levels, you might want to wait longer or shorter based on the situation, so I tried to implement a means for users to specify which beats to shoot on on-the-fly i.e. user presses RT > script delays the shot until it is close to the beat to maximise points. Whilst it does delay it, it seemed to suffer the issues described above from shooting on every beat. I left it in so you can play around if the auto fire isn't cutting it.

## Usage

If you want to try this script feature, uncomment the `if` statement in `fireOnBeat`.

# Macros

For T2, macros refers to a recording of inputs, which are stored in `.gmk`s. More info is available online https://www.consoletuner.com/wiki/index.php?id=t2:gpc_scripting:macros

Whilst playing through levels using the auto beat fire assist above, I tried to record macros of successful runs so I could

1. Use it on master (as these are the same as advanced but with 1 life)
2. Share to others who can complete this even easier

Note the precision of the macro obviously has a limitation, which you can sometimes see in following the blue line - it may sometimes be jaggedy and loose the combo. Don't worry, if the level is marked with a P in the table, thwn I've tested it myself and got 5*s. 

As mentioned above, the LED will show green when running, and red when it's not (including after successfully running through it).

## Usage

1. Ensure the macro is on your T2
2. Change `macro_run("<filename>.gmk");`
3. As with the auto fire, don't load the script until you're at the "Press A to Begin" screen
4. Click the LS to start the macro (which includes the press A to begin)

## Record and share you own!

The script is set to automatically record a new macro when running, based on the filename given in `macro_rec("<filname>.gmk");`. Note filenames cannot be longer than 8 characters! It will also overwrite any existing macro of the same name on the SD card.

Pressing `MENU` (a.k.a. "start" from  the 360 era) will stop the script, this includes stopping and macros currently running and/or recording.