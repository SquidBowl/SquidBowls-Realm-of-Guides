import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CodeState extends MusicBeatState {
    // vars
    var currentText:FlxText;
    var controlsText:FlxText;
    var pad:FlxSprite;
    var enteredCode:String = "";
    var buttonSprites:Array<FlxSprite>;
    var buttonDigits:Array<Int>;

    override public function create():Void {
        FlxG.mouse.visible = true; 
 
        pad = new FlxSprite().loadGraphic(Paths.image('code/pad'));
        pad.antialiasing = ClientPrefs.globalAntialiasing;
        pad.scale.set(1.25,1.25);
        add(pad);  

        super.create();
        CustomFadeTransition.nextCamera = FlxG.cameras.list[FlxG.cameras.list.length - 1]; 
        
        var numColumns:Int = 3;
        var numRows:Int = 4;
      
        // Calculate total button width and height with spacing
        var totalButtonWidth:Float = numColumns * (100 + 20) - 0; 
        var totalButtonHeight:Float = numRows * (100 + 20) - 160;
      
        // Calculate center coordinates considering total button dimensions
        var centerX:Float = FlxG.width / 2 - totalButtonWidth / 2;
        var centerY:Float = FlxG.height / 2 - totalButtonHeight / 2;
      
        var buttonWidth:Int = 100;
        var buttonHeight:Int = 80;
        var spacing:Int = 20; 
        
        buttonSprites = [];
        buttonDigits = [];

        for (i in 1...10) {
            var imageName:String = "BUTT" + i; 
            var imagePath:String = Paths.image('code/buttons/' + imageName).key; 
            var numSprite:FlxSprite = new FlxSprite(0, 0, imagePath); 
      
            var row:Int = Math.floor((i - 1) / numColumns);
            var col:Int = (i - 1) % numColumns;
      
            numSprite.x = centerX + col * (buttonWidth + spacing);
            numSprite.y = centerY + row * (buttonHeight + spacing) + 20; 

            buttonSprites.push(numSprite);
            buttonDigits.push(i % 10); 
            add(numSprite);
        }

        var imageName:String = "BUTT0"; 
        var imagePath:String = Paths.image('code/buttons/' + imageName).key; 
        var numSprite:FlxSprite = new FlxSprite(0, 0, imagePath); 
      
        numSprite.x = centerX + (numColumns - 1) * (buttonWidth + spacing) / 2;
        numSprite.y = centerY + totalButtonHeight - buttonHeight - spacing + 100;
      
        buttonSprites.push(numSprite);
        buttonDigits.push(0);
        add(numSprite);

        currentText = new FlxText(0, FlxG.height - 24, FlxG.width, '');
		currentText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		currentText.scrollFactor.set(0, 0);
		currentText.y = 120;
		add(currentText); 
        
        controlsText = new FlxText(0, FlxG.height - 24, FlxG.width, "PRESS B FOR BACKSAPCE\nACCEPT TO CONFIRM");
		controlsText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		controlsText.scrollFactor.set(0, 0);
		controlsText.y -= 20;
		add(controlsText);
    }
    
    function loadCode(){
        MusicBeatState.switchState(new MainMenuState());
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        
        for (i in 0...buttonSprites.length) {
            var buttonSprite:FlxSprite = buttonSprites[i];
    
            if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(buttonSprite)) {
                var digit:Int = buttonDigits[i];
        
                if (enteredCode.length < 4) {
                    enteredCode += Std.string(digit);
                    trace(enteredCode);
                }
            }
        }
        
        if (FlxG.keys.justPressed.B && enteredCode.length > 0) {
            enteredCode = enteredCode.substring(0, enteredCode.length - 1);
        }
        
        currentText.text = enteredCode;
        
        if (enteredCode == "2934") {
            currentText.color = FlxColor.GREEN;

            if (FlxG.keys.justPressed.ENTER) {
                loadCode();
            }
        } else {
            currentText.color = FlxColor.WHITE;
        }
        
        if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}
