

/******************************************************************


     The F_Damage library was inspired by  Spuzzum's s_damage
     library, which allows you to flash numerical values over
     specific targets in your game.  While similar, F_Damage
     includes support for negative values, targets with pixel
     offsets, and larger numbers, including scientific notation.

     Flick


*******************************************************************



     To use F_Damage, you simply call the f_damage() proc, sending
     the target, numerical value, and color.  This will display
     the value briefly over the target, in the selected color.

proc/f_damage(atom/Target, Value, color)

   {
     Target - The mob, obj, or turf where you would like
              the numbers to display.

     Value  - The number you want to display over the target.

     color  - A hexadecimal color code text string.  You can
              send the code in either 3 or 6 digit format.

                "#ffaacc" is the same as "#fac"

              the "#" is optional.


*******************************************************************/


/******************************************************************

    The following defines set a few of F_damages parameters.

*******************************************************************

   F_damage_layer is the layer your numbers will display on.
   This value needs to be higher than any of your other mob,
   obj, or turf layers.

*/
#ifndef F_damage_layer
#define F_damage_layer 10000
#endif

/*

*/
#ifndef F_damage_numWidth
#define F_damage_numWidth 7
#endif

/*
*/
#ifndef F_damage_icon
#define F_damage_icon 'F_damageFade.dmi'
#endif

#define F_damage_log_warnings














