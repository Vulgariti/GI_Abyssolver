import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DamageCalculator extends StatefulWidget {
  const DamageCalculator({super.key});

  @override
  State<DamageCalculator> createState() => _DamageCalculatorState();
}



class _DamageCalculatorState extends State<DamageCalculator> {

  final List<String> reactionList = <String>["Vape/Melt (1.5x)","Vape/Melt (2x)","Aggravate","Spread"];
  final List<String> statTypesList = <String>["ATK", "HP", "DEF", "EM"];
  final List<String> condList = <String>["N/A","A","B","C","D"];

  Map<String, double> statMap = {
    "HP":0,"ATK":0,"DEF":0,"EM":0,"CR%":0, "CD%":0,"DMG%":0,"LVL":0,"RES% (Enemy)":0,
    "DMG% A":0,"DMG% B":0,"DMG% C":0,"DMG% D":0,"N/A":0,
    // Energy section
    "ER%":100,"C.M.":0,"C.O.":0,"C.W.":0,"N.M.":0,"N.O.":0,"N.W.":0,
  };

  String chosenReaction = "Vape/Melt (1.5x)";
  List<double> multList = <double>[];
  List<int> hitList = <int>[];
  List<int> reactCountList = <int>[];
  List<String> chosenStatList = <String>["ATK"];
  List<String> chosenCondList = <String>["N/A"];

  int rowCount = 0;

  double noCritsTotal = 0;
  double allCritsTotal = 0;
  double averageTotal = 0;
  double reactionTotal = 0;
  String output = "";

  //Data from the game for certain calculations. 90 values in total
  List<double> lvlMulti = [17.17,18.54,19.90,21.27,22.65,24.65,26.64,28.87,31.37,34.14,37.20,40.66,44.45,48.56,
    53.75,59.08,64.42,69.72,75.12,80.58,86.11,91.70,97.24,102.81,108.41,113.20,118.10,122.98,129.73,136.29,142.67,
    149.03,155.42,161.83,169.11,176.52,184.07,191.71,199.56,207.38,215.40,224.17,233.50,243.35,256.06,268.54,
    281.53,295.01,309.07,323.60,336.76,350.53,364.48,378.62,398.60,416.40,434.39,452.95,472.61,492.88,513.57,
    539.10,565.51,592.54,624.44,651.47,679.50,707.79,736.67,765.64,794.77,824.68,851.16,877.74,914.23,946.75,
    979.41,1011.22,1044.79,1077.44,1110.00,1142.98,1176.37,1210.18,1253.84,1288.95,1325.48,1363.46,1405.10,1446.85];

  String energyOutput = "";

  String getEnergy() {
    double energySum;
    energySum = statMap["C.M."]!*3 + statMap["C.O."]! + statMap["C.W."]!*2;
    energySum += statMap["N.M."]!*1.8 + statMap["N.O."]!*0.6 + statMap["N.W."]!*1.2;
    energySum *= statMap["ER%"]!*0.01;

    return energySum.toStringAsFixed(1);
  }


