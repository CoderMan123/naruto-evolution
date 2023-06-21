#define floor(x) round(x)
#define ceil(x) -round(-(x))

#define ADMINISTRATOR "ADMINISTRATOR"
#define MODERATOR "MODERATOR"
#define PROGRAMMER "PROGRAMMER"
#define PIXEL_ARTIST "PIXEL_ARTIST"

#define STATE_MANAGER

#define CFG_ADMIN "cfg/admin.txt"
#define CFG_HOST "cfg/host.txt"
#define SAVEFILE_WORLD "saves/world.sav"
#define SAVEFILE_STAFF "saves/staff.sav"
#define SAVEFILE_BANS "saves/bans.sav"
#define SAVEFILE_NAMES "saves/names.sav"
#define SAVEFILE_CHARACTERS "saves/characters"
#define SAVEFILE_CHARACTERS_ARCHIVE "saves/characters/archive"
#define SAVEFILE_CLIENT "saves/clients"
#define SAVEFILE_SQUADS "saves/squads.sav"
#define SAVEFILE_KAGES "saves/kages.sav"
#define SAVEFILE_AKATSUKI "saves/akatsuki.sav"
#define SAVEFILE_ELECTIONS "saves/elections.sav"

#define DATABASE_LOGS "logs/logs.db"

#define LOG_ACTION_TRANSACTION_BUY "Purchase"
#define LOG_ACTION_TRANSACTION_SELL "Sell"
#define LOG_ACTION_TRANSACTION_TRADE "Trade"

#define BROWSER_NONE 0
#define BROWSER_WHO "browse://who"
#define BROWSER_JUTSU_REFERENCE "browse://jutsu-reference"
#define BROWSER_SQUAD "browse://squad"
#define BROWSER_LOGS "browse://logs"
#define BROWSER_SERVER_INFORMATION "browse://server-information"
#define BROWSER_WORLD_INFORMATION "browse://world-information"
#define BROWSER_ELECTION_INFORMATION "browse://election-information"

#define VILLAGE_MISSING_NIN "Missing-Nin"
#define VILLAGE_LEAF "Hidden Leaf"
#define VILLAGE_SAND "Hidden Sand"
#define VILLAGE_ROCK "Hidden Rock"
#define VILLAGE_MIST "Hidden Mist"
#define VILLAGE_SOUND "Hidden Sound"
#define VILLAGE_AKATSUKI "Akatsuki"

#define RANK_ACADEMY_STUDENT "Academy Student"
#define RANK_GENIN "Genin"
#define RANK_CHUUNIN "Chuunin"
#define RANK_JOUNIN "Jounin"
#define RANK_ANBU "ANBU"
#define RANK_ANBU_LEADER "ANBU Leader"
#define RANK_HOKAGE "Hokage"
#define RANK_KAZEKAGE "Kazekage"
#define RANK_MIZUKAGE "Mizukage"
#define RANK_OTOKAGE "Otokage"
#define RANK_TSUCHIKAGE "Tsuchikage"
#define RANK_AKATSUKI "Akatsuki"
#define RANK_AKATSUKI_LEADER "Akatsuki Leader"
#define RANK_SEVEN_SWORDSMEN_LEADER "Seven Swordsmen Leader"

// Return format for GetHokage(), GetKazekage(), and GetAkatsukiLeader()
#define RETURN_FORMAT_CKEY 0
#define RETURN_FORMAT_CHARACTER 1

#define CLAN_ABURAME "Aburame"
#define CLAN_AKIMICHI "Akimichi"
#define CLAN_BUBBLE "Bubble"
#define CLAN_CLAY "Deidara" //check
#define CLAN_CRYSTAL "Crystal"
#define CLAN_GATES "Gates"
#define CLAN_HYUUGA "Hyuuga"
#define CLAN_ICE "Ice"
#define CLAN_IMPLANT "Implanted"
#define CLAN_INK "Ink"
#define CLAN_JASHIN "Jashin"
#define CLAN_KAGUYA "Kaguya"
#define CLAN_KAKUZU "Kakuzu"
#define CLAN_MEDICAL "Medical"
#define CLAN_NARA "Nara"
#define CLAN_NOCLAN "No Clan"
#define CLAN_PAPER "Paper"
#define CLAN_PUPPET "Puppeteer"
#define CLAN_RINNEGAN "Rinnegan"
#define CLAN_SAGE "SnakeSage"
#define CLAN_SAND "Sand"
#define CLAN_SENJU "Senjuu"
#define CLAN_SPIDER "Spider"
#define CLAN_UCHIHA "Uchiha"
#define CLAN_WEAPONIST "Weaponist"
#define CLAN_YELLOWFLASH "Yellow Flash"
#define CLAN_IRON "Iron Sand"

#define SPECIALIZATION_NINJUTSU "Ninjutsu"
#define SPECIALIZATION_GENJUTSU "Genjutsu"
#define SPECIALIZATION_TAIJUTSU "Taijutsu"

#define COLOR_CHAT "#C8C8C8"
#define COLOR_VILLAGE_LEAF "#2b7154"
#define COLOR_VILLAGE_SAND "#886541"
#define COLOR_VILLAGE_AKATSUKI "#971e1e"
#define COLOR_VILLAGE_MISSING_NIN "#ffffff"

// State Manager //
#define STATE_REMOVE_REF 1
#define STATE_REMOVE_ANY 2
#define STATE_REMOVE_ALL 3

// Game Audio Manager //
#define AUDIO_SELF 0
#define AUDIO_HEARERS 1


//OLD, REPLACE WITH NEW IMPLEMENTATION LATER
#define TARGET_MOB 0