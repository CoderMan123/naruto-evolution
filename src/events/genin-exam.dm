var/genin_exam = 0
var/genin_exam_registration = 0
var/genin_exam_participants[0]

var/genin_exam_start_timer = 10 // delay in minutes before the Genin exam begins after the initial announcement.
var/genin_exam_frequency = 30 // how often the Genin exam should run.

var/genin_exam_written = 0
var/genin_exam_written_participants[0]
var/genin_exam_written_timer = 3 // this is how long players have to answer all of the questions in the written exam.
var/genin_exam_max_questions = 10 // max amount of questions that a player must answer for the written exam.
var/genin_exam_written_pass[0]

var/genin_exam_practical = 0
var/genin_exam_practical_score[0] // this variable holds data for handseal usage during the practical examination.

world
	proc
		GeninExam()
			while(src)

				for(var/mob/m in mobs_online)
					switch(m.village)
						if(VILLAGE_LEAF)
							m << output("A Genin exam will begin in the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village in [genin_exam_start_timer] minutes!</font>", "Action.Output")
							m << output("Please visit the <font color = '[COLOR_VILLAGE_LEAF]'>Genin Examiner</font> to register for the Genin exam.", "Action.Output")
							m << output("Once you register for the Genin exam, please take your seat and prepare for the written examination.", "Action.Output")

						if(VILLAGE_SAND)
							m << output("A Genin exam will begin in the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village in [genin_exam_start_timer] minutes!</font>", "Action.Output")
							m << output("Please visit the <font color = '[COLOR_VILLAGE_SAND]'>Genin Examiner</font> to register for the Genin exam.", "Action.Output")
							m << output("Once you register for the Genin exam, please take your seat and prepare for the written examination.", "Action.Output")

				genin_exam_registration = 1

				sleep(600 * genin_exam_start_timer)

				genin_exam_registration = 0

				for(var/mob/m in mobs_online)
					if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
						m << output("Registration for the Genin exam is now closed!", "Action.Output")

				if(genin_exam_participants.len)

					genin_exam = 1

					for(var/mob/m in mobs_online)
						switch(m.village)
							if(VILLAGE_LEAF)
								m << output("The Genin exam in the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village has commenced!", "Action.Output")

							if(VILLAGE_SAND)
								m << output("The Genin exam in the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village has commenced!", "Action.Output")

					genin_exam_written = 1

					for(var/mob/m in mobs_online)
						if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
							m << output("The written exam is now underway! You have [genin_exam_written_timer] minutes to complete this portion of the examination!", "Action.Output")

					sleep(600 * genin_exam_written_timer)

					genin_exam_written = 0

					for(var/mob/m in mobs_online)
						if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
							m << output("The written exam is now over! Those who have passed will move on to the practical examination!", "Action.Output")

					sleep(10)

					genin_exam_practical = 1

					for(var/mob/m in mobs_online)
						if(genin_exam_written_pass.Find(m) && (m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND))
							m << output("The practical examination has begun! Please execute 3 Ninjutsu or Genjutsu within 30 seconds to pass the practical examination.", "Action.Output")
							m.loc = locate(/area/genin_exam/practical_exam)

					sleep(300)

					for(var/mob/m in genin_exam_participants)
						if(genin_exam_practical_score[m] >= 3)
							m << output("You have passed the practical examination!", "Action.Output")
						else
							m << output("You have failed the practical examination!", "Action.Output")
						
						if(genin_exam_written_pass.Find(m))
							m.loc = m.MapLoadSpawn()

					genin_exam_practical = 0

					for(var/mob/m in mobs_online)
						if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
							m << output("The practical examination is now over!", "Action.Output")

					genin_exam = 0

					for(var/mob/m in mobs_online)
						switch(m.village)
							if(VILLAGE_LEAF)
								m << output("The Genin exam in the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village has concluded!</font>", "Action.Output")

							if(VILLAGE_SAND)
								m << output("The Genin exam in the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village has concluded!</font>", "Action.Output")

					for(var/mob/m in genin_exam_participants)
						if(genin_exam_practical_score[m] >= 3)
							switch(m.village)
								if(VILLAGE_LEAF)
									m << output("You are now a [RANK_GENIN] of the <font color = '[COLOR_VILLAGE_LEAF]'>[VILLAGE_LEAF]</font> village!", "Action.Output")

								if(VILLAGE_SAND)
									m << output("You are now a [RANK_GENIN] of the <font color = '[COLOR_VILLAGE_SAND]'>[VILLAGE_SAND]</font> village!", "Action.Output")

							m.SetRank(RANK_GENIN)
				else
					world << output("Due to a lack of participants, the Genin exam has been postponed for another [genin_exam_frequency] minutes.", "Action.Output")

				genin_exam_participants = initial(genin_exam_participants)
				genin_exam_written_participants = initial(genin_exam_written_participants)
				genin_exam_written_pass = initial(genin_exam_written_pass)
				genin_exam_practical_score = initial(genin_exam_practical_score)

				sleep(600 * genin_exam_frequency)

		GeninExamWritten(mob/m)
			if(genin_exam && genin_exam_written && genin_exam_participants.Find(m) && !genin_exam_written_participants.Find(m))

				genin_exam_written_participants.Add(m)

				var/list/exam_questions = list(
					"Jounin players get rewarded for helping students with missions."=1,
					"You can't clear your current target by pressing SHIFT+TAB."=0,
					"Mastering a jutsu increases it damage or effects."=1,
					"It's fine being cruel to other ninja and slinging personal insults."=0,
					"The Kage's job is to take care of their village."=1,
					"If you are stuck in a location you shouldn't be, you can type in /stuck to teleport out"=1,
					"There's a mysterious hotspring in the woods which can grant the rester it's energy."=1,
					"You'll be able to learn a new element at level 25."= 1,
					"Attacking the enemy village will upset the guards."=1,
					"When you are defeated in the dojo you don't die."=1,
					"There's no such thing as red pills that increase health regeneration."=0,
					"You can't use advanced body replacement jutsu while you're bound."=0
				)

				genin_exam_max_questions = min(genin_exam_max_questions, exam_questions.len)

				var/question
				var/score = 0
				var/count = 0

				while(count < genin_exam_max_questions)

					question = rand(1, exam_questions.len)

					var/answer = exam_questions[exam_questions[question]] ? "True" : "False"

					if(m.client.prompt(exam_questions[question], "Genin Exam: Written Examination", list("True", "False")) == answer)
						exam_questions.Remove(exam_questions[question])
						score += 1

					count++

				if(score / genin_exam_max_questions > 0.70)
					if(genin_exam_written)
						genin_exam_written_pass.Add(m)
						m << output("You have passed the written portion of the Genin Examination!", "Action.Output")
						m << output("<u>Question Score:</u> [score]/[genin_exam_max_questions] ([score / genin_exam_max_questions * 100]%)", "Action.Output")
						m << output("<u>Time Score:</u> Success", "Action.Output")
					else
						genin_exam_participants.Remove(m)
						m << output("You have passed the written portion of the Genin Examination!", "Action.Output")
						m << output("<u>Question Score:</u> [score]/[genin_exam_max_questions] ([score / genin_exam_max_questions * 100]%)", "Action.Output")
						m << output("<u>Time Score:</u> Failure", "Action.Output")

				else
					if(genin_exam_written)
						genin_exam_participants.Remove(m)
						m << output("You have failed the written portion of the Genin Examination!", "Action.Output")
						m << output("<u>Question Score:</u> [score]/[genin_exam_max_questions] ([score / genin_exam_max_questions * 100]%)", "Action.Output")
						m << output("<u>Time Score:</u> Success", "Action.Output")
					else
						genin_exam_participants.Remove(m)
						m << output("You have failed the written portion of the Genin Examination!", "Action.Output")
						m << output("<u>Question Score:</u> [score]/[genin_exam_max_questions] ([score / genin_exam_max_questions * 100]%)", "Action.Output")
						m << output("<u>Time Score:</u> Failure", "Action.Output")