import 'package:autobiographene/widgets/curved_bottom_nav_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

// Custom imports
import '../widgets/widgets.dart';
import 'screens.dart';
// import '/ui_widgets/home_screen_ui_widget/custom_colored_box.dart';
//TODO
// import 'private_screen.dart';
// TODO think about it -I don't think it is
// required because we already have calendar view - 25-July-2021

// User? loggedInUserGlobal;
FirebaseStorage storage = FirebaseStorage.instance;
// String ? emailLoggedInUserGlobal = loggedInUserGlobal.email;

class HomeScreenTest extends StatefulWidget {
  static const String id = 'home_screen_test';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenTest> {
  String userInput = '';
  // TODO elevate the snackbar
  final _snackBarPost = SnackBar(
    content: Text('Yay! Your message was posted!'),
    elevation: 2,
  );
  String? _textValPost;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  //new start
  // // Query? col;
  // CollectionReference col =
  //     FirebaseFirestore.instance.collection("C_All_Posts");

  // Query nameQuery = col.where('nome', isEqualTo: 'Tyg');
  // Query nameValorQuery = nameQuery.where('valor', isLessThan: '39');
// new end

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('C_All_Posts')
      .orderBy('Datetime', descending: true)
      .where("Is_Private", isEqualTo: false)
      .snapshots();
  final _textEditingControllerPosts = TextEditingController();
  void _clearTextPost() {
    _textEditingControllerPosts.clear();
  }

  String? _printDateTime;
  bool isPrivate = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUserGlobal = user;
      }
    } catch (e) {
      print(e);
    }
  }

  var textValueHome = 'Privacy off';

  // FIXME This is broken it is not working it just implemented the pull down animation
  Future<void> _getDataRefresh() async {
    setState(
      () {
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading ${snapshot.error}");
            }
            print(
                '=====================================================================');
            print('data is there');
            print(
                '=====================================================================');
            return Text('data is there');
          },
        );
      },
    );
  }

  // var email = loggedInUserGlobal!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CircleAvatar(
          backgroundColor: Colors.white,
          // radius: 70,
          child: Icon(
            Icons.auto_stories_outlined,
            // size: 80,
            color: Colors.red,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textEditingControllerPosts,
              onChanged: (String value) {
                _textValPost = value;
              },
              decoration: InputDecoration(
                hintText: 'How did it go?', // TODO: This will be random
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          // CustomRow(firestore: _firestore),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0.0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // CustomPrivacySwitch(),
                Column(
                  children: [
                    Transform.scale(
                      scale: 1,
                      child: Switch(
                        value: isPrivate,
                        // NOTES is it mutating state inside build method?
                        onChanged: (isOn) => setState(() => isPrivate = isOn),
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.yellow,
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.orange,
                      ),
                    ),
                    Text(isPrivate ? 'Private' : 'Public'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 80, height: 30),
                    child: ElevatedButton(
                      child: Text('Post'),
                      style: ElevatedButton.styleFrom(
                        // fixedSize: ,
                        primary: Colors.teal,
                        onPrimary: Colors.black,
                        onSurface: Colors.blue,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        // splashFactory: InkRipple.splashFactory,
                      ),
                      // style: ButtonStyle(
                      //   overlayColor: MaterialStateProperty.resolveWith(
                      //     (states) {
                      //       return states.contains(MaterialState.pressed)
                      //           ? Colors.orange
                      //           : null;
                      //     },
                      //   ),
                      // ),
                      onPressed: () {
                        _textValPost == null || _textValPost!.length == 0
                            ? Fluttertoast.showToast(
                                msg: 'Please type something to continue',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                // timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.yellow)
                            : () {
                                isPrivate
                                    //         //TODO if privacy is on then save in a different way
                                    ? () {
                                        try {
                                          // print(
                                          //     '******************************************************');
                                          var _now = DateTime.now();
                                          var _uuidPost = Uuid();
                                          final _idPost = _uuidPost.v1();
                                          final DateFormat formatter =
                                              DateFormat('dd-MM-yyyy');
                                          final String formattedNow =
                                              formatter.format(_now);
                                          String? email =
                                              loggedInUserGlobal!.email;
                                          String? userIdDate =
                                              email! + '_' + formattedNow;
                                          _firestore
                                              .collection('C_All_Posts')
                                              .add(
                                            {
                                              'Datetime': _now,
                                              'Message': _textValPost,
                                              'User_Id':
                                                  loggedInUserGlobal!.email,
                                              'Post_Id': _idPost,
                                              'No_Of_Likes': 0,
                                              'No_Of_Shares': 0,
                                              'No_Of_Bookmarks': 0,
                                              'No_Of_Comments': 0,
                                              'Liked_By': [],
                                              'Bookmarked_By': [],
                                              'User_Id_Date': userIdDate,
                                              'Is_Private': true,
                                            },
                                          );
                                          _textValPost = null;
                                          _clearTextPost();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(_snackBarPost);
                                        } catch (e) {
                                          print(e);
                                        }
                                      }()
                                    : () {
                                        try {
                                          // print(
                                          //     '======================================================');

                                          var _now = DateTime.now();
                                          var _uuidPost = Uuid();
                                          final _idPost = _uuidPost.v1();
                                          final DateFormat formatter =
                                              DateFormat('dd-MM-yyyy');
                                          final String formattedNow =
                                              formatter.format(_now);
                                          String? email =
                                              loggedInUserGlobal!.email;
                                          String? userIdDate =
                                              email! + '_' + formattedNow;
                                          // _firestore.collection.get
                                          _firestore
                                              .collection('C_All_Posts')
                                              .add(
                                            {
                                              'Datetime': _now,
                                              'Message': _textValPost,
                                              'User_Id':
                                                  loggedInUserGlobal!.email,
                                              'Post_Id': _idPost,
                                              'No_Of_Likes': 0,
                                              'No_Of_Shares': 0,
                                              'No_Of_Bookmarks': 0,
                                              'No_Of_Comments': 0,
                                              'Liked_By': [],
                                              'Bookmarked_By': [],
                                              'User_Id_Date': userIdDate,
                                              'Is_Private': false,
                                            },
                                          );
                                          _textValPost = null;
                                          _clearTextPost();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(_snackBarPost);
                                        } catch (e) {
                                          print(e);
                                        }
                                      }();
                              }();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading ${snapshot.error}");
              }
              // int msgCount = snapshot.data.size;
              else {
                // print(
                //     '=========================================================================');
                // print(
                //     'homescreentest - Else has been called that is inside builder of snapshot');
                // print(
                //     '=========================================================================');
                // return true
                //     ? () {
                //         print(
                //             '=========================================================================');
                //         print('homescreentest - before expanded is returned');
                //         print(
                //             '=========================================================================');

                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: _getDataRefresh,
                    child: ListView(
                      // scrollDirection: Axis.horizontal,
                      // physics: const AlwaysScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      // ? () {
                      //     print(
                      //         '=========================================================================');
                      //     print('homescreentest - returning true');
                      //     print(
                      //         '=========================================================================');
                      //     return true;
                      //   }()
                      // : () {
                      //     return false;
                      //   }(),
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          //TODO _Now I can manipulate this container to achieve the desired result. Later I will have to extract this widget.
                          return Column(
                            children: [
                              // Divider(
                              //   color: Colors.grey,
                              //   height: 40.0,
                              //   thickness: 2.0,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Spacer(),
                                    Container(
                                      child: () {
                                        Timestamp _timeStamp = data['Datetime'];
                                        var _timeStampToDate =
                                            _timeStamp.toDate();
                                        final DateFormat formatter =
                                            DateFormat('d MMM');
                                        final String formattedTimeStampToDate =
                                            formatter.format(_timeStampToDate);
                                        // print(formattedTimeStampToDate);
                                        final DateFormat formatterTime =
                                            DateFormat('h:mm aaa');
                                        final String
                                            formattedTimeStampToDateTime =
                                            formatterTime
                                                .format(_timeStampToDate);
                                        // print(formattedTimeStampToDateTime);
                                        _printDateTime = '${data['User_Id']} ' +
                                                'posted on ' +
                                                formattedTimeStampToDate +
                                                ' at ' +
                                                formattedTimeStampToDateTime
                                            // +
                                            // ' privacy = '
                                            //     '${data['Is_Private']}'
                                            ;
                                        // print(_printDateTime);
                                        return true;
                                      }()
                                          ? Expanded(
                                              child: Text(
                                                '$_printDateTime',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 0.0,
                                thickness: 0.3,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(
                              //       20.0, 10.0, 20.0, 10.0),
                              //   child:
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(5.0),

                              // Container(
                              // height:
                              //     (data['Message'].length / 50).ceil() * 20.0,
                              // height: double.infinity,
                              // width: double.infinity,
                              // height: 600.0,
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(10),
                              //       topRight: Radius.circular(10),
                              //       bottomLeft: Radius.circular(10),
                              //       bottomRight: Radius.circular(10)),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey.withOpacity(0.5),
                              //       spreadRadius: 5,
                              //       blurRadius: 7,
                              //       offset: Offset(
                              //           0, 3), // changes position of shadow
                              //     ),
                              //   ],
                              // ),

                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(5.0),
                              //   color: Colors.white,
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey,
                              //       offset: Offset(0.0, 1.0), //(x,y)
                              //       blurRadius: 6.0,
                              //     ),
                              //   ],
                              // ),

                              // margin: EdgeInsets.all(6.0),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(8.0),
                              //   color: Colors.white,
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.black,
                              //       blurRadius: 2.0,
                              //       spreadRadius: 0.0,
                              //       offset: Offset(2.0,
                              //           2.0,), // shadow direction: bottom right
                              //     )
                              //   ],
                              // ),

                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(15.0),
                              //   color: Colors.white, //background color of box
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey,
                              //       blurRadius: 10.0, // soften the shadow
                              //       // spreadRadius: 5.0, //extend the shadow
                              //       offset: Offset(
                              //         2.0, // Move to right 10  horizontally
                              //         2.0, // Move to bottom 10 Vertically
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // child:
                              // true
                              //     ? () {
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color:
                                        Colors.white, //background color of box
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 5.0, // soften the shadow
                                        spreadRadius: 3.0, //extend the shadow
                                        offset: Offset(
                                          1.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        '${data['Message']}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            shadows: <Shadow>[
                                              // Shadow(
                                              //   offset: Offset(10.0, 10.0),
                                              //   blurRadius: 3.0,
                                              //   color: Color.fromARGB(255, 0, 0, 0),
                                              // ),
                                              // Shadow(
                                              //   offset: Offset(10.0, 10.0),
                                              //   blurRadius: 8.0,
                                              //   color: Color.fromARGB(125, 0, 0, 255),
                                              // ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // ;
                              // print(
                              //     '=========================================================================');
                              // print(
                              //     'homescreentest - Text of data[message] has been called');
                              // print(
                              //     '=========================================================================');
                              //   }()
                              // : SizedBox(),
                              // ),
                              // ),
                              // ),
                              Divider(
                                color: Colors.grey,
                                height: 0.0,
                                thickness: 0.4,
                              ),
                              // START Like bookmark strip starts from here
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      bool _addOrSubtractLikeBool =
                                          data['Liked_By'].contains(
                                              loggedInUserGlobal!.email);
                                      _addOrSubtractLikeBool
                                          ? FirebaseFirestore.instance
                                              .runTransaction(
                                              (transaction) async {
                                                DocumentSnapshot freshSnapShot =
                                                    await transaction.get(
                                                        document.reference);
                                                transaction.update(
                                                  freshSnapShot.reference,
                                                  {
                                                    'No_Of_Likes':
                                                        freshSnapShot[
                                                                'No_Of_Likes'] -
                                                            1,
                                                    'Liked_By':
                                                        FieldValue.arrayRemove(
                                                      [
                                                        loggedInUserGlobal!
                                                            .email
                                                      ],
                                                    ),
                                                  },
                                                );
                                                _addOrSubtractLikeBool = false;
                                              },
                                            )
                                          : FirebaseFirestore.instance
                                              .runTransaction(
                                              (transaction) async {
                                                DocumentSnapshot freshSnapShot =
                                                    await transaction.get(
                                                        document.reference);
                                                transaction.update(
                                                  freshSnapShot.reference,
                                                  {
                                                    'No_Of_Likes':
                                                        freshSnapShot[
                                                                'No_Of_Likes'] +
                                                            1,
                                                    'Liked_By':
                                                        FieldValue.arrayUnion(
                                                      [
                                                        loggedInUserGlobal!
                                                            .email
                                                      ],
                                                    ),
                                                  },
                                                );
                                                _addOrSubtractLikeBool = true;
                                              },
                                            );
                                    },
                                    icon: () {
                                      return data['Liked_By']
                                          .contains(loggedInUserGlobal!.email);
                                    }()
                                        ? Icon(
                                            Icons.recommend_outlined,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.thumb_up_outlined,
                                            color: Colors.red[400],
                                          ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bool _addOrSubtractBookmarkBool =
                                          data['Bookmarked_By'].contains(
                                              loggedInUserGlobal!.email);
                                      _addOrSubtractBookmarkBool
                                          ? FirebaseFirestore.instance
                                              .runTransaction(
                                              (transaction) async {
                                                DocumentSnapshot freshSnapShot =
                                                    await transaction.get(
                                                        document.reference);
                                                transaction.update(
                                                  freshSnapShot.reference,
                                                  {
                                                    'No_Of_Bookmarks':
                                                        freshSnapShot[
                                                                'No_Of_Bookmarks'] -
                                                            1,
                                                    'Bookmarked_By':
                                                        FieldValue.arrayRemove(
                                                      [
                                                        loggedInUserGlobal!
                                                            .email
                                                      ],
                                                    ),
                                                  },
                                                );
                                                _addOrSubtractBookmarkBool =
                                                    false;
                                              },
                                            )
                                          : FirebaseFirestore.instance
                                              .runTransaction(
                                              (transaction) async {
                                                DocumentSnapshot freshSnapShot =
                                                    await transaction.get(
                                                        document.reference);
                                                transaction.update(
                                                  freshSnapShot.reference,
                                                  {
                                                    'No_Of_Bookmarks':
                                                        freshSnapShot[
                                                                'No_Of_Bookmarks'] +
                                                            1,
                                                    'Bookmarked_By':
                                                        FieldValue.arrayUnion(
                                                      [
                                                        loggedInUserGlobal!
                                                            .email
                                                      ],
                                                    ),
                                                  },
                                                );
                                                _addOrSubtractBookmarkBool =
                                                    true;
                                              },
                                            );
                                    },
                                    icon: () {
                                      return data['Bookmarked_By']
                                          .contains(loggedInUserGlobal!.email);
                                    }()
                                        ? Icon(
                                            Icons.favorite_outlined,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.red[400],
                                          ),
                                  ),
                                  //TODO I will call comments notes
                                  IconButton(
                                    onPressed: () {
                                      // FIXME _idPost this is the post Id
                                      idPostComment = data['Post_Id'];
                                      Navigator.pushNamed(
                                          context, CommentsScreen.id);
                                    },
                                    icon: Icon(
                                      Icons.notes,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.blue[400],
                                    ),
                                  ),
                                ],
                              ),
                              // END Like and bookmark etc strip ends here
                              Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                                height: 0.0,
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
                //   }()
                // : () {
                //     SizedBox();
                //   }();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