  //Calculates all output for a given row, rowNum, in "Multiplier Input"
  String calculateRow(int rowNum){
    double multiplier = multList[rowNum]*0.01;
    double hitcount = hitList[rowNum].toDouble();
    double reactionCount = reactCountList[rowNum].toDouble();
    double statAmount = statMap[chosenStatList[rowNum]]!;
    double condAmount = 0;
    if (chosenCondList[rowNum] == ("N/A")) {
      condAmount = statMap[chosenCondList[rowNum]]!;
    }
    else {
      condAmount = statMap["DMG% ${chosenCondList[rowNum]}"]!;
    }

    double noCrits = 0;

    //This switch-case should probably go in its own function but I don't want to make it
    double em = statMap["EM"]!;
    switch (chosenReaction){
      case ("Vape/Melt (1.5x)"):
        double withoutReacts = multiplier*statAmount*hitcount*((statMap["DMG%"]!+condAmount)*0.01+1);
        double reactsOnly = multiplier*statAmount*reactionCount*((statMap["DMG%"]!+condAmount)*0.01+1)
            *0.5*(1+(2.78*(em/(em+1400))));
        noCrits = withoutReacts+reactsOnly;
        reactionTotal += reactsOnly;
        break;
      case ("Vape/Melt (2x)"):
        double withoutReacts = multiplier*statAmount*hitcount*((statMap["DMG%"]!+condAmount)*0.01+1);
        double reactsOnly = multiplier*statAmount*reactionCount*((statMap["DMG%"]!+condAmount)*0.01+1)
            *1*(1+(2.78*(em/(em+1400))));
        noCrits = withoutReacts+reactsOnly;
        reactionTotal += reactsOnly;
        break;
      case ("Aggravate"):
        noCrits = multiplier*statAmount*hitcount;
        double reactsOnly = 1.15*lvlMulti[statMap["Level"]!.toInt()-1]*(1+(5*em)/(1200+em))*reactionCount;
        noCrits = (noCrits+reactsOnly)*((statMap["DMG%"]!+condAmount)*0.01+1);
        reactionTotal += reactsOnly*((statMap["DMG%"]!+condAmount)*0.01+1);
        break;
      case("Spread"):
        noCrits = multiplier*statAmount*hitcount;
        double reactsOnly = 1.25*lvlMulti[statMap["Level"]!.toInt()-1]*(1+(5*em)/(1200+em))*reactionCount;
        noCrits = (noCrits+reactsOnly)*((statMap["DMG%"]!+condAmount)*0.01+1);
        reactionTotal += reactsOnly*((statMap["DMG%"]!+condAmount)*0.01+1);
        break;
      default:
        break;
    }

    double resMulti = 1;
    if (0 <= statMap["RES% (Enemy)"]! && statMap["RES% (Enemy)"]!<75) {
      resMulti = 1-statMap["RES% (Enemy)"]!*0.01;
    }
    else if (statMap["RES% (Enemy)"]! < 0) {
      resMulti = 1-(statMap["RES% (Enemy)"]!/2)*0.01;
    }
    else {
      resMulti = 1/(4*statMap["RES% (Enemy)"]!*0.01+1);
    }

    noCrits *= resMulti;
    double allCrits = noCrits*(statMap["CD%"]!*0.01+1);
    double average = noCrits*(statMap["CR%"]!*0.01*statMap["CD%"]!*0.01+1);
    noCritsTotal += noCrits;
    allCritsTotal += allCrits;
    averageTotal += average;

    String result = "     NO CRITS: ${noCrits.toStringAsFixed(1)}"
        "     ALL CRITS: ${allCrits.toStringAsFixed(1)}"
        "     AVERAGE: ${average.toStringAsFixed(1)}";

    return result;
  }



  String getOutput()
  {
    String result = "";
    if (rowCount < 0)
    {
      return "";
    }

    for (int i=0; i<=rowCount; i++)
    {
      result += "Row ${i+1} | ${calculateRow(i)}\n";
    }

    result += "\nTOTALS |     NO CRITS: ${noCritsTotal.toStringAsFixed(1)}"
        "     ALL CRITS: ${allCritsTotal.toStringAsFixed(1)}"
        "     AVERAGE: ${averageTotal.toStringAsFixed(1)}"
        "\n\nDAMAGE GAINED FROM REACTIONS"
        "\n             NO CRITS: ${reactionTotal.toStringAsFixed(1)}"
        "     ALL CRITS: ${((statMap["CD%"]!*0.01+1)*reactionTotal).toStringAsFixed(1)}"
        "     AVERAGE: ${((statMap["CR%"]!*0.01*statMap["CD%"]!*0.01+1)*reactionTotal).toStringAsFixed(1)}"
        "\n             PERCENTAGE: ${(100*reactionTotal/noCritsTotal).toStringAsFixed(2)}%"
        " of damage is from reactions";

    noCritsTotal = 0;
    allCritsTotal = 0;
    averageTotal = 0;
    reactionTotal = 0;

    return result;
  }


