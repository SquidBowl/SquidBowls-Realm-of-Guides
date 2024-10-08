# FNF Texture Atlas Guide
Sometimes, sprite sheets and XMLs just aren't cool enough.
The Ruby sprite showcased in this mod is unused in an actual mod, which is why I'm using it rather than the recent one. Still gets the point across!

After you've animated all your sprites in Adobe Animate and made symbols out of them, put the symbols in an “export” symbol, which is what you’ll eventually be right-clicking and exporting as a Texture Atlas.

You want to do something like this.

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/animationsymbol%20example.gif)

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/lineupexample.png)

After you’ve put your animations into 1 symbol like the image/above, usually by putting symbols into one symbol and making each animation have its respective frames before moving to the next, make the frames all into 1 symbol. You can now right-click the export symbol we just made, and export as a Texture Atlas.

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/all1symbol.png)

After clicking the button prompted above, it'll open the menu below. You’ll need to set an export path, which is where a folder named after the FLA by default will be exported. In this example the FLA is named "Ruby", meaning by default the folder name will be "Ruby"; The names of the files inside the folder aren't important.

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/exportmenu.png)

Open the folder and look inside. Inside should be 2 .json files, the important one being “Animation.json”, the other one (spritemap1.json) is necessary too but not usually needed to be opened unless you have a pathing issue with the image attached which shouldn't happen unless you manually break something past this point in the guide.

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/insidefolder.png)

Open “Animation.json” in Notepad or whatever program you use to read .json files, and look for a line like the one below. This is titled “Export/idle” because that is where the symbol is located in the FLA file. Which is the name of the symbol inside of that combined symbol (which I titled "thisisall1symbol") we made earlier. In my case, we will be copying the SN's name inside the quotation marks and red box.

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/insidejson.png)

When I copied the SN inside the Animations.json, I then pasted it into the “Animation Symbol Name/Tag”, and added/updated the animation. 

![](https://github.com/SquidBowl/FNF-Texture-Atlas-Guide/blob/main/images/charactereditor.png)

_____________________________________
## Pro's & Cons
While very neat and useful for optimizations due to the smaller sprites and controlled by the .json file, it can break a bit when flipped. The animations.json is made with the intention that the animation won’t be flipped, which will make the animation look bad, the solution to this is that, if your sprite is an opponent sprite, you’d ideally export it facing the right (towards Boyfriend ), and not the left (like how Boyfriend would be facing). So just keep that in mind when exporting Texture Atlas sprites. In addition to that, using an effect/overlay with transparency doesn't usually get taken into consideration when exporting as a texture. For example, if my Boyfriend sprite uses a color overlay for the misses, it won't export the the overlay with the opacity; the fix for this is pretty simple but may vary on the situation, so I'll leave that for you to find out.

## For your information
This is an Adobe Animate exclusive feature, meaning you need to animate with symbols and keyframes in the program, not just using Adobe Animate to export a sprite. 

The rotate tick box can be a bit wonky and doesn’t usually save too much space, as in my example the sprite is smaller than the canvas it was drawn on. Enabling rotate will just make it so parts of the sprite map/texture will rotate itself to make the exported image smaller and make it more compact, even if it’s a small amount. Again, doesn’t usually save that much and can be a bit unreliable on more complex sprites (for some reason Ruby’s sprite for her other poses was missing her entire face).

As far as I’m aware, the method of using texture atlas is primarily used in Blazin (Base game, weekend1, 4th song), and the [Boyfriend fakeout death sprite](https://github.com/FunkinCrew/funkin.assets/tree/b2404b6b1cba47da8eef4910f49985d54318186b/shared/images/characters/bfFakeOut). If you need a finished example of what to do, you can look there in the [“assets/shared/images/characters”](https://github.com/FunkinCrew/funkin.assets/tree/b2404b6b1cba47da8eef4910f49985d54318186b/shared/images/characters) folder.
