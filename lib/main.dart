import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:tinder_swipe_cards_example/shared/styles.dart';

import 'models/user_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserDetails> userDetails = [
    new UserDetails(
        name: 'Mega Fox',
        age: 35,
        image:
            'https://image.gala.de/21844706/t/rI/v7/w1440/r0/-/meghan-fox-und-soehne.jpg',
        city: 'Tennessee'),
    new UserDetails(
        name: 'Ariana Grande',
        age: 27,
        image:
            'https://image.brigitte.de/11554052/t/K-/v3/w1440/r1.5/-/ariana-grande-teaser.jpg',
        city: 'Florida'),
    new UserDetails(
        name: 'Jennifer Aniston',
        age: 52,
        image:
            'https://image.gala.de/22088424/t/-O/v6/w1440/r1.5/-/jennifer-aniston.jpg',
        city: 'Los Angeles'),
    new UserDetails(
        name: 'Jeff Bezos',
        age: 57,
        image:
            'https://bilder.t-online.de/b/90/10/62/56/id_90106256/610/tid_da/das-gesicht-von-amazon-symbolbild-gruender-jeff-bezos-macht-nun-sein-ruecktrittsdatum-oeffentlich-.jpg',
        city: 'New Mexico'),
  ];

  CardController controller = new CardController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: TinderSwapCard(
          swipeUp: true,
          swipeDown: true,
          orientation: AmassOrientation.RIGHT,
          totalNum: userDetails.length,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: size.width * .9,
          maxHeight: size.height * 0.8,
          minWidth: size.width * 0.8,
          minHeight: size.height * 0.7,
          cardBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                        image: NetworkImage(userDetails[index].image), fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${userDetails[index].name}, ',
                              style: headlineTextStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              userDetails[index].age.toString(),
                              style: headlineTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          userDetails[index].city,
                          style: bodyTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {
                      controller.triggerLeft();
                    },
                    child: Container(
                        height: 65,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        margin: EdgeInsets.only(bottom: 100, left: 40),
                        child:
                            Icon(Icons.clear, color: Colors.white, size: 50)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      controller.triggerRight();
                    },
                    child: Container(
                      height: 65,
                      width: 75,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      margin: EdgeInsets.only(bottom: 100, right: 40),
                      child: Icon(Icons.check, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ],
            );
          },
          cardController: controller,
          swipeUpdateCallback:
              (DragUpdateDetails details, Alignment alignment) {
            if (alignment.x < 0) {
              print('Swipe Left');
            } else if (alignment.x > 0) {
              print('Swipe Right');
            }
          },
          swipeCompleteCallback:
              (CardSwipeOrientation orientation, int index) {},
        ),
      ),
    );
  }
}
