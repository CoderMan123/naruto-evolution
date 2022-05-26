mob
    npc
        mouse_over_pointer = /obj/cursors/speech
        var/tmp/list/conversations = list()
        var/npcowner
        var/ownersquad
        var/tmp/bark
        move=0

        New()
            ..()
            npcs_online.Add(src)

            if(!istype(src, /mob/npc/combat/animals/small))
                src.overlays += /obj/MaleParts/UnderShade

            src.SetName(src.name)

            OriginalOverlays = overlays.Copy()
            //spawn() src.RestoreOverlays()

            src.NewStuff()

        Move()
            if(istype(src, /mob/npc/combat)) ..()
            else return

        Death(killer)
            if(istype(src, /mob/npc/combat)) ..()
            else return

        banker
            name = "Banker"
            icon = 'WhiteMBase.dmi'
            density = 1
            pixel_x = -15

            leaf_banker
                village = VILLAGE_LEAF

            sand_banker
                village = VILLAGE_SAND

            missing_nin_banker
                village = VILLAGE_AKATSUKI

            akatsuki_banker
                village = VILLAGE_AKATSUKI

            New()
                src.overlays += pick('Short.dmi', 'Short2.dmi', 'Short3.dmi')
                src.overlays += 'Shirt.dmi'
                src.overlays += 'Sandals.dmi'
                ..()


            DblClick()
                if(src.conversations.Find(usr)) return 0
                if(get_dist(src,usr) > 2) return
                if(usr.dead) return

                src.conversations.Add(usr)

                if(src.village == usr.village)

                    view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Greetings [usr.name], would you like to make a deposit or a withdrawal from your bank?</font>"

                    switch(usr.client.prompt("You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br /><br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank", list("Deposit","Withdraw","Cancel")))
                        if("Deposit")

                            view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a deposit to my bank account.</font>"

                            if(!usr.ryo)
                                sleep(10)
                                view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to deposit.</font>"
                            else
                                sleep(10)
                                view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to deposit?</font>"

                                switch(usr.client.prompt("Would you like to deposit all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
                                    if("Yes")
                                        var/value = usr.ryo

                                        if(value)
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"

                                            usr.ryo -= value
                                            usr.RyoBanked += value

                                            spawn() usr.client.UpdateInventoryPanel()

                                            usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
                                            usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

                                        else
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                                    if("No")
                                        var/list/response = usr.client.iprompt("How much Ryo would you like to deposit into your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")

                                        var/value = text2num(response[2])

                                        if(isnum(value) && value > 0 && usr.ryo >= value)
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to deposit [value] Ryo into my bank account.</font>"

                                            usr.ryo -= value
                                            usr.RyoBanked += value

                                            spawn() usr.client.UpdateInventoryPanel()

                                            usr << output("You have deposited <u>[value]</u> Ryo into your bank.", "Action.Output")
                                            usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

                                        else
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                                    if("Cancel")
                                        view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                        sleep(10)
                                        view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                        if("Withdraw")

                            view(usr) << "[HTML_GetName(usr)]<font color='[COLOR_CHAT]'>: I'd like to make a withdrawal from my bank account.</font>"

                            if(!usr.RyoBanked)
                                sleep(10)
                                view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'm sorry, but your broke ass doesn't have any Ryo to withdrawal.</font>"
                            else
                                sleep(10)
                                view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Very well, how much would you like to withdrawal?</font>"

                                switch(usr.client.prompt("Would you like to withdrawal all of your Ryo?", "Bank", list("Yes", "No", "Cancel")))
                                    if("Yes")
                                        var/value = usr.RyoBanked

                                        if(value)
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdrawal [value] Ryo into my bank account.</font>"

                                            usr.RyoBanked -= value
                                            usr.ryo += value

                                            spawn() usr.client.UpdateInventoryPanel()

                                            usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
                                            usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

                                        else
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                                    if("No")
                                        var/list/response = usr.client.iprompt("How much Ryo would you like to withdraw from your bank?<br /><br />You currently have <u>[usr.ryo]</u> Ryo in your satchel.<br />You currently have <u>[usr.RyoBanked]</u> in your bank.", "Bank")

                                        var/value = text2num(response[2])

                                        if(isnum(value) && value > 0 && usr.RyoBanked >= value)
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I'd like to withdraw [value] Ryo from my bank account.</font>"

                                            usr.RyoBanked -= value
                                            usr.ryo += value

                                            spawn() usr.client.UpdateInventoryPanel()

                                            usr << output("You withdraw <u>[value]</u> Ryo into from your bank.", "Action.Output")
                                            usr << output("You now have <u>[usr.ryo]</u> Ryo into your satchel and <u>[usr.RyoBanked]</u> in your bank.", "Action.Output")

                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Your transaction has been completed. Please come back again soon!</font>"

                                        else
                                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                            sleep(10)
                                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                                    if("Cancel")
                                        view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Actually, I've changed my mind.</font>"
                                        sleep(10)
                                        view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"
                        if("Cancel")
                            view(usr) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: No, thank you.</font>"
                            sleep(10)
                            view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: Please come back again soon!</font>"

                else
                    view(src) << "[HTML_GetName(src)]<font color='[COLOR_CHAT]'>: I only manage accounts for members of the [HTML_GetVillage(src)].</font>"

                src.conversations.Remove(usr)

        shady_man
            name = "Shady Looking Figure"
            icon = 'WhiteMBase.dmi'
            village = VILLAGE_MISSING_NIN
            New()
                src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
                src.overlays += 'Shade.dmi'
                src.overlays+='Shirt.dmi'
                src.overlays+='Sandals.dmi'
                ..()

            DblClick()
                if(usr.dead)return
                if(get_dist(src,usr)>2)return
                if(usr)usr.move=0
                if(usr.village == VILLAGE_MISSING_NIN)
                    var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
                    if(O && O.squad.mission)
                        O.squad.mission.Complete(usr)
                    else
                        usr.client.prompt("Psst, hey you there. If you can get me some intel on the shinobi villages I'll pay you handsomely.", src.name)
                else
                    usr.client.prompt("Buzz off, I don't speak with the likes of you.", src.name)
                usr.move=1

        zetsu //not to be confused with white zetsu
            name = "Zetsu"
            icon = 'Zetsu.dmi'
            village = VILLAGE_AKATSUKI
            //100,161,5

            DblClick()
                if(usr.dead)return
                if(get_dist(src,usr)>2)return
                if(usr)usr.move=0
                var/obj/Inventory/mission/deliver_intel/O = locate(/obj/Inventory/mission/deliver_intel) in usr.contents
                if(O && O.squad.mission)
                    O.squad.mission.Complete(usr)
                else if(usr.client.prompt("Be patient. In time, we'll create a whole new world. Would you like to use the secret exit?", src.name, list("Yes", "No")) == "Yes")
                    usr.loc = locate(100,32,4)
                usr.move=1

        onomari //reserved for prestige system
            name = "Onomari"
            icon = 'WhiteMBase.dmi'
            village = "Hidden Leaf"