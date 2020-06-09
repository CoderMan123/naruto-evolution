/* Temp P2O List
*Jin cloaks ($20)
*Dust pris/beam ($13)
*Crystal Mirrors ($7)
*Crystal Arrows ($8)
*Crystal pillars ($8)
*Getsuga Teshou ($13)
*Kamehameha ($13)

*Sage Robe($5)
*Guardian Shinobi10 Robe($5)
*Hebi Outfit($5)
*Muscles($5)
*Tobi War Mask($3)
*Bodyguard Vest($5 White or Black)
*Elite Bodyguard Vest($5)
*/


/*
*Jin cloaks
*Dust pris/beam
*Crystal Mirrors
*Crystal Arrows
*Crystal pillars
*Getsuga Teshou
*Kamehameha

*Sage Robe
*Guardian Shinobi10 Robe
*Hebi Outfit
*Muscles
*Tobi War Mask
*Bodyguard Vest(White or Black)
*Elite Bodyguard Vest
*/


mob/verb
	Pay2Obtain()
		set hidden=1
		var/text = {"
		<html>
		<head>
		<title>Pay2Obtain</title>
			<style>
				body {
					background-color: '#000000';
					color: '#ffffff'
				}
			</style>
		</head>
		<body>
		<center>
		<p>A list of things you can pay for and the details on them are here. Things marked with an (i) mean they are incomplete(meaning they're missing states or not complete in general).</p>
		<hr>
		<p>Things can be purchased without the leading admin online! Just send your payment to Squiglies@hotmail.com on paypal and in the note include your key. Make sure it says payment to Michael(To make sure it's the right person). All prices are USD. Buying things does not exempt you from the rules.</p>
		<hr>
		<h3> +Jutsus </h3>

		<br>-Jin Cloaks($20)
		<br>-Dust Prison/Beam($13)
		<br>-Crystal Mirrors($7)
		<br>-Crystal Arrow($8)
		<br>-Crystal Pillars($8)
		<br>-Getsuga Tenshou($13)
		<br>-Kamehameha($13)
		<br>
		<h3> +Clothing </h3>

		<br>-Sage Robe($5)
		<br>-Guardian Shinobi10 Robe($5)
		<br>-Hebi Outfit($5)
		<br>-Muscles($5)
		<br>-Tobi War Mask($5)
		<br>-Bodyguard Vest($5 White or Black)
		<br>-Elite Bodyguard Vest($5)

		<br>-Goku Suit($3)(i)
		<br>-Squad Captain Suit($3)(i)
		<br>-Jounin Suit($3)(i)
		<br>-Jounin Training Suit($3)(i)
		<br>-Hyuuga Suit($3)(i)
		<br>-Hokage Armor($4)(i)
		<br>-2nd Hokage Armor($4)(i)
		<br>-Orochimaru Robe($5)(i)
		<br>-Hidan Scythe($5 Cosmetic only)(i)
		<br>-Mizukage Staff($5 Cosmetic only)(i)
		<br>-Feudal Scroll($3)(i)
		<br>-Sage Scroll($3)(i)
		<br>-Madara Fan($8 Cosmetic only)(i)
		<br>-Hokage Staff($5 Cosmetic only)(i)
		<br>-Gourd($5 Cosmetic only)(i)

		<br>
		<h3> +Services</h3>
		<br>-Password Change($1)
		<br>-Village Change($1)
		<br>-Edited Hair Color($2)
		<br>-Max Inv Increase($1 for 5 spaces)
		<br>-Bingo book Rankup($1:C | $3:B | $5:A | $8:S)
		<br>-Skillpoint($5)
		<br>
		<hr>
		</center>
		<font size="2" color="red">
		<div style="text-align:right;">
		Feel free to message Squigs with any and all questions or suggestions.
		<br>
		No refunds.
		</div>
		</font>
		</body>
		</html>
  	  "}
		src << browse(text, "window=Updates;size=500x400")


