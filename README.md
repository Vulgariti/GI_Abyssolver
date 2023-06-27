# Abyssolver

This is an app that includes calculators intended for theorycrafting for the game Genshin Impact.

Currently, there are two main screens and files: main.dart and damage_calculator.dart

main.dart is for the main screen allowing the user to choose between which calculator or tool to navigate to.
damage_calculator.dart is for a calculator, the main feature of this app, allowing the user to input stats/numbers and get output for it.

# damage_calculator.dart
In damage_calculator.dart, almost all of the actual calculations are done in a function called calculateRow. A small amount is also done in a function called getOutput. 
Two other important functions are statField and giveRow.
statField returns a text field which is used for all of the text fields in the "Stats Input" section. 
giveRow returns a row which is used in the "Multiplier Input" section to create the rows for user input whenever they click the "+" button. 

All input to the "Stats Input" section is saved in a map called "statMap". 
For the "Multiplier Input" section, each "column" of input has its own List; for example, all input for "Multiplier%" is saved, in order, to a list multList. 
Most output is just put in a String called "output" since nothing else is done with it once it's calculated. 
The "TOTALS" section of output is an exception and has all of its values saved to variables that all end in "Total", e.g. noCritsTotal.