  Row giveRow(int rowNum){
    if (multList.length<=rowNum)
    {
      multList.add(0);
      hitList.add(0);
      reactCountList.add(0);
      chosenStatList.add("ATK");
      chosenCondList.add("N/A");
    }

    return Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.w, right: 5.w),
            child: Text((rowNum+1).toString() + ".", style: TextStyle(fontSize: 12.h)),
          ),

          //This is for the Multiplier% text field
          SizedBox(
              width: 60.w,
              child: TextField(
                  style: TextStyle(fontSize: 12.h, height: 1.h),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 1.0.h),
                    border: const UnderlineInputBorder(),
                    labelText: "Multiplier%",
                  ) ,
                  onChanged: (value) {
                    multList[rowNum] = double.parse(value);
                  }
              )
          ),

          SizedBox(width:5.w), //This is just for spacing

          //This is for the Hits text field
          SizedBox(
              width: 40.w,
              child: TextField(
                  style: TextStyle(fontSize: 12.h, height: 1.h),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 1.0.h),
                    border: const UnderlineInputBorder(),
                    labelText: "Hits",
                  ) ,
                  onChanged: (value) {
                    hitList[rowNum] = int.parse(value);
                  }
              )
          ),

          SizedBox(width:5.w), // This is for spacing

          //This is for the Reactions text field
          SizedBox(
              width: 40.w,
              child: TextField(
                  style: TextStyle(fontSize: 12.h, height: 1.h),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 1.0.h),
                    border: const UnderlineInputBorder(),
                    labelText: "Reactions",
                  ) ,
                  onChanged: (value) {
                    reactCountList[rowNum] = int.parse(value);
                  }
              )
          ),

          SizedBox(width:5.w),

          //This is for the dropdown menu for stat types (default "ATK")
          SizedBox(
            width:50.w,
            child: ButtonTheme(
                alignedDropdown: false,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: chosenStatList[rowNum],
                  icon: Icon(Icons.arrow_downward, size: 20.h),
                  style: TextStyle(color: Colors.grey[700], fontSize: 12.h),
                  underline: Container(
                    height: 1,
                    color: Colors.grey[700],
                  ),
                  onChanged: (String? value){
                    setState((){
                      chosenStatList[rowNum] = value!;
                    });
                  },
                  items: statTypesList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
            ),
          ),

          SizedBox(width:5.w),

          //This is for the dropdown menu for conditional stats (default "N/A")
          SizedBox(
            width:50.w,
            child: ButtonTheme(
                alignedDropdown: false,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: chosenCondList[rowNum],
                  icon: Icon(Icons.arrow_downward, size: 20.h),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.h),
                  underline: Container(
                    height: 1,
                    color: Colors.grey[600],
                  ),
                  onChanged: (String? value){
                    setState((){
                      chosenCondList[rowNum] = value!;
                    });
                  },
                  items: condList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        width: 50.w,
                        color: condColorPicker(value),
                        child: Text(value, style: const TextStyle(color: Colors.black)),
                      ),
                    );
                  }).toList(),
                )
            ),
          ),


        ]
    );
  }

  Color? condColorPicker(String value)
  {
    switch(value){
      case ("A"): return Colors.red[300];
      case ("B"): return Colors.lightBlue[300];
      case ("C"): return Colors.green[500];
      case ("D"): return Colors.deepPurple[300];
      default: return Colors.transparent;
    }
  }

  BoxDecoration menuBox(){
    return BoxDecoration(
        color: Colors.blueGrey[100],
        border: const Border(
            top: BorderSide(
              color: Colors.black,
            )
        )
    );
  }

  Container statField(String statType, Color? backColor){
    return Container(
        color: backColor,
        child: TextField(
          //Appearance stuff
            style: TextStyle(fontSize: 12.h, height: 1.h),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 1.0),
              border: const UnderlineInputBorder(),
              labelText: statType,
            ) ,
            //Input stuff
            onChanged: (value) {
              statMap[statType] = double.parse(value);
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> rows = List.generate(rowCount+1, (int i) => giveRow(i));
    energyOutput = getEnergy();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Combat Calculator", style: TextStyle(color: Colors.black)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            //Multiplier Input section
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: menuBox(),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          //Section title
                          Container(
                            height: 30.h,
                            margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 1.h),
                            child: Text("Multiplier Input", style: TextStyle(fontSize: 20.h),),
                          ),

                          //Dropdown box, "Reaction"
                          Container(
                              height: 30.h,
                              margin: EdgeInsets.only(left: 20.w),
                              child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    isExpanded: false,
                                    value: chosenReaction,
                                    icon: Icon(Icons.arrow_downward, size: 20.h),
                                    style: TextStyle(color: Colors.grey[700], fontSize: 12.h),
                                    underline: Container(
                                      height: 1,
                                      color: Colors.grey[600],
                                    ),
                                    onChanged: (String? value){
                                      setState((){
                                        chosenReaction = value!;
                                      });
                                    },
                                    items: reactionList.map<DropdownMenuItem<String>>((String value){
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              )
                          ),

                          //Text
                          Container(
                            //height: 30.h,
                            margin: EdgeInsets.only(left: 10.w, bottom: 1.h),
                            child: Text("*\"Reactions\" is the number of hits that cause a reaction. This should usually be set "
                                "smaller than \"Hits\".",
                              style: TextStyle(fontSize: 12.h),),
                          ),

                          //Rows for multiplier input
                          Column(
                            children: rows,
                          ),

                          //+ Button
                          Container(
                            //color: Colors.red,
                              margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.70),
                              child: RawMaterialButton(
                                onPressed: () {
                                  setState((){
                                    rowCount += 1;
                                    rows.add(giveRow(rowCount));
                                  });
                                },
                                elevation: 2.0,
                                fillColor: Colors.white,
                                padding: EdgeInsets.all(5.0.h),
                                shape: const CircleBorder(),
                                child: Text("+", style: TextStyle(fontSize: 24.h)),
                              )
                          ),

                        ]
                    )
                )
            ),


            //Stats Input section
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: menuBox(),
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //Section Title
                      Container(
                        margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                        child: Text("Stats Input", style: TextStyle(fontSize: 20.h),),
                      ),
                      //Labels, "Conditional Stats" & "Constant Stats"
                      Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.475,
                              margin: EdgeInsets.only(left: 10.w),
                              child: Text("Conditional DMG%", style: TextStyle(fontSize: 14.h),),
                            ),
                            Text("Constant Stats", style: TextStyle(fontSize: 14.h),
                            ),
                          ]
                      ),
                      //Grid containing input fields for stats
                      Expanded(
                          child: GridView.count(
                              childAspectRatio: 1.75.w/1.h,
                              padding: EdgeInsets.only(left:15.w,right:15.w,top:5.h),
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 12.h,
                              crossAxisCount: 6,
                              children: <Widget>[
                                //Row 1
                                statField("DMG% A", Colors.red[300]),
                                statField("DMG% B", Colors.lightBlue[300]),
                                Container(),
                                statField("HP", Colors.transparent),
                                statField("ATK", Colors.transparent),
                                statField("DEF", Colors.transparent),
                                //Row 2
                                statField("DMG% C", Colors.green[500]),
                                statField("DMG% D", Colors.deepPurple[300]),
                                Container(),
                                statField("EM", Colors.transparent),
                                statField("CR%", Colors.transparent),
                                statField("CD%", Colors.transparent),
                                //Row 3
                                Container(),
                                Container(),
                                Container(),
                                statField("DMG%", Colors.transparent),
                                statField("Level", Colors.transparent),
                                statField("RES% (Enemy)", Colors.transparent),
                                //Row 4
                                Container(),
                                Container(),
                              ]
                          )
                      )
                    ]
                )
            ),


            //Output section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.75,
              alignment: Alignment.topLeft,
              decoration: menuBox(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                      child: Text("Output", style: TextStyle(fontSize: 20.h),),
                    ),

                    Text("*Enemy defense is not included (yet).\n"
                        "*\"NaN\" output means there is invalid input.",
                        style: TextStyle(fontSize: 12.h)),

                    //Output
                    Container(
                      color: Colors.grey[400],
                      child: Text(output, style: TextStyle(fontSize: 12.h)),
                    ),

                    //Go button
                    Container(
                      //color: Colors.red,
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.70),
                        child: RawMaterialButton(
                          onPressed: () {
                            setState((){
                              output = getOutput();
                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: EdgeInsets.all(10.0.h),
                          shape: const CircleBorder(),
                          child: Text("Go", style: TextStyle(fontSize: 14.h)),
                        )
                    ),
                  ]
              ),
            ),


            //Energy section
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.5,
                decoration: menuBox(),
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //Section Title
                      Container(
                        margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                        child: Text("Energy Particle Calculator", style: TextStyle(fontSize: 20.h),),
                      ),

                      Text("*Input the corresponding numbers of particles for each category."
                          "\n   \"Match\" is for particles of the same element as the character."
                          "\n   \"Other\" is for particles of a different element as the character."
                          "\n   \"White\" is for white particles such as from Favonius weapons."
                          "\n   \"Caught\" is for when particles are obtained while the character is on-field."
                          "\n   ER% should be 100% or higher.",
                          style: TextStyle(fontSize: 12.h)),

                      //Grid containing input fields for stats
                      Container(
                        height: 120.h,
                        child: Expanded(
                            child: GridView.count(
                                childAspectRatio: 1.75.w/1.h,
                                padding: EdgeInsets.only(left:15.w,right:15.w,top:5.h, bottom: 5.h),
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 12.h,
                                crossAxisCount: 6,
                                children: <Widget>[
                                  //Row 1
                                  statField("ER%", Colors.blueGrey[200]),
                                  Text("Match", style: TextStyle(fontSize: 14.h)),
                                  Text("Other", style: TextStyle(fontSize: 14.h)),
                                  Text("White", style: TextStyle(fontSize: 14.h)),
                                  Container(),
                                  Container(),
                                  //Row 2
                                  Text("Caught", style: TextStyle(fontSize: 12.h)),
                                  statField("C.M.", Colors.blueGrey[200]),
                                  statField("C.O.", Colors.blueGrey[200]),
                                  statField("C.W.", Colors.blueGrey[200]),
                                  Container(),
                                  Container(),
                                  //Row 3
                                  Text("Not Caught", style: TextStyle(fontSize: 12.h)),
                                  statField("N.M.", Colors.blueGrey[200]),
                                  statField("N.O.", Colors.blueGrey[200]),
                                  statField("N.W.", Colors.blueGrey[200]),
                                ]
                            )
                        ),
                      ),

                      //Go button
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.60),
                        child: RawMaterialButton(
                          onPressed: () {
                            setState((){
                              energyOutput = getEnergy();
                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: EdgeInsets.all(10.0.h),
                          shape: const CircleBorder(),
                          child: Text("Go", style: TextStyle(fontSize: 14.h)),
                        )
                      ),

                      Container(
                          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.2),
                          alignment: Alignment.topLeft,
                          child: Text("Energy Total:  $energyOutput", style: TextStyle(fontSize: 14.h))
                      ),

                    ]
                )
            ),


          ],
        ),
      ),

    );
  }
}