# Development Journey

*This will be a rough summary of the development process as I started this about a month into development*

Days 1-3: Followed the tutorial to add all tilesets into the files and create the character with basic movement, skins, and animations. This part was still very similar to the tutorial, 
but I was on a newer version so there were some extra/different steps I had to take

Days 4-5: Added a tilemap, created spikes, and added a camera that follows the player. This was very interesting and very fun for me because I had to do many things very differently from the
tutorial. This was also about the time I started realizing the tutorial was going to be more of guide for what I should develop next and a small path to get there, rather than a fully correct 
tutorial.

Days 6-7: This was when I added walking enemies and hitboxes. I also added custom movement data for my character, that way you can load different movement types.

Days 8-10: Added ladders, double jump, and a jump buffer. The ladder also had me add enumerated move states from climbing vs moving. Lastly I added looping enemies that move on a sort of rail system.

Day 11: This is when I added sounds and the game stated to feel more complete. I got the sounds by using chiptune and I added sounds that I felt I needed. 

Day 13: Added the smash enemy that does not in anyway look like a copyright enemy. This not only was very fun to make, but it allowed me to use new sounds and taught me how to use particles.

Day 14-15: This was the last of the lessons from the tutorial. It showed me level inheritence and scene transitions, which are very important to any game with multiple levels.

Days 16-24: Worked on adding more levels

Days 25-30: Added new enemies and levels

Days 31-34: Added new tile maps and worked on making levels longer. I also started work on making the background work better, along with starting this documentation. 

Day 35: Added terrains and hate that I didnt earlier

Day 36: Updated tilesets so they all have proper terrains and collision. I also made the first level more full

Day 37: Made level 1 and 2 have full platforms, coins/coin blocks, enemies all the way,  ladders where necessary, and added other fun stuff where necessary like spikes and decor. Once I was done with all that, I organized all the nodes using named blank base nodes. Overall this was just a long day of making sure the levels where long enough and had the right spice to be fun.

Day 38: I started out editing the camera size so I should fit my ideal maze size, of course I could edit after but this just made it feel more organized. I then started planning the maze and how everything would be laid out as I was starting this level from scratch. With all of the leaf maze laid out I started adding enemies, then coins, then all other small details. Now that I was done with developing the first three levels(for now), I merged the development branch with the main.

Day 39: Minor updates for level 3 to add background and timer

Day 40: Added a moving platform and worked on making world 2 level 1 more complete. 

Day 41: Had a friend play test the game and made some updates from the feedback. This included making the levels a bit less frusturating and making some objects go to the background

Day 42: Worked on making it so you can fall through one way platforms

Day 43: Fixed one of the problems in w1-lvl2. I also added platforms in w1-lvl3 so its easier to get around becasue testers found the navigation to be infuriating. With these problems addressed, I began working on the enemy destruction problem. I decided to go with a gun sprite from another kenney asset pack.

Day 44: Added gun to sprite, made it have the ability to disappear, and made it look where the player does. I also added some other sprites like enemies, bullet, and bang.

Day 45: Added bullet scene and made the gun actually fire. The process of adding the working gun also included some extra player code and an enemies group in each level.

Day 46: I made the gun work properly, enemies have health, item boxes give you the gun, and I started using a global for arming the player. Globals also allowed me to make coins global, this way coins persist between levels.

Day 47: I added the game over screen and getting a life at 100 coins

Day 48: Added an invisible box for secrets. I added it to lvl 1 and added item boxes to lvl 2 and lvl 3

Day 49: I worked on making lives have a counter

Day 50: I finished the lives count and limited lives to 99, added walls to the ends of levels so you cant fall out where you are not intended, added a bullet counter that only appears when you have the weapon, and made coins disappear on game over.

Day 51: I worked on how sounds work and what sounds come from where. Biggest change was crusher enemies only making noise in an area

Day 52: I added a title screen to add a bit of a more complete feel to the game. In addition to these changes, I worked on w2-lvl1 and contemplated doing bosses

Day 53: Added a boss level layout and did some small fixes

Day 54: Added warp pipes and did some small fixes to make the game look better

Day 55: Made the player sink into pipes when they enter them. I also edited the boss and his level a bit, including adding a block that will keep you in during the boss fight.

Day 56-58: Coming up with ideas to make the boss fun and not overly complicated. My ideas spread from having the boss pop out of pipes and shoot at you, to having him run around and go through portals.
As of writing this, I'm going with the portals and have worked towards such.

# Tips, Tricks, and Advice

1. In Godot 4 to change cell size of a tilemap, you go to where it says tileset in the upper right corner and click the down arrow. From there click edit and the cell size should be there.
2. For anything you want to just follow the camera, use a canvas layer.
3. Use terrains for making levels and drawing maps. It is so much easier than placing each individual block
4. Using an animated sprite is easier than changing a sprite mid game.
5. For the way I respawn the character, using "owner" doesnt work very well and should be replaced with "get_tree().current_scene". This was found while making the gun
6. You can set the camera limits by clicking on the limit in the camera2d node. I know this sounds obvious, but it took me to long to realize and I dont want others to do the same.
7. A nice way to make enemies that bounce back and forth is to have two solid objects outside the camera border and have the enemy bounce back and forth between them. I did this with my bird enemies that are not on rails.
8. Dont rely on the tutorials entirely, you have to do your own learning and reading. If you dont, you just end up in a spiral of not knowing what is going on.
9. Read the freaking documentation. If you learn to read documentation it is going to be 100% more useful than any tutorial.
