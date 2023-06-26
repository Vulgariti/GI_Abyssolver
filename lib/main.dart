import 'package:flutter/material.dart';
import 'package:ugh123/damage_calculator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (BuildContext context,child) => const MaterialApp(
        title: 'Main Screen',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Home Page'),
      ),
      designSize: const Size(360,640),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BoxDecoration menuBox(){
    return const BoxDecoration(
        border: Border(
            top: BorderSide(
              color: Colors.black,
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),*/
      body: Center(

        child: Column(

          children: <Widget>[

            //Title box
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.25,
              child: const Image(
                image: NetworkImage('https://logowik.com/content/uploads/images/genshin-impact4958.jpg')
              ),
            ),

            //1st Box used to navigate to another screen
            Material(
              color: Colors.blueGrey[100],
              child: InkWell( onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DamageCalculator(title: "testing")),
                );
              },
                  splashColor: Colors.blueGrey[400],
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.75/4,
                    decoration: menuBox(),
                    child: Text("wowcool", style: TextStyle(fontSize: 24.sp),),
                  )
              ),
            ),

            //2nd Box used to navigate to another screen
            Material(
                color: Colors.blueGrey[100],
                child: InkWell( onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DamageCalculator(title: "testing")),
                  );
                },
                splashColor: Colors.blueGrey[400],
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.75/4,
                      decoration: menuBox(),
                    )
                ),
              ),


            //3rd Box used to navigate to another screen
            Material(
              color: Colors.blueGrey[100],
              child: InkWell( onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DamageCalculator(title: "testing")),
                );
              },
                  splashColor: Colors.blueGrey[400],
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.75/4,
                    decoration: menuBox(),
                  )
              ),
            ),

            //4th Box used to navigate to another screen
            Material(
              color: Colors.blueGrey[100],
              child: InkWell( onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DamageCalculator(title: "testing")),
                );
              },
                  splashColor: Colors.blueGrey[400],
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.75/4,
                    decoration: menuBox(),
                  )
              ),
            ),


          ],
        ),
      ),
    );
  }
}
