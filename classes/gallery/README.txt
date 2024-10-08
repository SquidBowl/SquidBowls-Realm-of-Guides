Welcome to using the GalleryState.hx (Commonly known as a "Class")
Asssuming you're a newbie at haxe, here's a step by step guide on how to set this baby up.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Beginning of Guide

0. Put the "GalleryState.hx" into your source folder. By default it should go into "sources/states/"

1. Drag and drop the "galley" folder you unzipped into wherever you store your images.
For example, since this Gallery is built on Psych 0.7.2, for us we'll be putting our foldr into ``assets/shared/images/``.

2. Drop your images into the "galley" folder. As long as they're within a 1280x720 size, they'll automatically be centered now as of Gallery v5.

3. Now, edit the provided Json file to your desire. 

4. Now, we need a way to actually open the state. Assuming you don't have a button already set up, let's put the function below into our 
update function in MainMenuState.hx

if (FlxG.keys.justPressed.O) {
    MusicBeatState.switchState(new GalleryState());
}

End of Guide
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Now, compile and press "O" in the Main Menu. You should now have your gallery open.

Do NOT post your issues in the comments. If you have an issue, contact me on Twitter instead and I'll answer quicker and more efficently.
https://twitter.com/SquidBowl_

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
