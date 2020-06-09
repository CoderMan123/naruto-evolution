Note to Lavi:
These notes and bugs are a little disorderly, sorry.
Anything that ends in a ? is something that may or may not need to be done its more of a thinking matter.
A lot of the stuff that was moved is pretty easy to find by file name, with the exception of a few testing verbs that are at the end of Random.dm
Ninjutsu Genjutsu and Taijutsu dm files have been mostely sorted by clan or element, but there are still some things i havent gotten to sorting/moving yet.




Note to self:
Update servertype number each update.
Map 12 is empty except Jutsus and Clothing
Map 18 is empty empty.
//If Bone sword and Gates are too op Find " + ((src.strength * 0.1)* src.bonesword) + ((src.strength * 0.1) * src.Gates) " or TEST in Taijutsu.dm -Squigs

*Newest bug lists*********************************************************************************

+Minor

Getowner gets the users key. if i let someone else on my character they can not level up my jutsus
(Sqads.dm and LevelProcs.dm)


Change level caps to work with a "max level" variable then change how Levelup() works to match.
This will fix all issues with giveeverything and the jutsu mastery scroll.


maybe set chat default to World


Jutsus that are not accessable still activate without target.


shuriken work properly with UI(and have an icon) Others do not.
Equipt items stop showing that theyre equipt after first use.
Missions xp arent balanced.
Cant really un-equip throwables.


-Cannot read null.loc proc name: Death
-Maybe remove max players? I dont think well ever have 100+ people tbh and even if we do why stop people from logging in?

-64 palms isnt broken by adv sub.
-Make water clone attack non-players?

-Add a timer to arena matches so they cant be abused/endless.
-Make it so that ppl cant do jutsus while hit with Kirin, just like tyuski?
-Tree summon cant be macrod
-Talk to npc missions should give coords for that npc.
-Button to tell you what coords youre currently at.
-Gates jutsus screenshake calls damage. But i dont think dmg returns anything.

-You can shadow bind and kill someone in ice mirrors


--Mission rework.
-A rank targets are effected by wars. Cool. Make it so it picks a random person, not the same each time.
-Mission times and exps(Make higher rank missions give more xp but have longer cooldowns).


(Player reports and suggestions)
-Cooldown timers as I use the mask abilities gets lower and lower down the screen every use, to the point that theyve literally disappeared off the bottom of the screen.
-Ultimate Ink Style: Lions and Ultimate Ink Birds icons are not centred correctly
-Ink Style: Rats and Ink Style: Snakes projectiles seem to sometimes just go through the target instead of hitting them resulting in no damage. Tested it on a still target and got the same result
-If you use blazing sun with susanoo on you always hit yourself with it
-...and these bounty missions should be able to swap targets like the d ranks do for npcs
-Instead of detonating c3 with d, maybe have it detonat with s or another key. That way a sub isnt burned.
-Doton Doryuusuo no Jutsu goes on CD if used without a target
-People can just regular sub out if spider bind which I dont think should be the case.
- make puppet 1 and 2 have different icons I mix them up when trying to figure out which one to un-summon
- Puppet dash should always activate with Ctrl or Alt + D but take away an amount of chakra when used, instead of having to toggle an annoying chakra drain, that doesnt let u recharge inside of it.
- Make it so mud wall actually blocks attacks like rasengan’s and shit.
- Make weapons actually hit you if targeted . Not when you e sub / advance sub . Same with chidori / raikiri .
-just make it so u cant move ur puppet and it locks them after u bind
-Rising twin dragons weapons sometimes disappear before hitting the target Only a few of the weapons actually hit the target
-I would like to suggest a buff to the first Uzumaki seal, not a dmg buff but maybe allow the user to move after using this seal, if not this seal then maybe the white seal that resembles narutos belly seal
-i think ice mirrors should have a lower cooldown. Not instance but definitely lower, like maybe 40 seconds?
-copy jutsu should copy max or same level as the jutsu
-Elements dragons shouldnt be the turning point for a builds strength. Dragons should not be doing the dmg they do
-should let kages host chuunin
-Quick suggestion maybe make it so that balanced gets medical nin stuff since they only get rinnegan, but if you pick a clan with tai min or gen, you get the other stuff in non clan
-New jashin jutsu similar to earth disruption but it only happens to the target of your jashin circle. (Inspired by how hidan makes asuma fall by attacking his own leg.)
- Add the 9 tailed beasts, make them randomly spawn or roam the map  and give us a seal jutsu to where we can claim their power once we killed them, n have the jinchurki cloak for a boost, but it only lasts like 24 hours
-Skillpoint cost balance.
-Support nonclan(Medic)
-Add diagonal movement
-Aoe mist move that counts as water
-Make it so you can only level your stat +50 of your main level //This would stop people from powerleveling a single stat and being able to ez 1hit fights. -Squigs





