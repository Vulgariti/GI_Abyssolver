import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DamageCalculator extends StatefulWidget {
  const DamageCalculator({super.key, required this.title});
  final String title;

  @override
  State<DamageCalculator> createState() => _DamageCalculatorState();
}



class _DamageCalculatorState extends State<DamageCalculator> {

  final List<String> reactionList = <String>["Vape/Melt (1.5x)","Vape/Melt (2x)","Aggravate","Spread"];
  final List<String> statTypesList = <String>["ATK", "HP", "DEF", "EM"];
  final List<String> condList = <String>["N/A","A","B","C","D"];

  Map<String, double> statMap = {
    "HP":0,"ATK":0,"DEF":0,"EM":0,"CR":0, "CD":0,"DMG":0,"LVL":0,"RES":0,
    "DMG% A":0,"DMG% B":0,"DMG% C":0,"DMG% D":0,
  };

  String chosenReaction = "Vape/Melt (1.5x)";
  List<double> multList = <double>[];
  List<int> hitList = <int>[];
  List<int> reactCountList = <int>[];
  List<String> chosenStatList = <String>["ATK"];
  List<String> chosenCondList = <String>["N/A"];

  int rowCount = 0;

  Row giveRow(int rowNum){
    if (multList.length<rowNum)
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
                  border: UnderlineInputBorder(),
                  labelText: "Multiplier%",
                ) ,
                onSubmitted: (value) {
                  multList[rowNum] = double.parse(value);
                  print("Value at position " + rowNum.toString() + ": " + multList[rowNum].toString());
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
                    border: UnderlineInputBorder(),
                    labelText: "Hits",
                  ) ,
                  onSubmitted: (value) {
                    hitList[rowNum] = int.parse(value);
                    for (int i=0; i<multList.length;i++)
                      {
                        print("Length of list: " + multList.length.toString());
                        print(multList[i]);
                      }
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
                    border: UnderlineInputBorder(),
                    labelText: "Reactions",
                  ) ,
                  onSubmitted: (value) {
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
        onSubmitted: (value) {
          statMap[statType] = double.parse(value);
          print(statType);
          print(statMap[statType]);
        }

      )
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> rows = List.generate(rowCount+1, (int i) => giveRow(i));

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

                      Column(
                        children: rows,
                      ),

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
                          padding: EdgeInsets.all(10.0.h),
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.add,
                            size: 25.0.h,
                          ),
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
                        statField("RES", Colors.transparent),
                        //Row 4
                        Container(),
                        Container(),
                      ]
                    )
                  )
                ]
              )
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.875/4,
              decoration: menuBox(),
            ),


          ],
        ),
      ),

    );
  }
}