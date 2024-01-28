# General Information

These are some tools to assist with the Aaero completion, which I started about halfway through advanced difficulty, and landed on version 3.0 to complete my last levels on Master.

As is often the case, I likely spent more time on developing this than time saved, so knowing if it saved other people time too really helps make it worth it!

Now, onto the goodies.

> Note - Version 3 ended up as a complete rewrite when the existing script struggled to get me past the last few levels (Edge of Tomorrow and Alpha Centauri on Master). The old version was generally limited to firing on every other beat otherwise the timing would be unreliable (very bizarre combination of device limitations).
> 
>This version should be more reliable across the duration of the song (and allows firing every beat or whenever you need), but does seem to be a little less effective at firing lasers i.e. the optimal moment. Still, it was enough to get me through those levels first try (once written) and I even lost the combo near the end several times and still hit 5*, so it should hopefully still be useful to you.

# LED Key

RED - Script loaded but not active

GREEN - Macro Running

BLUE - Fire on Beat active

# Shoot Timing Assistance

This is the primary use of the script. It uses the bpm to determine when to shoot to maximise points and minimise time to hit.

Guides/tips on TA focus on keeping your combo throughout the level to get 5 stars. **Using this script, I was able to 5 stars on several levels even though I broke combo and even died in some places.**

## Usage

1. Change the `bpm` value as per the list noted in the script
2. Load the compiled script onto device (but don't set active yet)
3. Navigate Aaero menus and select the desired level
4. On the "Ready?" prompt in-game, you can load the script and press A to begin - this is important so the beat timing is in sync between the game and script

## Auto Fire
> The next paragraph was written during version 2.x, I'll leave it in case version 3 .xcauses problems on levels I didn't retest on and you're curious how it was done originally.

For most levels, it seems the sweet spot was automatically firing on _every other beat_ (which is achieved by the `2 x beatInterval` i.e. `int shotDelay = 2*beatInterval - sixteenth;`). Trying to fire on every beat seemed to cause the script to desync and fire slightly late, a.k.a. extremely early for the subequent beat. I suspect this to be due to polling limitations.


## Manually shoot but delay to beat

Choosing when to shoot is enabled by default, meaning that you can lock onto however many targets you want, press RT, and it will shoot just before the next beat. You can also hold down RT if you want it to shoot every beat and save your fingers some work.

If you want to disable manual fire entirely, remove the use of `fireNext` in the below conditional:
```    
if (shoot && fireNext) {
    combo_run(shootOnce);
}
```


# Macros

For T2, macros refers to a recording of inputs, which are stored in `.gmk`s. More info is available online https://www.consoletuner.com/wiki/index.php?id=t2:gpc_scripting:macros

Whilst playing through levels using the shoot timing assist above, I tried to record macros of successful runs so I could:

1. Use it on master (as these are the same as advanced but with 1 life)
2. Share to others who can complete this even easier

Note the precision of the macro obviously has a limitation, which you can sometimes see in following the blue line - it may sometimes be jaggedy and loose the combo. Don't worry, if the level is marked with a P in the bpm table, then I've tested it myself and got 5*s. 

As mentioned above, the LED will show green when running, and red when it's not (including after successfully running through it).

## Usage

1. Ensure the macro is on your T2
2. Change `macro_run("<filename>.gmk");` to the desired filename
3. As with the fire assist, don't load the script until you're at the "Ready?" screen
4. Click the LS to start the macro (which includes the press A to begin)

## Record and share you own!

The script is set to automatically record a new macro when running, based on the filename given in `macro_rec("<filname>.gmk");`. Note filenames cannot be longer than 8 characters! It will also overwrite any existing macro of the same name on the SD card.

Pressing `MENU` (a.k.a. "start" from  the 360 era) will stop the script, this includes stopping and macros currently running and/or recording.