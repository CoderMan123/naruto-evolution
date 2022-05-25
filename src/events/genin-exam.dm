var/genin_exam = 0
var/genin_exam_registration = 0
var/genin_exam_participants[0]
var/genin_exam_start_delay = 5 // delay in minutes before the Genin exam begins after the initial announcement.
var/genin_exam_frequency = 60

world
	proc
		GeninExam()
			while(src)
				// Anounce start
				world << output("Genin exams will begin in all villages in [genin_exam_start_delay] minutes!", "Action.Output")

				world << output("Please visit your village's Genin Examiner to register for the Genin exam.", "Action.Output")
				genin_exam_registration = 1
				sleep(600 * genin_exam_start_delay)
				genin_exam_registration = 0
				world << output("Registration for the Genin exam is now closed!", "Action.Output")

				if(genin_exam_participants.len)
					genin_exam = 1
					world << output("The Genin exam is officially underway!", "Action.Output")
					// written exam
					// handseal testing
					// end exam
				else
					world << output("Due to a lack of participants, the Genin exam has been postponed for another [genin_exam_frequency] minutes.", "Action.Output")

				sleep(36000)

mob
	npc
		event_npc
			genin_examiner
				New()
					..()
					src.icon = pick('WhiteMBase.dmi', 'DarkMBase.dmi')
					src.overlays += pick('Deidara.dmi', 'Distance.dmi', 'Long.dmi', 'Mohawk.dmi', 'Neji Hair.dmi', 'Short.dmi','Short2.dmi','Short3.dmi', 'Spikey.dmi')
					src.overlays += 'Shirt.dmi'
					src.overlays += 'Sandals.dmi'

				leaf_genin_examiner
					icon = 'WhiteMBase.dmi'
					name = "Genin Examiner"
					village = VILLAGE_LEAF

				sand_genin_examiner
					icon = 'WhiteMBase.dmi'
					name = "Genin Examiner"
					village = VILLAGE_SAND