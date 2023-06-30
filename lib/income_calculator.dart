import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomeCalculator extends StatefulWidget {
  const IncomeCalculator({super.key});

  @override
  State<IncomeCalculator> createState() => _IncomeCalculatorState();
}



class _IncomeCalculatorState extends State<IncomeCalculator> {

  Map<String, int> dataMap = {
    "Days":0,"Stars":0,"Resets":0,"# of Maintenances":0,
    "# of Special Programs":0,"# of Fates":0,"Primos":0
  };
  bool welkin = false;
  int sum = 0;

  String output = "";

  String getOutput() {
    int fromDaily = dataMap["Days"]!*60;
    int fromWelkin = 0;
    if (welkin) {
      fromWelkin = dataMap["Days"]!*90;
    }
    int fromShop = dataMap["# of Fates"]!*160;
    int fromAbyss = (dataMap["Stars"]!/3).floor()*50*dataMap["Resets"]!;
    int fromMaint = dataMap["# of Maintenances"]!*600;
    int fromSpec = dataMap["# of Special Programs"]!*300;
    int fromMisc = dataMap["Primos"]!;
    int sum = fromDaily+fromWelkin+fromShop+fromAbyss+fromMaint+fromSpec+fromMisc;

    String result = "Primos from Daily: $fromDaily. This is ${(100*fromDaily/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Welkin: $fromWelkin. This is ${(100*fromWelkin/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Stardust: $fromShop. This is ${(100*fromShop/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Abyss: $fromAbyss. This is ${(100*fromAbyss/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Maintenances: $fromMaint. This is ${(100*fromMaint/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Special Programs: $fromSpec. This is ${(100*fromSpec/sum).toStringAsFixed(1)}% of the total."
        "\nPrimos from Miscellaneous Sources: $fromMisc. This is ${(100*fromMisc/sum).toStringAsFixed(1)}% of the total."
        "\n\n Total: $sum Primos"
        "\n        or ${sum.toDouble()/160.0} Wishes";

    return result;
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

  SizedBox inputField(String dataType){
    return SizedBox(
        width: 40.w,
        height: 20.h,
        child: TextField(
          //Appearance stuff
            style: TextStyle(fontSize: 12.h, height: 3.h),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 2.h),
              border: const UnderlineInputBorder(),
              labelText: dataType,
            ) ,
            //Input stuff
            onChanged: (value) {
              dataMap[dataType] = int.parse(value);
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    sum = 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Income Calculator", style: TextStyle(color: Colors.black)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            //Input section
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                decoration: menuBox(),
                alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        //Section Title
                        Container(
                          margin: EdgeInsets.only(left: 10.w, top: 10.h),
                          child: Text("Input", style: TextStyle(fontSize: 20.h),),
                        ),
                        Text("*Special Programs give 300 primos from codes.\n"
                            "*Starglitter Fates should NOT include Stardust, only the number of Monthly fates purchased.",
                            style: TextStyle(fontSize: 12.h)),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Daily Commissions: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("Days"),
                              SizedBox(width: 5.w),
                              Container(
                                margin: EdgeInsets.only(left: 15.w),
                                child: Text("Welkin", style: TextStyle(fontSize: 14.h),),
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                value: welkin,
                                onChanged: (bool? value){
                                  setState((){
                                    welkin = value!;
                                  });
                                }
                              )
                            ]
                        ),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Spiral Abyss: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("Stars"),
                              SizedBox(width: 5.w),
                              inputField("Resets"),
                            ]
                        ),
                        SizedBox(height: 5.h),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Maintenances: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("# of Maintenances"),
                              SizedBox(width: 5.w),
                            ]
                        ),
                        SizedBox(height: 5.h),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Special Programs: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("# of Special Programs"),
                              SizedBox(width: 5.w),
                            ]
                        ),
                        SizedBox(height: 5.h),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Starglitter Fates: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("# of Fates"),
                              SizedBox(width: 5.w),
                            ]
                        ),
                        SizedBox(height: 5.h),
                        Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.w, right: 5.w,),
                                child: Text("Additional/Misc: ", style: TextStyle(fontSize: 14.h),),
                              ),
                              inputField("Primos"),
                              SizedBox(width: 5.w),
                            ]
                        ),
                        SizedBox(height: 15.h),
                      ]
                  )
                )
            ),


            //Output section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              alignment: Alignment.topLeft,
              decoration: menuBox(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 5.h),
                      child: Text("Output", style: TextStyle(fontSize: 20.h),),
                    ),

                    Text("*Battle Pass is not included.\n"+
                        "*Starglitter is not included.",
                        style: TextStyle(fontSize: 12.h)),

                    Container(
                      color: Colors.grey[400],
                      child: Text(output, style: TextStyle(fontSize: 12.h)),
                    ),

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


          ],
        ),
      ),

    );
  }
}