# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2.1.0

## Added
- New train method for precision, Target Range

## Fixed
- Fixed training logs bleeding from certain attacks
- Fixed explosive tags lagging behind when stuck to a player
- Fixed ninja tool speed bug
- Fixed ninja tools stopping you from performing actions
- Fixed snake sub an crow sub activating upon regenerating health
- Fixed morning peacock lasting longer than it should
- Fixed burn effects

## Changed
- Nerfed rotating log damage
- Nerfed the stun from exploding kunai
- Camelia dance's chakra drain now decreases for each jutsu level

## 2.0.17

### Changed
- You can now hold S to keep using ninja tools

### Fixed
- Fixed Zetsu events being toggled off
- Fixed sharingan taking an extra tick of chakra when deactivated
- Fixed some backend issues
- Fixed throwing while knocked down in certain instances

## 2.0.16

### Added
- Added bonus EXP for jounins who do missions with Academy students
- You will now automatically become a genin at level 25 or higher
- Added audio settings! (your ears can cower in fear no longer)

### Fixed
- Fixed a bug with tsukiyomi taking it's time to hit everyone
- Fixed the multihit bug with demon wind shuriken
- Fixed Human Bullet Tank hopefully for the last time
- Fixed swimming making you immune to all kinds of projectiles
- Fixed rotating dummies spinning from damage that wasn't a punch from a player
- Fixed Repulsion not giving kill credit
- Fixed some back end issues

### Changed
- Buffed exp gains from killing someone who has a mission to kill you (20 exp)
- Nerfed Lightning Balls damage
- Jutsu level up and master at twice the rate as before
- Improvements to the Rotating Dummy AI
- Buffed Rotating Dummy exp gains

## 2.0.15

### Fixed
- Fixed huge problem with shadow clones punching at tick speed.

## 2.0.14

### Added
- You can now switch between ninja tools with `Shift + S`

### Fixed
- Fixed a number of back end issues
- Fixed Human Bullet Tank (sorry)
- Fixed animal spawns for good this time
- Fixed bugs with movement system and walking speed
- Fixed attackspeed bugs
- Fixed a bug with insect clones costs (now costs a lot less)

### Changed
- Improvements to client resolution detection
- Gates health costs reduced slightly
- Nara jutsus can't be cast until previous one has finished
- Chakra infusion can now be toggled off
- Bug tornado functions better
- Nerfed insect neurotoxin's duration
- Poison mist now applies better poison effect

## 2.0.13
### Added
- Map warpers will now no longer let you pass if you're in combat

### Fixed
- Fixed in combat state to function correctly
- Fixed akatsuki not getting their clothing
- Fixed having no rank when changing village
- Fixed Political Escort missions bug
- Fixed advanced body replacement speeding up ninja tools
- Fixed advanced body replacement not working with certain jutsus
- Fixed Human Bullet Tank dialing your speed up massively on kill
- Fixed a couple backend issues

### Changed
- nerfed kirin's damage and increased dodge window
- nerfed shikigami dance damage
- shadow extension now requires a target to cast

## 2.0.12

### Added
- added /restore-base command for players
- added reconnect button icon
- added an exp lock icon that appears next to a players hp bar when they're locked
### Fixed
- fixed a text bug
- fixed animal spawns increasing over time
- fixed bugs with warp dimension
- fixed an issue with bug swarm

### Changed
- Made improvements to akatsuki leader verbs
- Can no longer change village while in a squad
- increased delays for certain 'auto hit' jutsus so that they're easier to avoid
- Made some changes to zetsu event in preparation for akat release

## 2.0.11

### Added
- Added state manager.
- Added backend changes to help with diagnosing bugs.

### Changed
- The Who browser will only display logged in clients.

### Fixed
- Fixed rotating dummy to knock down with state manager.

## 2.0.10
### Fixed
- Fixed some backend issues
- Fixed escort npcs stopping when hit by certain jutsu
- Fixed certain jutsus not leveling properly (for real this time)

### Changed
- Buffed Hunter Scarabs
- Buffed Bug Swarm
- Buffed Bug Tornado
- Adjustment to stealth bugs
- Small nerf to bug neurotoxin
- Hard nerfed nin gains from water walking


## 2.0.9
### Fixed
- Emergancy fix for A rank missions

## 2.0.8
### Fixed
- Fixed experience lock spamming you.
- Fixed respawning when not dead.
- Fixed Byakugan taking chakra after being deactivated.
- Fixed a bug with squad chat.
- Fixed Daimyo giving a reward when killed.
- Fixed incorrect mission status.
- Fixed logout messages for players on the login screen.
- Fixed being sent to the void when killed in sand dojo.
- Fixed Warp dimension sending you to the wrong place.

