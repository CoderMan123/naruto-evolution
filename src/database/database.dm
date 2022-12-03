var/database/log_db

var/const/db_table_akatsuki             = "akatsuki"
var/const/db_table_character_creation   = "character_creation"
var/const/db_table_character_experience = "character_experience"
var/const/db_table_character_kills      = "character_kills"
var/const/db_table_character_level      = "character_level"
var/const/db_table_character_login      = "character_login"
var/const/db_table_character_prestige   = "character_prestige"
var/const/db_table_chat_faction         = "chat_faction"
var/const/db_table_chat_global          = "chat_global"
var/const/db_table_chat_local           = "chat_local"
var/const/db_table_chat_squad           = "chat_squad"
var/const/db_table_chat_staff           = "chat_staff"
var/const/db_table_chat_village         = "chat_village"
var/const/db_table_chat_whisper         = "chat_whisper"
var/const/db_table_error                = "error"
var/const/db_table_error_db             = "error_db"
var/const/db_table_item                 = "item"
var/const/db_table_kage                 = "kage"
var/const/db_table_missions             = "missions"
var/const/db_table_server_startup       = "server_startup"
var/const/db_table_staff                = "staff"
var/const/db_table_transactions          = "transactions"

proc
    DbMigrations()
        var/database/query/query = new

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_akatsuki]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `log` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_creation]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `action` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_experience]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `stat` TEXT NOT NULL,
                `[db_table_character_experience]` INTEGER NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_kills]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `environment` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `victim_key` TEXT NOT NULL,
                `victim_character` TEXT,
                `victim_identity` TEXT NOT NULL,
                `victim_village` TEXT,
                `victim_faction` TEXT
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_level]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `stat` TEXT NOT NULL,
                `level` INTEGER NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_login]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `action` TEXT NOT NULL,
                `result` TEXT NOT NULL,
                `reason` TEXT
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_character_prestige]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `level` TEXT NOT NULL,
                `prestige` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_faction]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_global]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_local]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_squad]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_staff]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_village]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_chat_whisper]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `identity` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `faction` TEXT,
                `recipient_key` TEXT NOT NULL,
                `recipient_character` TEXT NOT NULL,
                `recipient_identity` TEXT NOT NULL,
                `recipient_village` TEXT NOT NULL,
                `recipient_faction` TEXT,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_error]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `error` TEXT NOT NULL,
                `description` TEXT,
                `file` TEXT,
                `line` INTEGER NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_error_db]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `error` TEXT NOT NULL,
                `message` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_item]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `item_id` INT NOT NULL,
                `type` TEXT NOT NULL,
                `stacks` INT NOT NULL,
                `location` TEXT,
                `ckey` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `recipient_ckey` TEXT,
                `recipient_character` TEXT,
                `action` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_kage]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `village` TEXT NOT NULL,
                `log` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_missions]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `squad_leader_key` TEXT,
                `squad_leader` TEXT,
                `squad_member_1_key` TEXT,
                `squad_member_1` TEXT,
                `squad_member_2_key` TEXT,
                `squad_member_2` TEXT,
                `squad_member_3_key` TEXT,
                `squad_member_3` TEXT,
                `squad_member_4_key` TEXT,
                `squad_member_4` TEXT,
                `mission` TEXT
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_server_startup]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `action` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_staff]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `key` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `role` TEXT NOT NULL,
                `log` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

        query.Add({"
            CREATE TABLE IF NOT EXISTS `[db_table_transactions]` (
                `id` INTEGER PRIMARY KEY,
                `timestamp` TEXT NOT NULL,
                `ckey` TEXT NOT NULL,
                `character` TEXT NOT NULL,
                `npc` TEXT NOT NULL,
                `npc_type` TEXT NOT NULL,
                `item_id` INT,
                `item_type` TEXT,
                `stacks` INT NOT NULL,
                `ryo` INT NOT NULL,
                `action` TEXT NOT NULL
            );
        "})
        query.Execute(log_db)
        LogErrorDb(query)

    LogErrorDb(var/database/query/query)
        spawn()
            ASSERT(query)
            if(query.Error())
                query.Add({"
                    INSERT INTO `[db_table_error_db]` (`timestamp`, `error`, `message`)
                    VALUES(?, ?, ?)"},
                    time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), query.Error(), query.ErrorMsg()
                )
                query.Execute(log_db)
    
    LogItem(var/mob/m, var/obj/Inventory/o, var/mob/recipient, var/action, var/quantity = o.stacks)
        spawn()
            if(!m.client) return 0

            if(recipient)
                var/database/query/query = new({"
                    INSERT INTO `[db_table_item]` (`timestamp`, `item_id`, `type`, `stacks`, `location`, `ckey`, `character`, `recipient_ckey`, `recipient_character`, `action`)
                    VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
                    time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), o.id, "[o.type]", quantity, "[o.x], [o.y], [o.z]", m.ckey ? m.ckey : "[m.type]", m.character, recipient.ckey ? recipient.ckey : "[recipient.type]", recipient.character ? recipient.character : recipient.name, action
                )
                query.Execute(log_db)
                LogErrorDb(query)
            else
                var/database/query/query = new({"
                    INSERT INTO `[db_table_item]` (`timestamp`, `item_id`, `type`, `stacks`, `location`, `ckey`, `character`, `action`)
                    VALUES(?, ?, ?, ?, ?, ?, ?, ?)"},
                    time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), o.id, "[o.type]", quantity, "[o.x], [o.y], [o.z]", m.ckey ? m.ckey : "[m.type]", m.character, action
                )
                query.Execute(log_db)
                LogErrorDb(query)

    LogKage(var/mob/m, var/log)
        spawn()
            var/database/query/query = new({"
                INSERT INTO `[db_table_kage]` (`timestamp`, `key`, `character`, `village`, `log`)
                VALUES(?, ?, ?, ?, ?)"},
                time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, m.village, log
            )
            query.Execute(log_db)
            LogErrorDb(query)

    LogMission(var/mob/m, var/squad/squad, var/mission_name)
        spawn()
            var/database/query/query = new({"
                INSERT INTO `[db_table_missions]` (`timestamp`, `squad_leader_key`, `squad_leader`, `squad_member_1_key`, `squad_member_1`, `squad_member_2_key`, `squad_member_2`, `squad_member_3_key`, `squad_member_3`, `squad_member_4_key`, `squad_member_4`, `mission`)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
                time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), squad && squad.leader.len ? squad.leader[1] : m.key, squad && squad.leader.len ? squad.leader[squad.leader[1]] : m.character, squad && squad.members.len >= 1 ? squad.members[1] : null, squad && squad.members.len >= 1 ? squad.members[squad.members[1]] : null, squad && squad.members.len >= 2 ? squad.members[2] : null, squad && squad.members.len >= 2 ? squad.members[squad.members[2]] : null, squad && squad.members.len >= 3 ? squad.members[3] : null, squad && squad.members.len >= 3 ? squad.members[squad.members[3]] : null, squad && squad.members.len >= 4 ? squad.members[4] : null, squad && squad.members.len >= 4 ? squad.members[squad.members[4]] : null, squad && squad.mission ? squad.mission.name : mission_name
            )
            query.Execute(log_db)
            LogErrorDb(query)
    
    LogTransaction(var/mob/m, var/mob/npc, var/ryo, var/obj/Inventory/item, var/action, var/override_item = null)
        spawn()
            var/database/query/query = new({"
                INSERT INTO `[db_table_transactions]` (`timestamp`, `ckey`, `character`, `npc`, `npc_type`, `item_id`, `item_type`, `stacks`, `ryo`, `action`)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"},
                time2text(world.realtime, "YYYY-MM-DD hh:mm:ss"), m.client.ckey, m.character, npc.name, "[npc.type]", item ? item.id : null, item ? "[item.type]" : override_item, item ? item.stacks : null, ryo, action
            )
            query.Execute(log_db)
            LogErrorDb(query)
