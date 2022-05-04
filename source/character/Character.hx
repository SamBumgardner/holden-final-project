/**
 * Character class
 *
 * Each character has a unique ability
 */

package character;

import bullet.Bullet;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import player.Player;

class Character extends Player
{
	// Which character and ID
	var character:String;

	// Ability variables
	private var abilityCooldown:FlxTimer = new FlxTimer();
	private var abilityCooldownLength:Int = 5;
	private var abilityReady:Bool;

	// Controller
	var gamepad:FlxGamepad;

	public function new(X:Float = 0, Y:Float = 0, chosenCharacter:String, playerId:Int = 0, playerBullets:FlxTypedGroup<Bullet>, playerGamepad:FlxGamepad)
	{
		// Assign chosen character and ID
		character = chosenCharacter;

		// Call super
		super(X, Y, playerBullets, playerId);

		// Assign gamepad
		gamepad = playerGamepad;

		// Start timer
		abilityCooldown.start(abilityCooldownLength, resetAbility, 1);

		if (character == "Don")
		{
			// Give graphic
			loadGraphic(AssetPaths.DonStanding__png, true, 20, 20);
			setFacingFlip(LEFT, true, false);
			setFacingFlip(RIGHT, false, false);

			// Animation
			animation.add("donStand", [0, 1], 2, true);
			animation.play("donStand");
		}
		if (character == "Liz") {}
		if (character == "Wes")
		{
			// Give graphic
			loadGraphic(AssetPaths.WesStanding__png, true, 20, 20);
			setFacingFlip(LEFT, true, false);
			setFacingFlip(RIGHT, false, false);

			// Animation
			animation.add("wesStand", [0, 1], 2, true);
			animation.play("wesStand");
		}
	}

	override public function update(elapsed:Float)
	{
		// If gamepad assigned
		if (gamepad != null)
		{
			// Call move function
			movePlayerGamepad(gamepad);
			// Call shoot function
			shoot(gamepad);
			// Call dash function
			dash(gamepad);

			// Call ability function
			if (character == "Don")
			{
				donAbility();
			}
			if (character == "Liz")
			{
				lizAbility();
			}
			if (character == "Wes")
			{
				wesAbility();
			}
		}

		// Call super
		super.update(elapsed);
	}

	private function resetAbility(timer:FlxTimer)
	{
		abilityReady = true;
	}

	public function isAbilityReady():Bool
	{
		return abilityReady;
	}

	private function donAbility()
	{
		if (abilityReady && gamepad.pressed.LEFT_SHOULDER)
		{
			// Reset cooldown timer
			abilityCooldown.start(abilityCooldownLength, resetAbility, 1);

			// Turn abilityReady to false
			abilityReady = false;
		}
	}

	private function lizAbility() {}

	private function wesAbility() {}
}