*Bug list that was created during the remap update***********************************************************************************


Bracken dance has no cooldown.(Not in game, Kaguya has enough jutsus for now)

Kakuzu jutsus dont level up.
Running jutsus can be used together to run extra fast.
Logging out in the middle of any jutsu will cause the proc to break. stopping any ends or deletes?
Killing the user during chakra leach bugs the leach to stay up?



Gates flicker goes on top if theyre facing a wall.(check 1000yrs for reference to maybe change this?)
Sometimes entering number amounts puts 1 instead
Center names and factions
Add way to watch chuunin
Change non-english jutsus to english.
Elemental clan. Pick a third element instead of a clan?
Fix move cooldowns stacking on top of eachother?
Factions delete on reboot.
Add Dog summon?
Move Staff_Who to mod?
Will still be able to push out of binds with cherry blossom/other pushes that arent F.


snake stab broken
Add way to delete your own character
Fix clan list
Village Guards not setup

Wardo(LevelTo) ??? in Buildinginsides

tree summoning no macro super long bind
jubaku eisou long bind icon way off
crystal mirrors ice mirrors but purple short cd
crystal arrow fairly op
getsuga seems ok maybe a little op LOUD
kamehameha OP af LOUD
Gomu gomu UP icon direction off
Zankuuha add/Zankuuha super UP is it supposed to push?

Jukai koutan bone forest but trees and not solid. no dmg. can walk thru
crystal bind long bind slightly off icon
rising twin dragons UP wtf is this icon

*Old Bug list***************************************************************
+Complete Overhall x.#.#(Will definitely require wipe)
-New Bases(Redo all hair/clothing).


