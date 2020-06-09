var/CHANGELOG = {"
	<!doctype html>
	<html lang="en">
	<head>
		<title>Changelog</title>

		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<!-- Bootstrap CSS -->
		<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous"> -->

		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

		<style>
			body {
				background-color: #474747;
				color: white;
				font-family: 'Open Sans', sans-serif;
			}

			a {
				color: #007bff;
				text-decoration: none;
			}

			a:hover {
				color: #0056b3;
				text-decoration: underline;
			}

			a:visited {
				color: #007bff;
				text-decoration: none;
			}
		</style>
	</head>

	<body>
		<h1>Changelog</h1>
		All notable changes to this project will be documented in this file.

		The format is based on <a href="https://keepachangelog.com/en/1.0.0/">Keep a Changelog</a>, and this project adheres to <a href="https://semver.org/spec/v2.0.0.html">Semantic Versioning</a>.

		<br />

		<h2>\[Unreleased]</h2>
		<h3>Changed</h3>
		<ul>
			<li>Update changelog format.</li>
			<li>Tweak damage overlay animation.</li>
			<li>Damage overlays now have an outline.</li>
		</ul>

		<h3>Fixed</h3>

		<ul>
			<li>
				Optimize Server Functions. \[<a href="https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/issues/1">#1</a>]
				<ul>
					<li>Damage overlays now have an outline. \[<a href="https://git.douglas-parker.com/Lavenblade/Project-Evolution/-/commit/d1529b114bc8a46316c6b41db2d31d408776744c">d1529b11</a>]</li>
				</ul>
			</li>
		</ul>

		<span><i>
			It is with great sadness that I have to announce that almost 10 years of credits and attributions owed to previous developers has been lost due to unforeseen circumstances.

			<br /><br />

			Please read the very bottom of the <a href="?changelog=previous">previous changelog</a> for more information.
		</i></span>

		<!-- Optional JavaScript -->
		<!-- jQuery first, then Popper.js, then Bootstrap JS -->
		<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
		<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
		<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script> -->
	</body>
	</html>
"}

var/const/CHANGELOG_PREVIOUS = {"
	<html>
	<head>
	<title>Updates</title>
		<style>
			body {
				background-color: '#000000';
				color: '#ffffff'
			}
		</style>
	</head>
	<body>
	<center>
	<p>Check in here to see what's been updated.</p>
	<hr>
	<h3>1.3.9</h3>
	<br>-Village kills before boot increased from 3 to 5.

	<br><hr><br>
	<h3>1.3.8</h3>
	<br>-Explosive kunais will no longer auto-use(v)
	<br>-Removed an unnecessary Inventory Refresh from Throw(S) verb.
	<br>-Mastery scrolls will no longer level Transform past 3.(V)
	<br>-Mud river will no longer activate without a target.
	<br>-Doryuusou will no longer activate without a target.
	<br>-Jubaku eisou will no longer activate without a target
	<br>-Sand coffin will no longer activate without a target.
	<br>-Sand funeral will no longer activate without a target.
	<br>-Ink snakes will no longer activate without a target.
	<br>-Bone sensation will now remove the bullet properly when used.(V)
	<br>-Fixed root strangle.
	<br>-Root strangle's bind time is now based on the jutsu's level.
	<br>-C ranks now give 8xp.
	<br>-Removed Test mission.

	<br><hr><br>
	<h3>1.3.7</h3>
	<br>-Colored clothing works properly again. (Reformist)
	<br>-Walking on water will now raise Ninjutsu.
	<br>-Swimming will now raise Agility.
	<br>-Climbing mountains str training minor adjustment.
	<br>-Walking on water will now have a water ring icon.
	<br>-Water ring location adjustment.
	<br>-Fixed adv subbing out of water.
	<br>-Fixed adv subbing into water.
	<br>-Fixed adv subbing from water to water.
	<br>-Fixed adv subbing from water to water after switching chakra control.
	<br>-Fixed water walking exp gain after logging out on water.
	<br>-Reduced Ice mirror's cooldown.
	<br>-Village killing in the chuunin exam will no longer kick you from your village.
	<br>-Increased Crystal explosion's bind time.
	<br>-Decreased Crystal explosion's self bind time.
	<br>-Fixed water prison level 2.
	<br>-Fixed endless transform.
	<br>-Slightly increased Sage rasengan's cooldown.
	<br>-Updated tutorial to mention swimming, mountain climbing, and water walking.

	<br><hr><br>
	<h3>1.3.6</h3>
	<br>-Changed water clones from walk_towards back to step_towards.
	<br>-Adv subbing water prison will no longer keep you stuck.
	<br>-Adv subbing water clone's prison will no longer keep you stuck.
	<br>-Kazekage puppet now moves as fast as other summons.
	<br>-Fixed Shikigami spear's cooldown.
	<br>-Arrow task timer on Rasengan is shorter.
	<br>-Arrow task timer on Sage Rasengan is shorter.
	<br>-Arrow task timer on Rasenshuriken is shorter.
	<br>-Tab targeting in the arena will no longer target players watching.
	<br>-You can no longer /stuck out of the chuunin exam while it's running.
	<br>-You can no longer arena challenge people in the chuunin exam.
	<br>-Readded /Boot.
	<br>-/Boot will only show players who are Afk.
	<br>-You can now only squad with people in your village.
	<br>-Removed Mist, Sound, and Rock from starting village list.
	<br>-Removed 7sm and Anbu root from Org promotion list.
	<br>-Removed Mist, Sound, and Rock from Kage promotion list.
	<br>-Fixed Demote Anbu.
	<br>-Added Jutsu mastery scrolls(Needs testing before release).
	<br>-Clothing is no longer colorable.

	<br><hr><br>
	<h3>1.3.5</h3>
	<br>-New Paper Chakram. (Blair)
	<br>-New Paper Spear. (Blair)
	<br>-New Pale skin tone. (Blair)
	<br>-Fixed Blue and Dark skin tones. (Blair)
	<br>-Fixed a typo causing an error message.
	<br>-Fixed a bug causing Otokage to not retain verbs.
	<br>-Relogging now fixes mission bug(Although mission bug shouldn't be happening still).
	<br>-Fixed a typo: Sheild : Shield.
	<br>-Fixed a small mapping issue.
	<br>-VesaiRoot will now show the picture when picking up the mission.
	<br>-Changed squads so you have to be chuunin+ to invite others to your squad.
	<br>-Killing your fellow villagers now takes 50% of your xp.
	<br>-Killing 3 of your fellow villagers now boots you from the village.
	<br>-Mist now counts as a water source.
	<br>-Slowed Water clone's movement.
	<br>-Water clone will no longer die from bumping into players.
	<br>-Water clone will no longer die from bumping into walls.
	<br>-Water clones will no longer run after non-player mobs(Didn't bind nonplayers anyway).
	<br>-Water clones will now have only 100 hp.
	<br>-Dragon heads will now show on top of their body.
	<br>-Fixed Chidori Nagashi.
	<br>-Fixed Wind Tornados(Currently only makes 1 tornado).
	<br>-Chidori at max level will require 1 arrow task.
	<br>-Raikiri at max level will require 2 arrow tasks.
	<br>-Rasengan at max level will require 1 arrow task.
	<br>-Sage Rasengan at max level will require 1 arrow task.
	<br>-Rasenshuriken at max level will require 2 arrow tasks.
	<br>-Camellia Dance will no longer try to level passed 4.
	<br>-Kage verbs will now only list people in your village(or missing nin for invite).
	<br>-Hosts can now define themselves as admin with a text file the game creates when ran for the first time.

	<br><hr><br>
	<h3>1.3.4</h3>
	<br>-Optimized Warp linking (Reformist)
	<br>-Fixed an issue caused by failed login attempts (Reformist)
	<br>-Fixed links in the hub/discord message (Reformist)
	<br>-Fixed a map warp issue where walking south on a maxx warp would put you on the wrong side of the map (Reformist)
	<br>-You can no longer equip and drop an item at the same time (Reformist)
	<br>-Removed a repeat in the kill log.
	<br>-Fixed intang.
	<br>-Killing clones with bone drill will no longer stick player.
	<br>-Bone pulse can once again be used without a target.
	<br>-Minor simplification of 64 palms jutsu level check.
	<br>-64 palms now requires jutsu lvl 4 for the full 64 palms.
	<br>-You can no longer sub out of 64 palms(you can still adv sub out).
	<br>-Admins can now read the error log from in game.
	<br>-WorldXp will now save through reboots.(v)
	<br>-Removed test verbs.
	<br>-C rank mission objects will no longer get stuck in your inv.
	<br>-Weeds mission will now ask for you to grab 4-7 weeds.
	<br>-Check mission will now tell you the time left to your next mission.
	<br>-Fixed multi-squad bug.

	<br><hr><br>
	<h3>1.3.3</h3>
	<br>-New Screen shake proc (Reformist)(Not fully implemented).
	<br>-Added a failsafe for using dimension without a Previous location.
	<br>-Small Raikiri nerf.
	<br>-Puppet jutsus will no longer activate cooldown/chakra cost for deactivating.
	<br>-Moving puppets during puppet bind will end the bind.
	<br>-Fixed an issue where dying in Dojo would get you stuck.
	<br>-Nerfed Puppet bind.
	<br>-Increased Puppet Transform's cooldown.
	<br>-Attacking with henged puppets will no longer make them invisible.
	<br>-Henged puppets now have icon states for attacking and binding.
	<br>-Reduced screen shake on Water sharks, Rasengan, Sage Rasengan, Chidori, and Being pushed into walls.
	<br>-Reduced screen shake on Rasenshuriken, Susanoo hit, Rotation, AP(Still shakes a lot).

	<br><hr><br>
	<h3>1.3.2</h3>
	<br>-Fixed an issue with logging out during specific binds(Reformist).
	<br>-Fixed Insect cocoon's icon.
	<br>-Reduced Byakugan's cooldown.
	<br>-Fixed an issue with paper bind's timer.
	<br>-Logging out while picking a mission will no longer bug your missions.
	<br>-Fixed an issue with adv subbing while intang.
	<br>-Fixed an issue where binding someone who is intang would allow them to attack after.
	<br>-Fixed 64 palms.
	<br>-Fixed a variety of jutsus handseals not resetting.
	<br>-Added Handseal used jutsus to garbage collection.
	<br>-Added a small chakra cost to Bone tip.
	<br>-Added a small chakra cost to Bone sensation.
	<br>-Fixed a bug causing ice mirrors to have no cooldown.
	<br>-Fixed an issue stopping players from picking up a mission.

	<br><hr><br>
	<h3>1.3.1</h3>
	<br>-Fixed a typo causing jutsus to say 800 uses.
	<br>-Fixed a typo stopping the discord link from working.
	<br>-Fixed pushing out of binds and sand shield.
	<br>-Fixed an issue with hotkeying after 80 uses.
	<br>-Fixed byakugan's chakra drain.
	<br>-Ice mirrors will no longer activate without water nearby.
	<br>-Sensatsu suisho will no longer activate without water nearby.
	<br>-Sensatsu suisho will no longer activate without a target.
	<br>-Npcs will no longer show up on Arena challenge list.
	<br>-Fixed maploadspawn for exiting jail, arena battle logout end,
	<br>-Human boulder can no longer go indoors.
	<br>-Fixed Flicker/Flying thunder god in arena.
	<br>-Arena fights ended by logging will now properly send to village home.
	<br>-Killing a controlled clone will no longer stick the controller.

	<br><hr><br>
	<h3>1.3.0</h3>
	<br>-Implemented a new save system (Reformist).
	<br>-Hair now updates properly after using the barber (Reformist).
	<br>-Health and chakra overhead bars appear properly on login (Reformist).
	<br>-Fixed a resolution rounding issue (Reformist).
	<br>-New Spider Arrow icon (Jay).
	<br>-New fog in mist (Blair).
	<br>-New Tutorial!
	<br>-Added Dark and Blue Skin tones!
	<br>-Major code cleanup.
	<br>-Jutsu uses to master lowered from 100 to 80.
	<br>-Bald hair will no longer ask for a hair color.
	<br>-Arena challenges now happen in the leaf village arena.
	<br>-Arena challenges can now be watched.
	<br>-People in the arena can't attack people watching the arena.
	<br>-Added a discord link to the hub advert.
	<br>-Handseals should feel slightly more responsive.
	<br>-Advanced sub now resets a variable that effects doing jutsus.
	<br>-Updated the xp lock text.
	<br>-Kazekage puppet can now kill.
	<br>-Kazekage puppet hits slightly faster.
	<br>-Summon spider can now kill.
	<br>-Summon spider hits slightly faster.
	<br>-Summon snake can now kill.
	<br>-Limb paralyze seal now levels up faster.
	<br>-Seal of terror now levels up faster.
	<br>-Soul devastator seal now levels up faster.
	<br>-You can no longer dimension out of jail.
	<br>-You can no longer dimension others out of jail.
	<br>-You can no longer dimension during a duel.
	<br>-Intang can no longer be used in a duel or the dimension.
	<br>-Fixed some typos in arena texts.
	<br>-Byakugan no longer gives exp.
	<br>-Sharingan no longer gives exp.
	<br>-Gates cooldown is shorter.
	<br>-Updated password creation text(Passwords are now hashed and unreadable by admins or the host).
	<br>-Using Blind no longer turns you invisible.
	<br>-Bug Neurotoxin will no longer activate without a target.
	<br>-Insect Coccoon is now Insect Cocoon.
	<br>-Insect Cocoon can be turned off while on cooldown/without chakra.
	<br>-Stealth bug will no longer activate without a target.
	<br>-Magma cage will no longer activate without a target.
	<br>-Raised Akat min level to 50.
	<br>-Raised 7sm min level to 40.
	<br>-Added min level to Anbu Root(30).
	<br>-Removed a repeated world proc.
	<br>-Closed the gap between chatbox and chat input.
	<br>-Burn will now output kill text.(v)
	<br>-Inventory size has been increased from 20 to 25.
	<br>-Fixed Jutsu cooldown slot location.
	<br>-Fixed Jutsu hotkey locations.
	<br>-Gates now take less health to activate but more health over time.
	<br>-Ones own life reincarnation and Rinn rebirth now use the new damage proc.
	<br>-Fixed Shikigami dance.
	<br>-Ash pile no longer lags the game.
	<br>-Jashin immortality will no longer put you to 1hp.
	<br>-Sacrifice to Jashin will now tell you when your immortality is gone.
	<br>-Sacrifice to Jashin's immortality length nerf.
	<br>-Immortal cooldown increase.
	<br>-Immortal immortality time increase.
	<br>-Fixed some incorrect text in Immortality counter.
	<br>-Changed Demon windmill's handsigns.
	<br>-ShadowClone is now macroable.
	<br>-Shadow bind small buff.
	<br>-Shadow stab small buff.
	<br>-Shadow choke buff.
	<br>-Shadow explosion small buff.
	<br>-Susanoo is no longer targettable.
	<br>-C2 dragon is no longer targettable.
	<br>-Amaterasu now burns slower.
	<br>-Tsukuyomi bind time nerf.
	<br>-Can no longer push people out of earth cage or magma crush.
	<br>-Can no longer push people out of sand shield.
	<br>-Can no longer Chakra release water prison or Shadow bind.(v)
	<br>-Killing clones will no longer cause stuck players or icons.(v)
	<br>-Genjutsu now effects Nirvana bind time.
	<br>-Replaced trees in event with normal trees.
	<br>-Fixed sand's punch blocking(blocks more against low agi and less against high agi).
	<br>-Added text to Puppet transform.
	<br>-Puppet grab will no longer activate if the bind is missed.
	<br>-Removed Village Levels.
	<br>-You now get a choice in missions when selecting D rank.
	<br>-Completing a mission will no longer bug other squad member's missions.
	<br>-You will no longer lose xp over the max when leveling up.
	<br>-You will no longer lose xp over the max when leveling stats.
	<br>-You will no longer lose xp over the max when leveling jutsus.
	<br>-Susanoo will once again attack all mobs(including clones).
	<br>-Fixed Byakugan's chakra drain.
	<br>-B, A, and S rank missions now give stat xp like D and C do.
	<br>-Added a Test mission. It gives nothing and is for dev use only.
	<br>-64 Palms cooldown increase.
	<br>-64 Palms chakra cost increase.
	<br>-64 Palms will now properly bind.(v)
	<br>-64 Palms will now use the correct damage procs.
	<br>-64 Palms will no longer set target chakra to 0.
	<br>-64 Palms chakra damage now scales with Nin.
	<br>-Adv subbing out of rotation now ends the rotation.
	<br>-Eight gates assault cooldown increase.
	<br>-Ice Mirrors will now use the correct damage procs.
	<br>-Sage mode chakra cost lowered.
	<br>-Curse Seal chakra cost lowered.
	<br>-Rasengan and warp rasengan chakra cost switched.
	<br>-Blind chakra cost increase.
	<br>-Body derangement chakra cost increase.
	<br>-Changed first puppet summoning's handsigns.
	<br>-Binding shadow clones no longer makes them faster.
	<br>-Reduced wait time after throwing Shukakku spear.
	<br>-Small Weights xp buff.
	<br>-7sm swords no longer get stuck on player from leaving the 7sm while sword is equiped.
	<br>-Reduced time it takes for Phoenix flower to begin firing.
	<br>-Intang now avoids all damage, including chakra dmg and heals.
	<br>-Scattered more weeds around villages.
	<br>-Added I, O, and P to the controls list shown at login.
	<br>-Edited Bug reports so they're easier to read.
	<br>-C ranks are temporarily unavailable to players(Being fixed).
	<br>-Wiped characters for new save system, skin tones, and tutorial.

	<br><hr><br>
	<h3>1.2.6</h3>
	<br>-Shadow fist is now use-able outside of Nara bind.
	<br>-Shikigami spear nerf.
	<br>-Removed ability to click on Leaf Gate(Bugged layers).
	<br>-Made changes to a jutsu unavailable to players.
	<br>-Almighty Push slight buff.
	<br>-Byakugan chakra drain fixed.
	<br>-Sharingan chakra drain is now .2 seconds slower.
	<br>-Dark swamp's self bind is now shorter.
	<br>-Sand Funeral base damage buff.
	<br>-Spider Arrow buff.
	<br>-Fixed untargeted Spider Arrow direction.
	<br>-Fixed the Cancel on Stat_Boost(admin verb)
	<br>-Ice Mirrors cooldown increase.
	<br>-Reduced chakra cost of Fire Mask.
	<br>-Reduced chakra cost of Wind Mask.
	<br>-Reduced chakra cost of Earth Mask.
	<br>-Reduced chakra cost of Lightning Mask.
	<br>-Kakuzu jutsu cooldowns now match the jutsu they use.
	<br>-Closed gap between chatbox and bottom bar.
	<br>-Puppets punch damage now scales with owners Tai.
	<br>-Puppets will no longer go invisible if hit with a bind.
	<br>-Minor fix in Kill log.
	<br>-C2 will output kill text.
	<br>-Susanoo can now kill.
	<br>-Susanoo will now output kill text.
	<br>-C3 can now kill.
	<br>-C3 will output kill text.
	<br>-Crystal explosion can now kill.
	<br>-Crystal explosion will now output kill text.
	<br>-Seal of error will no longer activate without target.
	<br>-Limb paralyze seal will no longer activate without target.
	<br>-Soul devastator seal will no longer activate without target.
	<br>-Reaper death seal will no longer activate without target.
	<br>-Water clone will no longer activate without water nearby.
	<br>-Water prison will no longer activate without water nearby.
	<br>-Water shark will no longer activate without water nearby.
	<br>-Water dragon will no longer activate without water nearby.

	<br><hr><br>
	<h3>1.2.5</h3>
	<br>-Fixed missing tray icon.
	<br>-Fixed Sound bed in Sand hospital.
	<br>-Fixed typo in Kage rules.
	<br>-Chuunin Autopass is now level 25.
	<br>-Updated character creation text for Speciality
	<br>-Updated character creation text for Clan selection.
	<br>-Snake sub no longer goes between maps.
	<br>-Crow sub no longer goes between maps.
	<br>-Remove xp lock will no longer give numbers less than 4 digits.
	<br>-Sage Rasengan requires less arrow presses at higher jutsu levels.
	<br>-Rasenshuriken requires less arrow presses at higher jutsu levels.
	<br>-Rasengan requires less arrow presses at higher jutsu levels.
	<br>-Rasengan no longer needs arrows at level 4.
	<br>-Chidori requires less arrow presses at higher jutsu levels.
	<br>-Chidori no longer needs arrows at level 4.
	<br>-Raikiri requires less arrow presses at higher jutsu levels.
	<br>-Small Raikiri buff.
	<br>-Rinnegan cooldown increase(to avoid output spam).
	<br>-Susanoo's jutsu level now effects it's damage.
	<br>-Susanoo nerf.

	<br><hr><br>
	<h3>1.2.4</h3>
	<br>-Players under level 30 can no longer join Akat or 7sm.
	<br>-Removed multiserver code.
	<br>-Fixed White Zetsus AI after a death.
	<br>-Zetsu will no longer attack 7sm.
	<br>-Added White zetsus to half of the Ally war area.
	<br>-White zetsus respawn one minute after being killed.
	<br>-Added Anbu Root and Seven Swordsmen to war events.
	<br>-Put Event verbs on their own tab.
	<br>-Nirvana fist is now Body Pathway Derangement.
	<br>-Buffed damage done by Pathway Derangement.
	<br>-Nerfed bind time of Pathway Derangement.
	<br>-Pathway Derangement's damage is now solely Tai based(Bind time is still nin).
	<br>-Switched Sage rasengan and sage snake's requirements.
	<br>-Sage rasengan no longer needs arrows at level 4.
	<br>-Sage rasengan buff.
	<br>-Rasenshuriken no longer needs arrows at level 4.
	<br>-Rasenshuriken buff.
	<br>-Fixed minor screen issue.
	<br>-Fixed a squad leader dupe bug.
	<br>-Fixed six person squad bug.
	<br>-Centered Option panel buttons.
	<br>-Moves Remove Exp lock button to bottom skill bar.
	<br>-Seperated some text from the error log.
	<br>-Slight resize of option panel and Kage panel.
	<br>-Moved the statpanel slightly left.
	<br>-Fixed some minor event texts.
	<br>-Fixed Chidori Needle's exp.

	<br><hr><br>
	<h3>1.2.3</h3>
	<br>-Bug clone now takes less health and chakra.
	<br>-Snake and crow sub now remove target like other substitutes.
	<br>-Intang people can no longer go through doors.
	<br>-Bug tornado no longer travels further if you're not targetting.
	<br>-Bug tornado no longer has multiple damage procs.
	<br>-Bug tornado moves faster but doesn't stay as long.
	<br>-Bug tornado now has a new damage calc(Nin and Tai).
	<br>-Intang now has a cooldown before using jutsus, when exiting intang.
	<br>-Warp dimension now puts the user and target at a distance.
	<br>-Dimension is slightly larger.
	<br>-Burn effects now happen faster.
	<br>-Burn effects damage nerf.
	<br>-Chidori Needles now gives Nin exp on hit.
	<br>-Sickling Weasel Slash now gives Nin exp on hit.
	<br>-Nirvana Fist(now Body Derangement) now uses ninjutsu for the bind duration.

	<br><hr><br>
	<h3>1.2.2</h3>
	<br>-You can no longer use dimension in Chuunin exam.
	<br>-Fixed a mapping issue in the leaf village.
	<br>-Fixed a mapping issue in the mist village.
	<br>-Added a minute to the FoD part of the chuunin exam.
	<br>-Kazekage puppet and snake summon now delete on logout.
	<br>-Moved Z1 to Z18(Mapping).
	<br>-Made mapping adjustments to Z1.
	<br>-New Staff verb for teleporting to locations(instead of just players).
	<br>-Kamui nerf.
	<br>-Tsukuyomi nerf.
	<br>-Amaterasu nerf.
	<br>-Fixed Giveeverything verb.
	<br>-Fixed WorldXp verb.
	<br>-Fixed leaf spawn locations to the correct Z.
	<br>-Fixed Sand hospital.
	<br>-Fixed Reaper Death Seal's user damage.
	<br>-Water Clone will now only take 1/4th hp and chakra instead of half.
	<br>-Fixed Nara(Non-nara jutsus can now be used after the bind is over).

	<br><hr><br>
	<h3>1.2.1</h3>
	<br>-Fixed Rock Village Text color.
	<br>-Fixed a mapping issue at the sound hospital.
	<br>-Fixed the Genin exams in sound and rock.
	<br>-Added signs inside of the shops to show which npc is which.
	<br>-Removed (v) from updates that have been verified.
	<br>-Removed xp gain from Rinnegan.
	<br>-Fixed logs in Rock village.
	<br>-Warp Dimension no longer leaves an icon in the dimension.
	<br>-Fixed an issue with Intang requiring chakra to turn off.
	<br>-Jutsus that hit through intang will no longer do damage(Water wave, punching, etc.).
	<br>-Re-fixed the client bug.

	<br><hr><br>

	<h3>1.2.0</h3>
	<br>-Major code cleanup.
	<br>-Added Rinnegan as a NonClan.
	<br>-Nerfed Almighty Push.
	<br>-Nerfed Snake Summoning.
	<br>-Moved Push and Pull to Rinnegan Nonclan.
	<br>-Moved Chakra Leech to Rinnegan Nonclan.
	<br>-Added cooldowns to Rinn jutsus.
	<br>-Logout now removes Anbu Suit if not in Anbu Root.
	<br>-If you go Rinnegan Nonclan you can't purchase Sage Mode or Curse Seal.
	<br>-If you go Gates Nonclan you can't purchase Sage Mode or Curse Seal
	<br>-Akatsuki now lose their hat if they leave the Akatsuki.
	<br>-Moved around jutsus on the skill trees. NonClan Clans are now all in Clan2(except Gates and Rinnegan which are still in Nonclan).
	<br>-Moved NonClan jutsus around so it's easier to understand requirements.
	<br>-Added back Uzumaki clan(old Sealing clan).
	<br>-Nerfed Reaper Death Seal.
	<br>-Nerfed Seal of Terror.
	<br>-Buffed Soul Devastator Seal.
	<br>-Fixed an issue where buying rinnegan didn't give you the jutsu.
	<br>-Added Crow sub.
	<br>-Added Snake sub.
	<br>-Added Sage Snake.
	<br>-Crow Sub, Snake Sub, and Sage: Giant Snake are now macroable.
	<br>-Made it so you need to be a tai(strength) specialist for Curse Mark.
	<br>-Made it so you need to be a ninjutsu specialist for Sage Mode.
	<br>-Rinnegan nonclan now requires you to be Balanced speciality.
	<br>-Gates nonclan now requires you to be Strength speciality.
	<br>-Nirvana Fist now requires you to be Strength speciality.
	<br>-Crow clones, crow sub, Tree Binding Death, Nirvana, and Blind now require you to be Genjutsu speciality.
	<br>-Removed the second Speciliality for nonclan users.
	<br>-There is now feedback when you try to buy a jutsu you aren't able to buy.
	<br>-Added Skillpoint costs to Uzumaki.
	<br>-Capped Stats at 150(Not that anyone generally makes it that far(without abuse)).
	<br>-Nerfed Magma Crush and Magma Needles' chakra costs and cooldowns.
	<br>-Nerfed Magma Needles.
	<br>-Added Magma Crush and Magma Needles to Fire element.
	<br>-Fixed some Earth element jutsu requirements.
	<br>-Added Lightning Ball Jutsu(Using an un-used icon).
	<br>-Fixed some opacity issues with jutsu icons.
	<br>-Fixed the What's New list.
	<br>-Minor edit to Edit verb.
	<br>-Adjusted part of the Chuunin exam prompt.
	<br>-Changed the frequency of Automatic Afk checks.
	<br>-Adjusted the rule list.
	<br>-Adjusted the update list.
	<br>-Adjusted the kill log.
	<br>-Summon Spider can now kill.
	<br>-Adjusted cooldowns and requirements on Crow sub.
	<br>-Adjusted cooldowns and requirements on Snake sub.
	<br>-Adjusted cooldowns and requirements on Sage snake.
	<br>-Put limits on Crow sub and Snake sub's distance.
	<br>-Nerfed Sage Snake.
	<br>-Nerfed Bone sword.
	<br>-Nerfed Gates.
	<br>-Fixed it so Jutsus you can't buy because of their Speciality are greyed out.
	<br>-Re-Added Dark Sword.
	<br>-Fixed damage done by hitting with Weights on.
	<br>-Executioners blade now does the same damage as the other 7sm blades.
	<br>-7sm blades now get removed from players upon leaving or being kicked from 7sm.
	<br>-7sm blades are now re-distributable after losing that member.
	<br>-Fixed some wording on S rank missions.
	<br>-Intangability now takes chakra over time and is toggle-able(Like Byakugan or Sharingan).
	<br>-Complete rework of Warp Dimension.
	<br>-Changed the icon for Warp Dimension.
	<br>-Changed the icon for Intangible.
	<br>-Implanted Sharingan is a new Non Clan.
	<br>-Kamui and Sharingan Copy are now Implant jutsu.
	<br>-Warp Dimension and Intangible are now in the Implanted nonclan.
	<br>-Kamui and Sharingan Copy no longer requires Sharingan to be active.
	<br>-Small Tsukuyomi buff.
	<br>-Small Amaterasu buff.
	<br>-Possible fix for Chidori Nagashi.
	<br>-Possible fix for Wind Tornados.
	<br>-Rasengan, Sage Rasengan, and Rasenshuriken arrows and timer are faster.
	<br>-New icon for Sage Rasengan.
	<br>-Increased the health of Logs.
	<br>-Removed pushing from Clones.
	<br>-Buffed Kamui.
	<br>-Buffed Amaterasu and Tsukuyomi.
	<br>-Added kaguya robes to the clothing shop.
	<br>-Added half masks to the clothing shop.
	<br>-Robe layer was fixed to be under hats.
	<br>-Anbu root leader now gets a different colored mask.
	<br>-Fixed a mapping issue.
	<br>-Fixed the map for Tsukuyomi.
	<br>-Clones no longer punch faster than the user.
	<br>-Reduced the map from 10 connected outside maps to 7.
	<br>-Moved map connecters around to condense map.
	<br>-Moved around some buildings in Mist.
	<br>-Adjusted maps around mist to match the ground.
	<br>-Adjusted maps around sand to match the ground.
	<br>-Moved Missing nin spawn slightly closer to the middle of the world map.
	<br>-Re-Added Rock Village.
	<br>-Re-Added Sound Village.
	<br>-Re-mapped Rock and Sound villages.
	<br>-Added sensory ninja to sound.
	<br>-Created and added new Rock Secretary.
	<br>-Created and added new Rock Sensory.
	<br>-Remapped Rock and sound's recievers and senders.
	<br>-Moved Akatsuki entrance.
	<br>-Each village now has a different colored headband.
	<br>-Each village now has a different colored Anbu mask.
	<br>-New hand drawn Sound HUD symbol.
	<br>-New hand drawn Rock HUD symbol.
	<br>-Updated Welcome message.
	<br>-You can no longer intang out of Jail.
	<br>-Moved Test jutsus so they're not accessible with intang.
	<br>-Moved Shop items so they're not accessible with intang.
	<br>-Each village sign says something unique.
	<br>-New {Redacted} Jutsu(Incomplete).
	<br>-Added {Redacted}(Broken).
	<br>-Removed a couple updates that didn't work properly.
	<br>-Fixed a handful of bugs created by these updates.
	<br>-Wiped Characters. Reason: Push/Pull/Leech, Gates incompatibility with Sage/Curse, Jutsu adjustments, New Clans.

	<br><hr><br>
	<h3>1.1.9</h3>
	<br>-Fixed broken layers(Mainly arrows).
	<br>-Aligned 7sm HUD icon.
	<br>-Fixed leaf hospital.
	<br>-Fixed all Dojo respawns.
	<br>-Killing yourself in a dojo will remove you from the dojo, but will not give you xp.
	<br>-Made some adjustments to the Admin Hideout.
	<br>-Reduced Chakra Leech's cooldown.
	<br>-Fixed Auto chuunin exam.
	<br>-Chuunin exams now tell you they'll begin in 5 minutes(instead of "shortly").
	<br>-Chuunin exams will no longer put you in walls in the FoD.
	<br>-Fixed the skillpoints spot on the Statpanel.
	<br>-Reverted Retire(Retire should work, but retiring to people outside of your village may be possible again).
	<br>-Akatsuki and 7sm can no longer do S rank missions.
	<br>-Fixed "Unknown Rank" in the bingo book.
	<br>-Removed Snake Stab from the skill tree.
	<br>-Slight increase to Ice Mirror's cooldown.
	<br>-Buffed xp gain from a variety of Genjutsu techniques.
	<br>-Buffed xp gain from a variety of Ninjutsu techniques.
	<br>-Bone drill is now easier to master.
	<br>-Dance of the Kaguya nerf.
	<br>-Bone Drill slight nerf.
	<br>-Bone Pulse damage boost, cooldown increase, and slight chakra cost increase.
	<br>-Reduced Amaterasu chakra cost.
	<br>-Teppoudama is easier to master.
	<br>-Susanoo is easier to master.
	<br>-Jashin blood circle will no longer activate cooldown if it misses.
	<br>-Slight nerf to Tree Bind.
	<br>-Slight buff to Paper Chakram and slight increase to cooldown(more damage during wings).
	<br>-Buffed Shikigami Spear and reduced cooldown(can move immediately after using during wings).
	<br>-Buffed Shikigami Dance and large increase to cooldown(bind lasts longer during wings).
	<br>-Slight buff to Angel Wings duration(read your jutsus when you're buying them).
	<br>-Nerf to Last Resort's chakra damage.
	<br>-Slight increase to Last Resort's cooldown.
	<br>-Empty Palm now costs chakra.
	<br>-Slight increase to 64 Palms cooldown.
	<br>-Fixed Minor mapping issue in sand.
	<br>-Deleted eight jutsus, that didn't do anything, from code.
	<br>-Nerfed Crystal shards.
	<br>-Nerfed Crystal Needles.
	<br>-Nerfed Crystal Bind's damage.
	<br>-Slightly nerfed Crystal explosion and fixed enemy stuck.
	<br>-Slight buff to Daijurin.
	<br>-Buffed Bubble Barrage.
	<br>-Spider summon now requires handsign uses to master(Still does not level).
	<br>-Fixed Bone Sensation.
	<br>-Fixed Gates and BoneSword(These may be unbalanced).
	<br>-Fixed Gates self damage(it was being called twice).
	<br>-Attempted balance on Gates.
	<br>-Gates are now it's own nonclan.
	<br>-Fixed some minor mapping issues.
	<br>-Fixed Water Prison.
	<br>-Wiped characters. Reason: Gates nonclan.

	<br><hr><br>
	<h3>1.1.8</h3>
	<br>-Reverted from 1.1.8 to 1.1.7(byond update broke something).
	<br>-Removed mouse hover icons(byond update broke something).
	<br>-Fixed the skill tree layer bug.
	<br>-Removed Pay2Obtain.
	<br>-Host now has Admin powers.
	<br>-Fixed some HUD display issues.
	<br>-Removed un-used stats from StatPanel.
	<br>-Minor chuunin exam adjustments.
	<br>-Chuunin exams are now on a 4 hour timer(Admins can still start one manually).
	<br>-Genin exams are now on a 20 minute timer.
	<br>-Made it so if a kage retires to someone outside of their village it pulls them into their village(This isn't a good fix, but it works).
	<br>-Added a warning to password creation("Please select a password for this account.Keep in mind: The host, and any other staff with the ability to edit, can see this if they edit you. Please use a password that you will remember but does not compromise the rest of your life.").
	<br>-Gave admins(and therefore hosts) the ability to add mods.
	<br>-Added a rule for hosts.
	<br>-Turned on Auto afk check.
	<br>-Removed Create from admin verbs.
	<br>-Fixed it so breaking Transform removes underlays.
	<br>-Moved the mist village symbol a little to line up better with the HUD.
	<br>-Promote to Kage(an admin verb) now makes that person a part of the village they run(No more Hokage of the hidden Sand).
	<br>-Released the source file so anyone who wants to host, can.
	<br>-Fixed the host admin verbs.
	<br>-Made it so admins can't be banned.
	<br>-Removed all hard coded staff from the game.
	<br>-Removed some multiserver code.

	<br><hr><br>
	<h3>1.1.7</h3>
	<br>-A rank missions will now include other villagers as well as missing ninjas
	<br>-Added S rank missions(25 Xp missions! Goodluck!)
	<br>-Added a Check mission button in the squad verb list.
	<br>-Made missions unstackable(hopefully)
	<br>-Fixed bug where killing clones gets you stuck (Reformist).
	<br>-Attempted fix of Gates' damage boost(failed)
	<br>-Slightly reduced damage user is given by gates.
	<br>-People in gates rank 4 or 5 will no longer be effected by Temple of Nirvana.
	<br>-Increased Advanced Sub's distance 2 squares.
	<br>-Changed Anbu root's name color to a Mint Green.
	<br>-Increased health and chakra gain from leveling up by 5.
	<br>-Max EXP will not increase as much/as quickly from leveling.
	<br>-Skill points should stay on your statpanel now.
	<br>-Removed NinDefence and GenDefence.
	<br>-Increased Chakra Leech's cooldown.
	<br>-Flying thunder god now has a .3 second cooldown to use jutsus after teleporting.
	<br>-Reduced Flying thunder god's cooldown slightly.
	<br>-Kaguya's bonesword now increases punching damage(failed).
	<br>-Changed Anbu root's Symbol.
	<br><br>
	<h3>1.1.6(Reformist's)</h3>
	<br>-Possible fix to clones causing whoever killed them to become unable to attack.
	<br>-Merged the handseal verbs into one verb with a macro argument.
	<br>-Removed a block of code related to corrupting accounts.

	<br><hr><br>
	<h3>1.1.6</h3>
	<br>-Re-instated Control_Freak.
	<br>-Added a staff macro for GM-chat.
	<br>-Adjusted ban verbs to be more accessible.
	<br>-Chidori Nagashi now works in all directions.
	<br>-Slight nerf to Tree Binding Death.
	<br>-Soul Devastator and Seal of Terror now do chakra dmg.
	<br>-Sealing Justus' SP cost was fixed.
	<br>-Fixed a bold font issue in P2O.
	<br>-Changed Susanoo Icon(Credits to Blair).
	<br>-Temp fixed Susanoo(no longer makes you invulnerable after it ends.

	<br><hr><br>
	<h3>1.1.5</h3>
	<br>-Re-added clothing and weaponry.
	<br>-Added Uchiha Vest, Uchiha shirt, Nara shirt, Uzumaki shirt, Genjutsu Robe, Flame robe, Straw hat, and Assassin Gloves!
	<br>-Fixed a couple minor mapping issues.
	<br>-Adjusted some P2O things and included that all P2O items and jutsus(not services) will be available through wipes.
	<br>-Staff can no longer delete the area(what the hell guys)
	<br>-Fixed an error with GM-Chat and the world log.
	<br>-Adjusted staff verbs.

	<br><hr><br>
	<h3> 1.1.4 </h3>
	<br>-Automatic Chuunin Exams(Should happen every 3 hours IF there is atleast 3 Genin online)
	<br>-Wood Fortress has been fixed(Smaller fortress, no longer has holes)
	<br>-Rinnegan no longer takes chakra and will announce to the world when used.
	<br>-Rinnegan's cooldown has been reduced to 1sec.
	<br>-Players are now able to get Bug Tornado!
	<br>-Rinn and Byakugan's bubble no longer flicker.
	<br>-Moved Mist's hospital, making a lot of free space behind mist village.
	<br>-Rearranged all indoor areas to avoid snapping to edge of map(leaf dojo issue).
	<br>-Removed the last of Sound village( :( )
	<br>-All doorway warps have been redone(no more weird teleports).
	<br>-Mist dojo should no longer bring you to sand or sound.
	<br>-Minor coding adjustment(Helps keep track of doorways).
	<br>-Changed Anbu Root chat color(Might be Temporary).
	<br>-Added Anbu root cursor icon.
	<br>-7sm and Anbu root now have a HUD icon!(Hand drawn by Squigs)
	<br>-All HUD icons have been completely re-done!(Hand drawn by Squigs)
	<br>-Fixed an issue with Anbu root failing to give leader verbs
	<br>-Anbu root HQ!
	<br>-Seven Swordsmen Camp!
	<br>-Seven Swordsmen and Anbu root have working respawn and /stuck locations!
	<br>-Seven Swordsmen, Anbu root, and Akatsuki can all take missions(Same as villages for now)!
	<br>-Susanoo is back to having a timer.
	<br>-Removed and re-added mist to the mist village.
	<br>-Added a way for me to keep track of who kages are.
	<br>-Boosted Wood Balvan.
	<br>-Anbu masks, and suits are no longer removed on logout.

	<br><hr><br>
	<h3> 1.1.3 </h3>
	<br>-Added an Auto-reboot(Removed for now)
	<br>-Kirin no longer activates if no target.
	<br>-7sm can now /stuck.
	<br>-Camellia Dance will no longer get stuck and be un-removable.
	<br>-Camellia Dance will now give 25 chakra back to the user when turned off manually.
	<br>-Sharingan is now Toggle-able.
	<br>-Reduced Sharingan's cooldowns.
	<br>-Fixed Sharingan Copy(Made an attempt. No way to test).
	<br>-Susanoo is now Toggle-able(no)
	<br>-Rinnegan is now Toggle-able.
	<br>-Byakugan is now Toggle-able.

	<br><hr><br>
	<h3> 1.1.2 </h3>
	<br>-Added the Anbu Root(Needs some fixing).
	<br>-New Kage Secretaries.
	<br>-Sensory ninja(Teleport between villages).
	<br>-Increased Intang cooldown by 5sec.
	<br>-Fixed some typing issues in the tutorial.
	<br>-Added 'no refunds' to P2O.
	<br>-Added 'buying things doesn't exempt you from the rules' to P2O.
	<br>-Changed price of Name Change to $1.
	<br>-Added Chuunin+ to kage rules.
	<br>-Moved some stuff around allowing for future coding to be slightly easier.
	<br>-Shishi Rendan no longer causes the user to be stuck if target is too far away.
	<br>-Made some jutsus easier to train.
	<br>-Fixed Amat/Tsuku/Kamui with cooldown being activated even when missing.
	<br>-Increased Susanoo's hp.
	<br>-Fixed earth caging dead people
	<br>-Fixed Earth Cage's cooldown activate when missing.
	<br>-Slightly nerf'd 64 palms' nin xp gain.
	<br>-Added names to the secretaries and sensories.
	<br>-Increased Ash Pile's damage to make up for it's super nerf in length.
	<br>-Reduced Flying Thunder God's cooldown, but increased Chakra Cost.
	<br>-Increased the size of some of the bottom buttons.
	<br>-Added an icon to Root strangle(v).
	<br>-Boosted Senjuu.
	<br>-Nerf'd Amat.
	<br>-Nerf'd warp rasengan.
	<br>-Checked Rasenshuriken and Sage Rasen(They were both powerful and needed no adjustments)
	<br>-Removed Reqs from sealing clan(P2O Jutsus)
	<br>-Nerf'd Blind.
	<br>-Removed Blind's automacro.
	<br>-Fixed target disapearing issues
	<br>-Nerf'd Bubble(Bubble Barrage needs to be checked)
	<br>-Nerf'd Omega Ice Ball
	<br>-Removed some stuff from the bug report button.
	<br>-Fixed a client like bug created when some accounts were broken.

	<br><hr><br>
	<h3> 1.1.1 </h3>
	<br>-Added a list to the Pay to Obtain button, allowing players to see what's available, how much they are, and how to purchase.
	<br>-Slightly lowered the cooldown on Chakra Leech.
	<br>-Increased the Nin Xp gain on a single Non-clan jutsu(Not telling which).
	<br>-Nerf'd Human Bullet Tank.

	<br><hr><br>
	<h3> 1.1.0 </h3>
	<br>-Wipe.
	<br>-Updated the game's name and picture.
	<br>-Added all 9 Jin cloaks!(Purchase only atm)(Still needs adjusting, will be done as the game progresses and i feel necessary)
	<br>-Updated the tutorial.
	<br>-Removed the requirements for all jutsus that are pay to obtain(Example: You no longer need rinnegan to get almighty push)
	<br>-Temp fixed Intangibility(P2O)
	<br>-Removed the SP cost to all jutsus that are pay to obtain.
	<br>-Fixed CLIENTs once and for all.
	<br>-C2 dragon's health has been increased(was 25 lol).
	<br>-Decreased duration of burn(lasted user's nin in seconds. Now divided by 10).
	<br>-Reduced Damage taken from Gates.
	<br>-Updated the Genin Exam questions.
	<br>-Added additional dialog to the genin exam when telling you to execute 3 jutsus(dialog says to ignore indoor warning for genin).
	<br>-Updates some of the Chuunin Exam questions.
	<br>-Fixed Shikigami dance. Needed an additional handseal and a small fix. Previously needed wings active to use correctly.
	<br>-Fixed some minor GM related checks.
	<br>-Reduced the chakra cost of Multiple shadow clones and Shadow clones.
	<br>-Increased the cooldown on stealth bugs.
	<br>-Fixed the underlay bug.
	<br>-Nerf'd snake summon's damage but increased it's health.
	<br>-Summons can now kill.
	<br>-Snake summon now needs to be mastered to be macro'd.
	<br>-Crow substitution, Snake Skin replacement, and Snake release jutsu can now be macro'd
	<br>-Slightly boosted Ink lions.
	<br>-Slightly nerf'd Ink snakes.

	<br><hr><br>
	<h3> 1.0.3 </h3>
	<br>-Nerf'd warp rasengan.
	<br>-Reverted Staff code file.
	<br>-Re-updated Staff code file.
	<br>-Cleaned up my personal bug list.

	<br><hr><br>
	<h3> 1.0.2</h3>
	<br>-Re-fixed the Client bug for 40th time. Seriously. Knock it off.
	<br>-Fixed using Nara again after bind is over.
	<br>-Boosted Sage Rasengan.
	<br>-Slightly boosted Spider Arrow.
	<br>-Fixed heal(V).
	<br>-Boosted Warp rasengan.

	<br><hr><br>
	<h3> 1.0.1</h3>
	<br>-Moved CLIENTs
	<br>-Fixed some minor mapping issues.
	<br>-Fixed using items indoors.
	<br>-Added a price to the Jacket.
	<br>-Fixed Shadow Extension's cooldown. was getting stuck on the cooldown list.(Nope)
	<br>-Fixed a few typos
	<br>-Removed old staff(forgot to in .0)
	<br>-Fixed Crystal explosion
	<br>-Fixed Chakra leech's hp drain.
	<br>-Fixed Omega Iceball's requirements

	<br><hr><br>
	<h3> 1.0.0 </h3>
	<br>-Fixed Water Sharks.
	<br>-Water Dragon is fixed.
	<br>-Increased Ice mirror's cooldown.
	<br>-Fixed C3.
	<br>-Fixed Defend.
	<br>-Fixed a small issue in the What's New? list.
	<br>-Fixed some Small mapping issues.
	<br>-Fixed some cooldowns.
	<br.-Fixed projectiles death.
	<br>-Nerf'd Rasenshuriken.
	<br>-Buff'd Rasengan, Chidori, and Raikiri.
	<br>-Added Rasenshuriken to the skill tree!(Wind+Rasengan)
	<br>-Removed Gates' debugging info.
	<br>-Nerf'd Gates' damage to the user.
	<br>-Fixed Sickle Weasel Slash.
	<br>-Healing bug fixed(Reformist)
	<br>-Added more weaponist jutsus.
	<br>-Fixed defending after C3(Found a problem with Defend not showing the icon state).
	<br>-Fixed the 8Trigrams Empty palm icon being left behind(Reform).
	<br>-Removed last of debug information.
	<br>-Fixed stat panel anchors.(hopefully)
	<br>-Fixed a missing piece of map in mist.
	<br>-Removed no pushing belore lvl 4.
	<br>-New Stat Panel!
	<br>-Solo Agi Training! (Go grab some weights from the Weapon shop and use(press S) them on your friends! Don't have any friends? Go use them on logs.)
	<br>-Added handsigns to a few jutsus that needed them.
	<br>-Changed many cooldowns.
	<br>-Re-Added The Evil Tree.
	<br>-Fixed Chidori Nagashi
	<br>-Boosted Chidori and Raikiri. Cooldowns are also different. (chidori: lower cooldown less damage. Raikiri: Higher damage, higher cooldown)
	<br>-Boosted some Wind moves.
	<br>-Nerf'd Ink.
	<br>-Boosted Paper.
	<br>-Removed the push from water sharks.
	<br>-Fixed a bug that made people invisible for a moment during an earth tech.
	<br>-Added long pants to the store.
	<br>-Added a closed robe to the store(RedAgain).
	<br>-Gates rework (Reformist).
	<br>-Clones optimized and reworked a tiny bit (Reformist).
	<br>-Game now saves upon Logout.
	<br>-Fixed the SM CS bugs induced when logging out.
	<br>-Removed Bracken Dance(Just couldn't figure out how to fix lag without breaking the jutsu).
	<br>-Created a temp 7sm spawn.
	<br>-Fixed Nara so you can't use non-nara jutsus during bind(more secure way).
	<br>-Fixed the chuunin so that you can take it at lvl 10.
	<br>-Put all Staff Verbs on 1 tab(They were split into Admin and Mod before).
	<br>-Removed the ability to add stat points to Str, Def, and Agi.
	<br>-Added 2 new .dm codes that reduce jutsu coding(Thanks Reformist).
	<br>-Added a chakra removal system to Reformist's code.
	<br>-A rank missions now give an additional 5xp.
	<br>-Added Kage and leader challenge rules to the bottom of the rules.
	<br>-CONTROL_FREAK now only stops macros. Allowing you to access options and such.
	<br>-Fixed Kamui's icon location.
	<br>-Added Genjutsu Defence.
	<br>-Changed Admin teleport slightly.
	<br>-Fixed the Edit again.
	<br>-Added Mist and Sand back to the Hp/Chakra bar.
	<br>-Added an Akat symbol to the HP/Chakra bar(Don't like the size? Don't join the Akatsuki).
	<br>-Removed some unneeded mapping.
	<br>-Picked the best Deidara hair and removed the other 2.
	<br>-Re-added flying thunder god and fixed the skill tree layout to show that you need Flying Thunder God for Warp Rasengan.
	<br>-Reduced mist village's mist density a little bit.
	<br>-Fixed a bug I created during an update.
	<br>-Changed the 7sm Cursor symbol.
	<br>-Zetsus now do more damage when punching, player defence reduces this ammount.
	<br>-Removed some leftover and unnecessary code that was left behind during previous updates.
	<br>-Fixed a Mapping issue.
	<br>-Removed some items that had absolutely no use.
	<br>-Removed Sealing clan, Dust, and Rinnegan from the Skill Tree.
	<br>-Changed SSM name color from dark blue to Silver.
	<br>-Removed old update data(This is a New Era. We're starting fresh).
	<br>
	<br><hr><br>
	</center>
	<font size="2" color="red">
	<div style="text-align:right;">
	*Credit goes to our amazing developers, past and present.*
	</div>
	</font>
	</body>
	</html>
"}