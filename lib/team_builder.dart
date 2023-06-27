import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamBuilder extends StatefulWidget {
  const TeamBuilder({super.key, required this.title});
  final String title;

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}



class _TeamBuilderState extends State<TeamBuilder> {

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Team Builder", style: TextStyle(color: Colors.black)),
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
            ),


            //Stats Input section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
              decoration: menuBox(),
              alignment: Alignment.topLeft,
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topLeft,
              decoration: menuBox(),
            ),


          ],
        ),
      ),

    );
  }
}