+Major #.x.#(May require Wipe)
-New vils(Dependent on players).(We have stuff for Cloud. But were already up sound and rock and i dont think well fill those.
-Tailed Beasts
-Hairstyles
-Spider Jutsus(Maybe small spider swarms)
-Path of Pein event(people earn to right to be a path of pein. Each pein either pre-setup or just change of clan.)
-Fuinjutsu(Summons/Blood Pact[% based system]/Edo Tensei/Teleportation)
-NPCs(Training/Fightable[x]/Secret Jutsus)/akat home tele rings
-Remove senju jutsu balvan and root stab and add wood palm and rampant earth.
-New Mist and Sound chuunin vests
-Sage bind. Good idea. Impossible to impliment while using Dragon codes.
-add Bijuu bomb jutsu. Include in skill tree. Make requirements JC1 || JC2 || JC3 || etc.
-Autoreboot doesnt save only a problem because no save = broken logout = bugged stats
-Add option to masks for over/under hair


+Minor #.#.x(Will Not require wipe)
-Missions can be abused in 2 ways: stacking the same mission and accepting them all. or using squad panel to break flower mission? Idk
-Jashins can die in their circle.



**************************************************************************
+Specific Ideas
-Tailed beasts: chance of becoming Jinchu. Jinchu loses beast apon death. If killed by akat, beast is taken into Gedo statue. After all 9 are taken make a 10tail event.

+Fuinjutsu
-Npc teleports
-Toad(Mouth bind)
-Snail(Heals)
-Snake(Poisonous attack/Bind/escape)
-Chameleon(Invisibility)
-Crow(crow sub/crow clone)
-Cat
-Dogs(Bite/Bind)
-Hawks
-Spider
-Turtle(Defence)
-Squid/Octopus(Bind jutsu)
-Shark
-Monkey(Bind/Attack)
-Fox
-Wolf
-Scorpion(extra attack like Tai specialist, but with tail)
-Komodo Dragon(Deadly Bacteria)
-Crocs/Aligat(Damage)

+Support clan
-Transfer Chakra
-Adv heal
-Area heal
-Nirv gen
-Poison mist
-Yin seal(might req slug blood pact)

New Jutsu ideas:
Raikiri wolf
Rampant earth
searing migrain
Danzos wind jutsu(idk)

Sound Genjutsus
New Senju shit
Sound based clan maybe
Sakon/ukon clan

Use the Rinnegan scratch things for fuinjutsu blood pact related move(fox something? wolf something? Idk)
Dog summon(has to be coded) = dog/wolf pact and/or rinnegan ability.




+(Blair ideas)
- Paper Butterflies. The user creates paper butterflies to disorient their opponent. Sort of a mixture between clone jutsu and Aburames "bug balls" (apologies I forget the name). They would float around harmlessly except they are tab targetable creating a small window where its very hard for your opponent to target you without clicking. They would break on collision or damage just like clones do.
- Paper Form (Dance of the Shikigami). Due to the absence of paper substitution I feel like paper has lost its mojo as the Paper Substitution was one of Konans signature moves. This Jutsu would be similar to intangible except you cant take any actions whatsoever except for moving and you are only immune to binds. Everything else works just fine. I believe this is the hardest one to accomplish on the list and so if this one were to be cut I'd at least hope we can get the ol' faithful paper sub again since that is basically what crow sub and snake sub are so I imagine it shouldn't be hard too reimplement.
- Paper Barrage. In the anime Konan will often launch sharp arrow like folds of paper from her wings to pelt her foes with razor sharp blades of paper. I imagine this could function very similarly to Morning Peacock except with increased directional range, no fire and less punchy. This jutsu would only be usable while using wings.
-Id also like to add that I think paper spear is unnecessary and players already get dragons from their elements I dont really feel like these kinds of jutsu need to be in the clans as well. The whole "this is the part of my combo where I stand here and press all my dragon hotkeys" is repetitive and dry as it is. I feel like paper shurikens should replace this jutsu.

-Flying Thunder God could be reworked to a kunai projectile whereby if it hits the target they are briefly micro-stunned and the person teleports behind them with absolutely zero delay on their next move. This would be more true to the anime while also being a far more valuable addition to the game. It could also set the foundation for a 4th hokage clan tree in potential future.
-The main reason I suggest this change is because thunder god basically just replaces body flicker and currently no one uses body flicker because of it. I dont believe there should be redundant Jutsu in the game, every Jutsu should have a clear purpose.
-Longer cooldown for disruption
-puppet bind someone then unsummon the puppet bugs people




+(Kino ideas)


Different path of uchihas //Hate this idea, especially random. Re-creating characters for the tree i want is a pain and a waste of time. -Squigs
Sasuke
-different susano(purple black)(3 different stages)
-attack with sussano such as indras arrow or amat blast with after particles like fire ball does(only can activate while using sussano)
-amat
-no tsuki
- another justsu for sasuke path
Itachi
-current sussano(1 stage)
-tsuki
-crow sub
-crow clones
-amat
Shisui
-Better teleport
-sussano(1 stage)
-2 strong gen move

Spider clan
-Spider armor (reduces damage when toggled/chakra drain when toggled)

Samurai
-Chakra enhance, enhance sword to do more dmg
-hits from sword causes bleeding effect(where you wouldn’t be able to heal for awhile except heal jutsus)
-teleport sword slash (jutsu)

Medical clan
-Heal
-revive
-Chakra enhanced fist
-chakra dot on tsunades head that heals as you fight
-Poison mist
-poison needles that chip away health over time

Kisame clan
-makes a body not a requirement for using water jutsus
-move quicker than normal in water //Can't really mess with movement without re-writing everything movement related -Squigs
-deal more dmg in water
-can summon a field of water like bone field(gets bigger the more you level it)
-shark summon
-shark transformation(like akimi)(S to bite)
-must pick water element to get clan

Abrame(Torune path)(same as Uchiha, achieved randomly) //Still hate random obtainment -Squigs
-bugs eat away charka instead of health
-bug cloak (togglable, drains chakra while toggled) if user contact another player it damages the other player

Tayuya clan
-permanent flute icon on hand upon creation
- Doki summon(guardians)
-flute song, disrupts movement in battle for 10 secs (exp.pressing right would move you left)(Area effect)
-ghost dragon like shot

Remove earth cage/add earth dome