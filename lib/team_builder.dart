import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamBuilder extends StatefulWidget {
  const TeamBuilder({super.key});

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}



class _TeamBuilderState extends State<TeamBuilder> {

  final List<String> characterSearch = [
    'Albedo','Alhaitham','Arataki_Itto','Baizhu','Barbara','Beidou','Bennett','Candace','Chongyun',
    'Collei','Cyno','Dehya','Diluc','Diona','Eula','Faruzan','Fischl','Ganyu','Gorou','Hu_Tao',
    'Jean','Kaedehara_Kazuha','Kaeya','Kamisato_Ayaka','Kamisato_Ayato','Kaveh','Keqing','Kirara',
    'Klee','Kujou_Sara','Kuki_Shinobu','Layla','Lisa','Lumine','Mika','Mona','Nahida','Nilou',
    'Ningguang','Noelle','Qiqi','Raiden_Shogun','Razor','Rosaria','Sangonomiya_Kokomi','Sayu',
    'Shenhe','Shikanoin_Heizou','Sucrose','Tartaglia','Thoma','Tighnari','Venti','Wanderer',
    'Xiangling','Xiao','Xingqiu','Xinyan','Yae_Miko','Yanfei','Yaoyao','Yelan','Yoimiya','Yun_Jin',
    'Zhongli'
  ];

  final List<String> _results = [];

  List<String> teamCharacters = ['Empty', 'Empty', 'Empty', 'Empty'];
  int currentSlot = 0;

  /*
  List<String> rotCharacters = [];

  Container rotRow()
  {
    rotCharacters.add()

    return Container(

      child: Row(
        children: <Widget>[
          //Character icon
          InkWell( onTap: () {
            setState(() {

            });
            print(teamCharacters[currentSlot]);
          },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/${rotCharacters[slotNum]}.png'),
              backgroundColor: selectColor(slotNum),
              radius: slotRadius,
            ),
          ),


        ]

      )
    )

  }*/

  Container teamSlot(int slotNum){
    double slotRadius = 30.h;
    if (slotRadius > 65)
    {
      slotRadius = 65;
    }

    return Container(
        margin: EdgeInsets.only(left:3.w,right:3.w),
        child: Column(
            children: <Widget>[
              //Character icon
              InkWell( onTap: () {
              setState(() {
                currentSlot = slotNum;
                });
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/${teamCharacters[slotNum]}.png'),
                backgroundColor: selectColor(slotNum),
                radius: slotRadius,
                ),
              ),

              //X button
              RawMaterialButton(
                onPressed: () {
                  setState((){
                    currentSlot = slotNum;
                    teamCharacters[currentSlot] = 'Empty';
                  });
                },
                elevation: 2.0,
                fillColor: Colors.white,
                padding: EdgeInsets.all(3.h),
                shape: const CircleBorder(),
                child: Icon(Icons.close, size:15.h),
              ),

          ]
        )
    );
  }

  Color selectColor(int num){
    if (currentSlot == num)
    {
      return Colors.blueGrey[500]!;
    }
    return Colors.grey[500]!;
  }

  void _handleSearch(String input) {
    _results.clear();
    for (var str in characterSearch) {
      if (str.toLowerCase().contains(input.toLowerCase())) {
        setState(() {
          _results.add(str);
        });
      }
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

            //Character search section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: menuBox(),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                    width: 180.w,
                    child: TextField(
                      onChanged: _handleSearch,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff1f1f1),
                        border: OutlineInputBorder(),
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _results.isEmpty
                        ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1/1,
                            maxCrossAxisExtent: 100.h,),
                        itemCount: characterSearch.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: InkWell( onTap: () {
                              setState(() {
                                teamCharacters[currentSlot] = characterSearch[index];
                              });
                            },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/${characterSearch[index]}.png'),
                                  backgroundColor: Colors.grey[500],
                                  radius: 35.h,
                              ),
                            ),

                          );
                        })
                        : GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1/1,
                            maxCrossAxisExtent: 100.h,),
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: InkWell( onTap: () {
                              setState(() {
                                teamCharacters[currentSlot] = _results[index];
                              });
                            },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/${_results[index]}.png'),
                                  backgroundColor: Colors.grey[500],
                                  radius: 35.h,
                              ),
                            ),

                          );
                        }),
                  ),
                ],
              ),
            ),



            //Team builder section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              decoration: menuBox(),
              alignment: Alignment.topLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Section title
                    Container(
                      height: 30.h,
                      margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 1.h),
                      child: Text("Team Builder", style: TextStyle(fontSize: 20.h),),
                    ),

                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          teamSlot(0),
                          teamSlot(1),
                          teamSlot(2),
                          teamSlot(3),
                        ]
                      )
                    )


                  ]
              )
            ),


            //Rotation builder section
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              alignment: Alignment.topLeft,
              decoration: menuBox(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      /*/Section title
                      Container(
                        height: 30.h,
                        margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 1.h),
                        child: Text("Rotation Builder", style: TextStyle(fontSize: 20.h),),
                      ),
                      */

                    ]
                )
            ),


          ],
        ),
      ),

    );
  }
}