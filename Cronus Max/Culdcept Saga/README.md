# Xbox Live Quick Match Automation Script

## Overview

This script requires 2 Titans/Cronus devices to work. It automates the process of winning 200 matches on Xbox LIVE. 

## Setup Instructions

### Initial Setup
0. Create a new character if you do not already have one. You can create a new character, save, then dashboard after the loading screen. No need to sit through cutscenes or play through the game at all.
1. To setup the match, go to multiplayer (press right at the main menu once) then pick the third option down after selecting your character to host a match.
2. For the 2nd option, scroll left once to use custom rules.
3. For the 5th and 6th options they should read as "10 ~ 10". This makes the games 10 rounds and the timer on a player's turn 10 seconds.
4. Select the top option to confirm.
5. Pick the default map (the square).
6. On the second option down, scroll right once to make the game a player match.
7. On the 5th option down make sure it is set as "2 ~ 4" (this allows the game to start with only 2 players).
8. Select the top option to confirm.
9. Leave the top option in the lobby highlighted.
10. Invite the other account into your game, also leaving the top option highlighted.
11. Simaltaneously press Left Stick (LS) on the account winning and Right Stick (RS) on the account losing. Press start to stop the script.

## Script Behavior

- The script will select the default deck for both players and start the match.
- The winning account will press A for most of the match to accumulate extra points, the losing account will idle.
- Depending on the cards that are drawn the winning account may not actually play a card, this is okay. 
- The match will eventually end. After a few minutes of idle buffer, both accounts will cycle through the post game stats and options. Then the match will restart.
- Occasionally either account will unlock an in-game reward which adds an extra screen to navigate with A. This will cause a de-sync, resulting in the next match not starting. If this happens, just stop the script, highlight the first option again on both controllers and restart the script.

## Notes

- This script essentially starts a match and has the winning player mash A for a large portion of the match ensuring that the winning player earns points while the losing players
	idles and earns as few points as possible. This loops indefinitely so keep an eye on your achievements. You can also view progress in between matches by viewing your primary deck (assuming you didn't have wins from single player or local multiplayer).
- This will make progress towards winning online matches but will also obtain the online win streak achievements along with some achievements for collecting cards.
- If you are scripting the Japanese stack of this game use the script meant for that version, there is an extra button press that is required after the match.
- Due to the fact that there are things that unlock after the match there are other screens that can appear post-match that cause the script to de-sync. there	
	is not a way to bypass this since it seems mostly random. If this happens nothing of consequence should happen, the matches just will not begin. So, it is 
	recommnended that the user keeps an eye on the script to ensure time isn't wasted.
- There is a significant amount of time at the end of matches to ensure that the sequence that restarts the matches is timed correctly. Feel free to remove some of the extra 
	`wait` commands at the beginning of the `end_match` combo but since there is an element of randomness to the length of a match due to the card order being random, 
	it is not recommended. If the `end_match` combo ends too early a new match will not begin. The amount of `wait` commands ensures there is never a de-sync, provided
	there are not extra prompts from unlocks post-game.

For any issues or suggestions, please contact @zombyfraser in the Discord server.
