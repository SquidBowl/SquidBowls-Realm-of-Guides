package states;

import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Json;
import sys.io.File;

/*
 * HEY! I know you see this, CREDIT ME! IF YOU PUBLISH A MOD USING THIS SCRIPT OR EDIT IT IN ANY WAY, YOU HAVE TO CREDIT ME! NOT DOING SO WILL BE FOLLOWED BY A REPORT, TAKING DOWN YOUR MOD AND MAKING YOU LOOK LIKE
 * A CLOWN. SO PLEASE, JUST CREDIT MY GAMEBANANA, SAVES BOTH OF US TIME -> https://gamebanana.com/members/2041479
 */
class GalleryState extends MusicBeatState {
	// DATA STUFF
	var itemGroup:FlxTypedGroup<GalleryImage>;

	var imagePaths:Array<String>;
	var imageDescriptions:Array<String>;
	var imageTitle:Array<String>;
	var linkOpen:Array<String>;
	var descriptionText:FlxText;
	var imageData:Array<ImageData>;

	var currentIndex:Int = 0;
	var allowInputs:Bool = true;

	var uiGroup:FlxSpriteGroup;
	var hideUI:Bool = false;
	var intendedColor:FlxColor;
	var colorTween:FlxTween;

	// UI STUFF
	var imageSprite:FlxSprite;
	var background:FlxSprite;
	var titleText:FlxText;
	var backspace:FlxSprite;
	var hudTopBar:FlxSprite;
	var hudBottomBar:FlxSprite;

	// Customize the image path here
	var imagePath:String = "gallery/";

	override public function create():Void {
		var jsonData:String = File.getContent("assets/shared/images/gallery/gallery.json");
		imageData = haxe.Json.parse(jsonData);

		imagePaths = [];
		imageDescriptions = [];
		imageTitle = [];
		linkOpen = [];

		for (data in imageData) {
			imagePaths.push(data.path);
			imageDescriptions.push(data.description);
			imageTitle.push(data.title);
			linkOpen.push(data.link);
		}

		itemGroup = new FlxTypedGroup<GalleryImage>();
		uiGroup = new FlxSpriteGroup();

		for (i in 0...imagePaths.length) {
			var newItem = new GalleryImage();
			newItem.loadGraphic(Paths.image(imagePath + imagePaths[i]));
			newItem.antialiasing = ClientPrefs.data.antialiasing;
			newItem.screenCenter();
			newItem.ID = i;
			itemGroup.add(newItem);
		}

		background = new FlxSprite().loadGraphic(Paths.image("gallery/ui/background"));
		add(background);

		hudTopBar = new FlxSprite(0, 0);
		hudTopBar.makeGraphic(FlxG.width, 45, FlxColor.BLACK);

		hudBottomBar = new FlxSprite(0, FlxG.height - 45);
		hudBottomBar.makeGraphic(FlxG.width, 45, FlxColor.BLACK);

		uiGroup.add(hudTopBar);
		uiGroup.add(hudBottomBar);

		add(itemGroup);

		descriptionText = new FlxText(50, -100, FlxG.width - 100, imageDescriptions[currentIndex]);
		descriptionText.setFormat("vcr.ttf", 32, 0xffffff, "center");
		descriptionText.screenCenter();
		descriptionText.y += 275;
		uiGroup.add(descriptionText);

		titleText = new FlxText(50, -100, FlxG.width - 100, imageTitle[currentIndex]);
		titleText.screenCenter();
		titleText.setFormat(Paths.font("vcr.ttf"), 32, 0xffffff, "center");
		titleText.y -= 275;
		uiGroup.add(titleText);

		backspace = new FlxSprite(0, 560).loadGraphic(Paths.image("gallery/ui/exit"));
		uiGroup.add(backspace);

		add(uiGroup);

		persistentUpdate = true;
		changeSelection();

		if (imageData != null && imageData.length > currentIndex) {
			background.color = colorFromString(imageData[currentIndex].color);
			intendedColor = background.color;
		} else {
			trace("Error: imageData or currentIndex is invalid when setting background color.");
		}

		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if ((controls.UI_LEFT_P || controls.UI_RIGHT_P) && allowInputs) {
			changeSelection(controls.UI_LEFT_P ? -1 : 1);
			FlxG.sound.play(Paths.sound("scrollMenu"));
		}

		if (controls.BACK && allowInputs) {
			allowInputs = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
			FlxFlicker.flicker(backspace, 0.4, 0.10, false);
		}

		if (FlxG.keys.justPressed.X && !hideUI) {
			hideUI = true;
			FlxTween.tween(uiGroup, {alpha: 0}, 0.2, {ease: FlxEase.linear});
		} else if (FlxG.keys.justPressed.X && hideUI) {
			hideUI = false;
			FlxTween.tween(uiGroup, {alpha: 1}, 0.2, {ease: FlxEase.linear});
		}

		if (controls.ACCEPT && allowInputs)
			CoolUtil.browserLoad(linkOpen[currentIndex]);
	}

	private function changeSelection(i:Int = 0) {
		currentIndex = FlxMath.wrap(currentIndex + i, 0, imageTitle.length - 1);

		if (imageData != null && currentIndex >= 0 && currentIndex < imageData.length) {
			var newColor:FlxColor = colorFromString(imageData[currentIndex].color);

			if (newColor != intendedColor) {
				if (colorTween != null) {
					colorTween.cancel();
				}
				intendedColor = newColor;
				colorTween = FlxTween.color(background, 1, background.color, intendedColor, {
					onComplete: function(twn:FlxTween) {
						colorTween = null;
					}
				});
			}

			descriptionText.text = imageDescriptions[currentIndex];
			titleText.text = imageTitle[currentIndex];
		} else {
			trace("Error: imageData is null or invalid when trying to change selection.");
		}

		var change = 0;
		for (item in itemGroup) {
			item.posX = change++ - currentIndex;
			item.alpha = (item.ID == currentIndex) ? 1 : 0.6;
		}
	}

	function boundTo(value:Float, min:Float, max:Float):Float {
		if (Math.isNaN(value))
			return min;

		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}

	function colorFromString(color:String):FlxColor {
		var hideChars = ~/[\t\n\r]/;
		var color:String = hideChars.split(color).join('');
		color = StringTools.trim(color);

		if (color.substr(0, 2) == '0x')
			color = color.substring(color.length - 6);

		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
		if (colorNum == null)
			colorNum = FlxColor.fromString('#$color');
		return colorNum != null ? colorNum : FlxColor.WHITE;
	}
}

class GalleryImage extends FlxSprite {
	public var lerpSpeed:Float = 6;
	public var posX:Float = 0;

	override function update(elapsed:Float) {
		super.update(elapsed);
		x = GalleryState.boundTo(elapsed * lerpSpeed, 0, 1);
		x = FlxMath.lerp(x, (FlxG.width - width) / 2 + posX * 760, x);
	}
}

typedef ImageData = {
	path:String,
	description:String,
	title:String,
	link:String,
	color:String
}
