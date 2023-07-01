import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({super.key});

  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}



class _ResourcesPageState extends State<ResourcesPage> {

  final Uri keqingmains = Uri.parse('https://keqingmains.com/');
  final Uri keqingmainsLib = Uri.parse('https://library.keqingmains.com/');
  final Uri wiki = Uri.parse('https://genshin-impact.fandom.com/wiki/Genshin_Impact_Wiki');
  final Uri zy0x = Uri.parse('https://www.youtube.com/zy0xxx');
  final Uri zajef = Uri.parse('https://www.youtube.com/zajef77');
  final Uri leaks = Uri.parse('https://www.reddit.com/r/Genshin_Impact_Leaks/');


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
        title: const Text("Resources", style: TextStyle(color: Colors.black)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            //Input section
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*1.5,
                decoration: menuBox(),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15.w, top: 35.h),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "KeqingMains (KQM)   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                  TextSpan(
                                    text: "keqingmains.com",
                                    style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        launchUrl(keqingmains);
                                      }
                                  ),
                                  TextSpan(text: "\nKeqingMains (KQM) is a source for written character guides. They are very detailed and high-quality,"
                                      " although many are outdated. ",
                                          style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                ]
                              )
                            )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 15.w, top: 35.h),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "KeqingMainsLibrary   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                        TextSpan(
                                            text: "library.keqingmains.com",
                                            style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                launchUrl(keqingmains);
                                              }
                                        ),
                                        TextSpan(text: "\nThe KeqingMains Library is a database of information about the game, including information like "
                                            "character stats or equipment stats, but also more advanced theorycrafting findings such as frame data and exact ranges. ",
                                            style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                      ]
                                  )
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 15.w, top: 35.h),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "Genshin Impact Wiki   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                        TextSpan(
                                            text: "genshin-impact.fandom.com",
                                            style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                launchUrl(wiki);
                                              }
                                        ),
                                        TextSpan(text: "\nIn general, the KQM Library contains more information for theorycrafting and advanced mechanics than"
                                            "the wiki. However, the may have some pieces of information that the KQM Library does not; for instance,"
                                            "the KQM Library only has character multipliers at Talent lv9, while the wiki has them for all levels.",
                                            style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                      ]
                                  )
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(left: 15.w, top: 35.h),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "Zy0x   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                        TextSpan(
                                            text: "youtube.com/zy0xxx",
                                            style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                launchUrl(zy0x);
                                              }
                                        ),
                                        TextSpan(text: "\nZy0x posts comprehensive character guides that are easy to understand, as well as various other discussions. "
                                            "He does not go in-depth on theorycrafting, but is typically a trustworthy source.",
                                            style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                      ]
                                  )
                              )
                          ),


                          Container(
                              margin: EdgeInsets.only(left: 15.w, top: 35.h),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "Zajef77   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                        TextSpan(
                                            text: "youtube.com/zajef77",
                                            style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                launchUrl(zajef);
                                              }
                                        ),
                                        TextSpan(text: "\nZajef77 posts discussions on theorycrafting, and goes more in-depth on it than Zy0x does, but does not "
                                            "post guides. One very useful aspect of Zajef77's content is that he regularly hosts Q&A's where viewers can ask any "
                                            "questions, and outside of those Q&A's, viewers can also ask questions on his stream at twitch.tv/zajef77.",
                                            style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                      ]
                                  )
                              )
                          ),


                          Container(
                              margin: EdgeInsets.only(left: 15.w, top: 35.h),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "Genshin Leaks Subreddit   ", style: TextStyle(fontSize: 18.h, color: Colors.black)),
                                        TextSpan(
                                            text: "reddit.com/r/Genshin_Impact_Leaks/",
                                            style: TextStyle(fontSize: 14.h, color: Colors.blue),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                launchUrl(leaks);
                                              }
                                        ),
                                        TextSpan(text: "\nThis subreddit is one of the easiest way to view leaked information on upcoming game updates."
                                            " It is not always accurate and finding important information may require some searching.",
                                            style: TextStyle(fontSize: 14.h, color: Colors.black)),
                                      ]
                                  )
                              )
                          ),

                          SizedBox(height: 50.h),
                        ]
                    )
                )
            ),



          ],
        ),
      ),

    );
  }
}