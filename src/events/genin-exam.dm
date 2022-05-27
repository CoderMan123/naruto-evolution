var/genin_exam = 0
var/genin_exam_registration = 0
var/genin_exam_participants[0]

var/genin_exam_start_timer = 0.5 // delay in minutes before the Genin exam begins after the initial announcement.
var/genin_exam_frequency = 60 // how often the Genin exam should run.

var/genin_exam_written = 0
var/genin_exam_written_participants[0]
var/genin_exam_written_timer = 1 // this is how long players have to answer all of the questions in the written exam.
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
						if(m.village == VILLAGE_LEAF || m.village == VILLAGE_SAND)
							m << output("The practical examination has begun! Please execute 3 Ninjutsu or Genjutsu within 30 seconds to pass the practical examination.", "Action.Output")

					sleep(300)

					for(var/mob/m in genin_exam_participants)
						if(genin_exam_practical_score[m] >= 3)
							m << output("You have passed the practical examination!", "Action.Output")
						else
							m << output("You have failed the practical examination!", "Action.Output")

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
					"This exam requires you to be level 5 or higher"=1,
					"Pheonix flower technique is a fire element technique"=1,
					"Tsukuyomi is a technique utilized by the hyuga clan"=0,
					"Senju clan majors in the use of puppets"=0,
					"The Hokage's job is to take care of the leaf village"=1,
					"If you are stuck in a location you shouldn't be, you can type in /stuck to teleport out"=1,
					"You move with the arrow keys"=1,
					"You can retake this exam if you fail it"=1,
					"Chidori is a wind element technique"=0,
					"To receive a mission, you talk to the banker of your village"=0,
					"You started this game with Clone jutsu and Transformation jutsu"=1,
					"You recieve a headband from passing this exam"=1,
					"This exam is too easy"=1
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