## 2.0.7
### Added
- Added damage reduction while in Super Multi-Size Technique
- Added the ability to view jutsu descriptions by right clicking them in the P menu
- Added a reconnect button to the title bar

### Fixed
- Fixed squad channel
- Fixed Squad window spam refreshing
- Made many performance optimizations
- Fixed macros not functining when focus is on a window
- Fixed Rinnegan activation being annouced to the whole server
- Players can no longer dash while knocked down by rotating dummy
- Fixed a bug with dodging while knocked down or dead
- Fixed bug with experience lock button
- Fixed stolen intel scrolls not being handed in
- Certain missions will now fail on reboot instead of bugging the squad
- Mission status now displays correctly
- Human Bullet Tank no longer deals massive damage when stuck ontop of someone
- Certain jutsu now level at the correct rate
- Health regen no longer triggers FTG: Great Escape
- Fixed bugs with FTG, FTG: Kunai and Warp Rasengan
- Fixed Political Escort missions

### Changed
- Can no longer use 64 palms without a target
- Buffed Human Bullet Tank
- Buffed Super Multi-Size Technique's damage
- Nerf Tsukuyomi's damage
- Buffed stat exp gain from casting jutsu
- Buffed stat exp gain from Ninja Tools
- Buffed stat exp gain from weights

### Removed


## 2.0.6
### Added
- Made a new staff verb to fix peoples visuals.
- Added village counter to who page.

### Fixed
- Fixed staff chat being viewable to all.
- Fixed a few issues with browser window.
- Major performance improvements and bug fixes to movement.
- Reverted nerfs to certain training methods due to bug fixes.

### Changed
- Updated internal links.
- Improved performance of the internal browser.

### Removed
- Staff who.


## 2.0.5
### Fixed
- Fixed a bug with the rinnegan skill tree.

## 2.0.4
### Fixed
- Fixed a bug with hidden snake stab.
- Fixed Rinnegan not appearing in the skill tree.

### Changed
- Nerfed a number of training methods until associated bugs can be addressed.

## 2.0.3
### Fixed
- Fixed chunin exams staff verb
- Fixed bug with who window

## 2.0.2
### Fixed
- Fixed chunin exams.
- Fixed genin exams.
- Fixed some back end bugs.
- Fixed issue with broswer window switching to who.
- Fixed animals giving bounty and annoucing when they're killed.
- Fixed area of the map with a rogue warp tile.
- Fixed clay jutsus not appearing in skill tree.
- Fixed bugs with human bullet tank.

## 2.0.1
### Fixed
- Fixed chat box not closing sometimes.
- Fixed a small with leave village.
- Fixed implant clan not appearing in non-clan skill tree.
- Fixed moderators not having their verbs.
- Fixed a bug with who.
- Fixed medical clan not appearing in the clan list.

### Removed
- Removed discontinued Uzumaki clan from the clan list.



## 2.0.0
### Added
- Akatsuki Event
- - New White Zetsu mobs.
- - New periodic world event where Sand and Leaf team up to fight the Akatsuki and their Zetsu minions.

- Animals
- - New animal mobs spawning randomly around the map that provide small amount of exp each with unique AI.

- Combat System
- - Added some new jutsu.
- - A few new clans.
- - New stat: Precision
- - Regeneration System
- - New Training Systems

- Missions
- - New missions for all ranks

- And much more!

### Changed
- Combat System
- - Jutsu statistics are now handled modularly with formulas to make balancing far easier
- - A lot of new mechanics for old jutsu
- - Rearranged certain non-clan jutsu into clans of their own
- - Ninja tools have had an overhaul
- Interface
- - New hotkeys
- - Chat overhaul
- - New health and chakra bars
- - Skill tree system improvements
- - Name overlay improvents
- - Floating combat numbers improved
- - New title screen
- - Shops are now useable
- - Inventory improvements

- Map
- - Map overhaul
- - - New Akatsuki hideout
- - - Missing nins spawn randomly on the map
- - - Sound village converted into a factionless village
- - - A new factionless village added
- - - Balanced map with clear direction and design

- Accounts
- - Accounts now tied to ckey
- - Overhauled save/load system

- Progression
- - New exp and stat curves make it easier for new characters to reach the midgame but harder to reach the endgame.
- - Jutsu no longer give stats when they hit targets and instead give the stats on use

- Missions
- - Squads system has been completely overhauled
- - Missions system overhaul
- - Only squad leaders can start missions
- - Missions are now tied to squads instead of characters
- - Much larger rewards from missions
- - Higher missions cooldown (tied to ckey)

- Kage
- - Can only be one kage no matter what
- - Kage verbs have been overhauled

- And much more!

### Fixed
- Bug Fixes
- - Far too many to count

### Removed
- Old Content
- - Removed a lot of old content and systems that weren't up to par with the new vision
