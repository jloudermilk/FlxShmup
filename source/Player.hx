package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;

class Player extends FlxSprite 
{
	public var speed:Float = 200;

	public function new (X:Float = 0,Y:Float = 0)
	{
		super(X,Y);
		loadGraphic(AssetPaths.player__png,true,32,32);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("neutral",[0],20,false);
		animation.add("strafe",[1],20,false);
		animation.add("neutralShoot",[2],20,false);
		animation.add("strafeShoot",[3],20,false);
		setSize(9,10);
		offset.set(11,11);
		drag.x = drag.y = 1600;
	}
	private function movement():Void
	{
		var _up:Bool = false;
 		var _down:Bool = false;
 		var _left:Bool = false;
 		var _right:Bool = false;
 		var _shoot:Bool = false;

 		_up = FlxG.keys.anyPressed(["UP", "W"]);
 		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
 		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
 		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);

		var mA:Float = 0; // our temporary angle
 		if (_up)  // the player is pressing UP
 		{
     		mA = -90; // set our angle to -90 (12 o'clock)
     		if (_left)
            {
         		mA -= 45; // if the player is also pressing LEFT, subtract 45 degrees from our angle - we're moving up and left
            facing = FlxObject.LEFT;
            }
     		else if (_right)
            {
         		mA += 45; // similarly, if the player is pressing RIGHT, add 45 degrees (up and right)
                facing = FlxObject.RIGHT;
            }
            else
            {
     		facing = FlxObject.UP; // the sprite should be facing UP
            }   
 		}
 		else if (_down) // the player is pressing DOWN
 		{
            mA = 90; // set our angle to 90 (6 o'clock)
     		if (_left)
            {
                mA += 45; // if the player is also pressing LEFT, subtract 45 degrees from our angle - we're moving up and left
            facing = FlxObject.LEFT;
            }
            else if (_right)
            {
                mA -= 45; // similarly, if the player is pressing RIGHT, add 45 degrees (up and right)
                facing = FlxObject.RIGHT;
            }
            else
            {
            facing = FlxObject.UP; // the sprite should be facing UP
            } 
 		}
 		else if (_left) // if the player is not pressing UP or DOWN, but they are pressing LEFT
 		{
     		mA = 180; // set our angle to 180 (9 o'clock)
     		facing = FlxObject.LEFT; // the sprite should be facing LEFT
 		}
 		else if (_right) // the player is not pressing UP, DOWN, or LEFT, and they ARE pressing RIGHT
 		{
     		mA = 0; // set our angle to 0 (3 o'clock)
     		facing = FlxObject.RIGHT; // set the sprite's facing to RIGHT
 		}
 		if (_up || _down || _left || _right)
 		{
 			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity); // determine our velocity based on angle and speed
     		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) // if the player is moving (velocity is not 0 for either axis), we need to change the animation to match their facing
			{
     			switch (facing)
     			{
         			case FlxObject.LEFT, FlxObject.RIGHT:
            			animation.play("strafe");
         			case FlxObject.UP:
             			animation.play("neutral");
     			}
  			}
  		}
        else
        {
            facing = FlxObject.UP;
            animation.play("neutral");
        }
  	}	
	

	override public function update():Void
	{

		movement();
		super.update();
	}
}