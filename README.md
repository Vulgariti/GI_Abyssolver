# Abyssolver

This is an app that includes calculators intended for theorycrafting for the game Genshin Impact. The goal of the app is to provide tools that are flexible rather than specific. 

Currently, there are five screens: the main screen, a combat calculator, a team-builder tool, an income calculator, and a resources page.

# Explanation of Code
    damage_calculator.dart
This file handles the Combat Calculator. 
In damage_calculator.dart, almost all of the  calculations are done in a function called calculateRow. A small amount is also done in a function called getOutput. 
Two other important functions are statField and giveRow.
statField returns a text field which is used for all of the text fields in the "Stats Input" section. 
giveRow returns a row which is used in the "Multiplier Input" section to create the rows for user input whenever they click the "+" button. 

All input to the "Stats Input" section is saved in a map called "statMap". 
For the "Multiplier Input" section, each "column" of input has its own List; for example, all input for "Multiplier%" is saved, in order, to a list multList. 
Most output is just put in a String called "output" since nothing else is done with it once it's calculated. 
The "TOTALS" section of output is an exception and has all of its values saved to variables that all end in "Total", e.g. noCritsTotal.

The energy section works the same way as the damage section, including saving input to the same "statMap". 


    team_builder.dart
This file handles the Team Builder. 
There is a list of all the character names, with the names being exactly the same as the names of the corresponding .png files. 
Adding a new character is as simple as adding their .png image icon and then putting their name in the list. 
There is also a String List for the characters in the current team and an integer to keep track of which slot the user has selected.
Whenever the user selects a character, it will update the list for the current team to put that character's name in the corresponding slot. 


    income_calculator.dart
This file handles the income calculator.
The file is just text fields and output, and it functions similarly to damage_calculator.dart. 
Input is saved to a Map called "dataMap" and output is calculated in a function called "getOutput".


    resources_page.dart
This file handles the resources page.
It is just text and links. In the code, all of the links are saved in final variables toward the top of the file. 