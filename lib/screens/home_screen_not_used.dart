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
// TODO
// import 'private_screen.dart';
// TODO think about it -I don't think it is
// required because we already have calendar view - 25-July-2021

User? loggedInUserGlobal;
FirebaseStorage storage = FirebaseStorage.instance;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                                          print(
                                              '******************************************************');
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
                                          print(
                                              '======================================================');

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
              // print(
              //     '=========================================================================');
              // print(
              //     'homescreen - homescreen inside the builder after buildcontext');
              // print(
              //     '=========================================================================');
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              // int msgCount = snapshot.data.size;
              else {
                // print(
                //     '=========================================================================');
                // print(
                //     'homescreen - Else has been called that is inside builder of snapshot');
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
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // TODO Container's height will also depend on the message's length
                              height: 200,
                              // height: (data['Message'].length / 50).ceil() * 200.0,
                              // height: () {
                              //   var containerHeightLen = data['Message'].length;
                              //   double containerHeightDouble =
                              //       (containerHeightLen / 45).ceil() * 22.0;
                              //   return containerHeightDouble;
                              // }(),
                              // height: 400,
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        // Flexible(
                                        //   flex: 1,
                                        //   fit: FlexFit.tight,
                                        //   child: Container(
                                        //     child: Text(
                                        //       '${data['User_Id']}',
                                        //       style: TextStyle(
                                        //           fontSize: 20,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ),
                                        // ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            child: () {
                                              Timestamp _timeStamp =
                                                  data['Datetime'];
                                              // print(_timeStamp);
                                              var _timeStampToDate =
                                                  _timeStamp.toDate();
                                              final DateFormat formatter =
                                                  DateFormat('d MMM');
                                              final String
                                                  formattedTimeStampToDate =
                                                  formatter
                                                      .format(_timeStampToDate);
                                              // print(_timeStampToDate);

                                              print(formattedTimeStampToDate);
                                              final DateFormat formatterTime =
                                                  DateFormat('h:mm aaa');
                                              final String
                                                  formattedTimeStampToDateTime =
                                                  formatterTime
                                                      .format(_timeStampToDate);
                                              print(
                                                  formattedTimeStampToDateTime);

                                              // print(_timeStampToDate.toString());
                                              _printDateTime = '${data['User_Id']} ' +
                                                  'posted on ' +
                                                  formattedTimeStampToDate +
                                                  ' at ' +
                                                  formattedTimeStampToDateTime +
                                                  ' privacy = '
                                                      '${data['Is_Private']}';
                                              print(_printDateTime);
                                              return true;
                                            }()
                                                ? Text(
                                                    '$_printDateTime',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // TODO this flex value will depend on the length of the text. I will have to convert different whole numbers depending on the length
                                  Flexible(
                                    flex: 4,
                                    // true
                                    //     ? () {
                                    //         var flexLen = data['Message'].length;
                                    //         int flexVal = (flexLen / 45).ceil();
                                    //         return flexVal;
                                    //       }()
                                    //     : 0,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        child: Text(
                                          '${data['Message']}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: IconButton(
                                            onPressed: () {
                                              bool _addOrSubtractLikeBool =
                                                  data['Liked_By'].contains(
                                                      loggedInUserGlobal!
                                                          .email);
                                              _addOrSubtractLikeBool
                                                  ? FirebaseFirestore.instance
                                                      .runTransaction(
                                                      (transaction) async {
                                                        DocumentSnapshot
                                                            freshSnapShot =
                                                            await transaction
                                                                .get(document
                                                                    .reference);
                                                        transaction.update(
                                                          freshSnapShot
                                                              .reference,
                                                          {
                                                            'No_Of_Likes':
                                                                freshSnapShot[
                                                                        'No_Of_Likes'] -
                                                                    1,
                                                            'Liked_By':
                                                                FieldValue
                                                                    .arrayRemove(
                                                              [
                                                                loggedInUserGlobal!
                                                                    .email
                                                              ],
                                                            ),
                                                          },
                                                        );
                                                        _addOrSubtractLikeBool =
                                                            false;
                                                      },
                                                    )
                                                  : FirebaseFirestore.instance
                                                      .runTransaction(
                                                      (transaction) async {
                                                        DocumentSnapshot
                                                            freshSnapShot =
                                                            await transaction
                                                                .get(document
                                                                    .reference);
                                                        transaction.update(
                                                          freshSnapShot
                                                              .reference,
                                                          {
                                                            'No_Of_Likes':
                                                                freshSnapShot[
                                                                        'No_Of_Likes'] +
                                                                    1,
                                                            'Liked_By':
                                                                FieldValue
                                                                    .arrayUnion(
                                                              [
                                                                loggedInUserGlobal!
                                                                    .email
                                                              ],
                                                            ),
                                                          },
                                                        );
                                                        _addOrSubtractLikeBool =
                                                            true;
                                                      },
                                                    );
                                            },
                                            icon: () {
                                              return data['Liked_By'].contains(
                                                  loggedInUserGlobal!.email);
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
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: IconButton(
                                            onPressed: () {
                                              bool _addOrSubtractBookmarkBool =
                                                  data['Bookmarked_By']
                                                      .contains(
                                                          loggedInUserGlobal!
                                                              .email);
                                              _addOrSubtractBookmarkBool
                                                  ? FirebaseFirestore.instance
                                                      .runTransaction(
                                                      (transaction) async {
                                                        DocumentSnapshot
                                                            freshSnapShot =
                                                            await transaction
                                                                .get(document
                                                                    .reference);
                                                        transaction.update(
                                                          freshSnapShot
                                                              .reference,
                                                          {
                                                            'No_Of_Bookmarks':
                                                                freshSnapShot[
                                                                        'No_Of_Bookmarks'] -
                                                                    1,
                                                            'Bookmarked_By':
                                                                FieldValue
                                                                    .arrayRemove(
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
                                                        DocumentSnapshot
                                                            freshSnapShot =
                                                            await transaction
                                                                .get(document
                                                                    .reference);
                                                        transaction.update(
                                                          freshSnapShot
                                                              .reference,
                                                          {
                                                            'No_Of_Bookmarks':
                                                                freshSnapShot[
                                                                        'No_Of_Bookmarks'] +
                                                                    1,
                                                            'Bookmarked_By':
                                                                FieldValue
                                                                    .arrayUnion(
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
                                                  .contains(loggedInUserGlobal!
                                                      .email);
                                            }()
                                                ? Icon(
                                                    Icons.favorite_outlined,
                                                    color: Colors.green,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Colors.red[400],
                                                  ),
                                          ),
                                        ),
                                        //TODO I will call comments notes
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: IconButton(
                                            onPressed: () {
                                              // FIXME _idPost this is the post Id
                                              idPostComment = data['Post_Id'];
                                              // print(
                                              //     '=====================================================');
                                              // print(_usersStream);
                                              // print(document.id);
                                              // print(loggedInUserGlobal);
                                              // print(loggedInUserGlobal!.email);
                                              // print(
                                              //     '=====================================================');
                                              // print(
                                              //     '==============================================================');
                                              // print(data['Post_Id']);
                                              // print(
                                              //     '==============================================================');
                                              Navigator.pushNamed(
                                                  context, CommentsScreen.id);
                                            },
                                            icon: Icon(
                                              Icons.notes,
                                              color: Colors.red[400],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.blue[400],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 2.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // FIXME end new code
                      },
                    ).toList(),
                  ),
                );
                //   }()
                // : () {
                //     return SizedBox();
                //   }();
                // }
              }
            },
          ),
        ],
      ),
      // ),

      // ),
      bottomNavigationBar: CurvedBottomNavBar(0),
    );
  }
}

