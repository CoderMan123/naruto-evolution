mob/var/tmp/list/Effects=list()
mob
	var
		exp_locked=0
		health=1000
		maxhealth=1000
		chakra=800
		maxchakra=800
		level=1
		exp=0
		maxexp=10
		ninjutsu=1
		ninexp=0
		maxninexp=100
		genjutsu=1
		genexp=0
		maxgenexp=100
		strength=1
		editing=0
		strengthexp=0
		maxstrengthexp=100
		defence=1
		defexp=0
		maxdefexp=100
		agility=1
		agilityexp=0
		maxagilityexp=100
		precision=1
		precisionexp=0
		maxprecisionexp=100
		statpoints=0
		skillpoints=1
		kills=0
		village="Leaf"
		rank = RANK_ACADEMY_STUDENT
		dead=0
		namecolor="green"
		chatcolor="white"
		swimming
		walkingonwater
		waterwalk
		mountainwalk
		mountainkit=1
		attkspeed=8
		weaponattk
		Element
		Element2
		Kekkai
		Clan=null
		Specialist="strength"
		Specialist2
		ryo=0
		RyoBanked=0
		riconstate
		ricon
		rname
		Muted=0
		skiptut=0
		JashinSacrifices=0
		tmp
			AFK=0
			BeingThrown
			ThrowingMob
			move=1
			Bugreported=0
			combo=0
			turfover
			likeaclone
			cranks
			arrow
			obj/ArrowTasked
			takeova
			amounthits=0
			screen_moved=0
			smokebomb
			Linkage
			byakugan=0
			burn=0
			laststep
			jutsuaffect=0
			henge=0
			injutsu=0
			stepcounter=0
			wait
			rest=0
			fightlayer="Normal"
			respawntime=0
			Owner
			controller
			defend=0
			dodge=0
			turf/mark
			turf/mark2
			kawarmi=0
			dashable=0
			Hand="Left"
			foot="Left"
			speeddelay=0
			speeding=0
			waterlow=0
			waterhigh=0
			snowlow=0
			canattack=1
			firing=0
			infusing=0//chakrainfusionstuff
			bubbled=0//bubbleshieldstuff
			multisized=0//multisizestuff
			multisizestomp=0
			inshadowfield=0//shadowfieldstuff
			lungecounter=0
			sleephits=0
			ftgmarked=0
			ftgkunai=null
			healthregenmod=1
			dashcd=0
			foodpillcd=0
			dummylocation=0
			tagcd=0
var
	clonesturned=0
	worldmute=0
obj
	var
		health=100
		maxhealth=100
		level=1
		exp=0
		maxexp=100
		Owner
		tmp
			fightlayer="Normal"
			shootoverable
			Hit
			damage=0
			Linkage
			dead=0
turf
	var
		tmp
			fightlayer="Normal"