// class CustomRow extends StatefulWidget {
//   const CustomRow({
//     Key key,
//     @required FirebaseFirestore firestore,
//     // @required this.textVal,
//   })  : _firestore = firestore,
//         super(key: key);

//   final FirebaseFirestore _firestore;

//   @override
//   _CustomRowState createState() => _CustomRowState();
// }

// class _CustomRowState extends State<CustomRow> {
//   Future selectFile() async {
//     print('inside selectfile');
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) return;
//     final path = result.files.single.path;

//     // setState(() => file = File(path));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(15, 0.0, 15, 10),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             flex: 1,
//             fit: FlexFit.tight,
//             child: Ink(
//               decoration: const ShapeDecoration(
//                 color: Colors.lightBlue,
//                 shape: CircleBorder(),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.camera_alt_outlined),
//                 color: Colors.white,
//                 onPressed: () {
//                   print('before selectfile');
//                   // selectFile;
//                   final picker = ImagePicker();

//                   Future pickImage() async {
//                     final pickedFile =
//                         await picker.pickImage(source: ImageSource.camera);

//                     // setState(() {
//                     //   _imageFile = File(pickedFile.path);
//                     // });
//                   }

//                   print('after selectfile');
//                 },
//               ),
//             ),
//           ),
//           Flexible(
//             flex: 2,
//             fit: FlexFit.tight,
//             child: CustomPrivacySwitch(),
//           ),
//           Flexible(
//             flex: 3,
//             fit: FlexFit.tight,
//             child: ElevatedButton(
//               child: Text('Submit'),
//               onPressed: () {
//                 var _now = new DateTime._now();
//                 try {
//                   widget._firestore.collection('users').add(
//                     {
//                       'datetime': _now,
//                       'message': _textValPost,
//                       'userid': loggedInUserGlobal.email,
//                     },
//                   );
//                   Navigator.pushNamed(context, AfterSubmitScreen.id);
//                   print('_now : $_now');
//                   print('_textValPost : $_textValPost');
//                   print(
//                       'loggedInUserGlobal.email : ${loggedInUserGlobal.email}');
//                 } catch (e) {
//                   print(e);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// File ? file;

// class CustomColoredBox extends StatelessWidget {
//   const CustomColoredBox({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: Colors.teal,
//       child: Row(
//         children: [
//           Ink(
//             decoration: const ShapeDecoration(
//               color: Colors.lightBlue,
//               shape: CircleBorder(),
//             ),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()),
//                 );
//               },
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Ink(
//             decoration: const ShapeDecoration(
//               color: Colors.lightBlue,
//               shape: CircleBorder(),
//             ),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => PrivateScreen()),
//                 );
//               },
//               icon: Icon(
//                 Icons.lock,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 50,
//   ),
//   Center(
//     child: CustomPrivacySwitch(),
//   ),
// ],
//       ),
//     );
//   }
// }
