import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_storage/firebase_storage.dart';



// Custom imports
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/custom_bottom_app_bar.dart';


class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar_screen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
      // FIXME orderby with where does not work
  Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('C_All_Posts')
      // .orderBy(
      //   'Datetime',
      //   descending: true,
      // )
      .where('User_Id', isEqualTo: loggedInUserGlobal!.email)
       .snapshots();
  // _calendarController = _calendarController();
  var _selectedDay;
  var _focusedDay;
  // var _filterSelectedDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your calendar Screen'),
        ),
        body: Column(
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(
                  () {
                    // final now = new DateTime.now();
                    // String formatter =
                    //     DateFormat('yMd').format(now); // 28/03/2020
                    _selectedDay = selectedDay;
                    print('**************************************************');
                    print('selectedday $_selectedDay');
                    print('**************************************************');
                    // _filterSelectedDay = _selectedDay;
                    // DateTime calendarDateTime =
                    //                   _selectedDay.toDate();
                    // print(_selectedDay.toDate());

                    final DateFormat formatter = DateFormat('dd-MM-yyyy');
                    final String formatted = formatter.format(_selectedDay);
                    String ? email = loggedInUserGlobal!.email;
                    String userIdDateCalendar = email! +'_'+ formatted;
                    print(formatted);

                    print('**************************************************');
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                    _usersStream = FirebaseFirestore.instance
                        .collection('C_All_Posts')
                        .where('User_Id_Date',
                            isEqualTo: userIdDateCalendar)
                        // .orderBy('Datetime').startAt(_selectedDay)
                        // .where('User_Id', isEqualTo: loggedInUserGlobal!.email)
                        // .where('No_Of_Likes', isLessThanOrEqualTo: 1)
                        // .where('Datetime', isLessThan: _selectedDay)
                        // FIXME orderby with where does not work
                        // .orderBy(
                        //   'Datetime',
                        //   descending: true,
                        // ).startAt(_selectedDay).endAt(_selectedDay)
                        .snapshots();

                    // var query =
                    //     FirebaseFirestore.instance.collection('C_All_Posts');
                    //     query = query.where('User_Id', isEqualTo: loggedInUserGlobal!.email)

                    // StreamBuilder<QuerySnapshot>(
                    //   stream: _usersStream,
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     snapshot.data!.docs.map((DocumentSnapshot document) {
                    //       Map<String, dynamic> data =
                    //           document.data() as Map<String, dynamic>;
                    //       print(
                    //           '**************************************************');
                    //       print('datetime ${data['Datetime']}');
                    //       print(
                    //           '**************************************************');
                    //     });
                    //     return SizedBox();
                    //   },
                    // );
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(
                      '*******************************************************************');
                  print(
                    Error(),
                  );
                  print(
                    Error().stackTrace,
                  );
                  print(
                      '*******************************************************************');
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                if (snapshot.data!.size == 0) {
                  return Text('There is no post by you!');
                }
                // int msgCount = snapshot.data.size;
                return Expanded(
                  child: () {
                    // print(
                    //     '**********************************************************************');
                    // print('inside expanded');

                    // print(
                    //     '**********************************************************************');
                    return true;
                  }()
                      ? new ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map(
                            (DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return Expanded(
                                child: () {
                                  // print(
                                  //     '**********************************************************************');
                                  // DateTime fireBaseDateTime =
                                  //     data['Datetime'].toDate();
                                  // print(data['Datetime'].toDate());
                                  // print(data['Datetime'].toDate().toString());
                                  // final DateFormat formatter =
                                  //     DateFormat('yyyy-MM-dd');
                                  // final String formatted =
                                  //     formatter.format(fireBaseDateTime);
                                  // print(formatted);
                                  // print(
                                  //     '**********************************************************************');
                                  // print(data['Datetime'].toDate().runtimeType);
                                  // print(
                                  //     '**********************************************************************');
                                  return true;
                                }()
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // TODO Container's height will also depend on the message's length
                                          height: 200,
                                          margin: EdgeInsets.all(2),
                                          child: Column(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Container(
                                                  child: Text(
                                                      '${data['User_Id']}',
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ),
                                              // TODO this flex value will depend on the length of the text. I will have to convert different whole numbers depending on the length
                                              Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Container(
                                                    child: Text(
                                                        '${data['Message']}',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                  ),
                                                ),
                                              ),
                                              // TODO onpresed this icon should change and count will increase decrease depeding on how many times it has been clicked
                                              // Row(
                                              //   children: [
                                              //     // TODO Thumb up means you liked it heart means you have bookmarked it. You can bookmark comments as well
                                              //     Flexible(
                                              //       flex: 1,
                                              //       fit: FlexFit.tight,
                                              //       child: IconButton(
                                              //         onPressed: () {
                                              //           // NOTES *Start* - Naive solution
                                              //           // document.reference.update({
                                              //           //   'No_Of_Likes':
                                              //           //       document['No_Of_Likes'] + 1
                                              //           // });
                                              //           // NOTES *End* - Naive solution

                                              //           // NOTES *Start* - Better solution

                                              //           bool addOrSubtractLikeBool =
                                              //               data['Liked_By'].contains(
                                              //                   loggedInUserGlobal!
                                              //                       .email);
                                              //           addOrSubtractLikeBool
                                              //               ? FirebaseFirestore
                                              //                   .instance
                                              //                   .runTransaction(
                                              //                   (transaction) async {
                                              //                     DocumentSnapshot
                                              //                         freshSnapShot =
                                              //                         await transaction
                                              //                             .get(document
                                              //                                 .reference);
                                              //                     transaction
                                              //                         .update(
                                              //                       freshSnapShot
                                              //                           .reference,
                                              //                       {
                                              //                         'No_Of_Likes':
                                              //                             freshSnapShot[
                                              //                                     'No_Of_Likes'] -
                                              //                                 1,
                                              //                         'Liked_By':
                                              //                             FieldValue
                                              //                                 .arrayRemove(
                                              //                           [
                                              //                             loggedInUserGlobal!
                                              //                                 .email
                                              //                           ],
                                              //                         ),
                                              //                       },
                                              //                     );
                                              //                     print(
                                              //                         '============================================');
                                              //                     print(
                                              //                         'true ==  $addOrSubtractLikeBool');
                                              //                     print(
                                              //                         'subtracted likes');

                                              //                     print(data[
                                              //                         'Liked_By']);
                                              //                     // likeIconFlag = -1;
                                              //                     print(
                                              //                         '============================================');
                                              //                     addOrSubtractLikeBool =
                                              //                         false;
                                              //                   },
                                              //                 )
                                              //               : FirebaseFirestore
                                              //                   .instance
                                              //                   .runTransaction(
                                              //                   (transaction) async {
                                              //                     DocumentSnapshot
                                              //                         freshSnapShot =
                                              //                         await transaction
                                              //                             .get(document
                                              //                                 .reference);
                                              //                     transaction
                                              //                         .update(
                                              //                       freshSnapShot
                                              //                           .reference,
                                              //                       {
                                              //                         'No_Of_Likes':
                                              //                             freshSnapShot[
                                              //                                     'No_Of_Likes'] +
                                              //                                 1,
                                              //                         'Liked_By':
                                              //                             FieldValue
                                              //                                 .arrayUnion(
                                              //                           [
                                              //                             loggedInUserGlobal!
                                              //                                 .email
                                              //                           ],
                                              //                         ),
                                              //                       },
                                              //                     );
                                              //                     print(
                                              //                         '============================================');
                                              //                     print(
                                              //                         'false ==  $addOrSubtractLikeBool');
                                              //                     print(
                                              //                         'added likes');
                                              //                     // likeIconFlag = 1;
                                              //                     print(
                                              //                         '============================================');
                                              //                     addOrSubtractLikeBool =
                                              //                         true;
                                              //                   },
                                              //                 );

                                              //           // NOTES *End* - Better solution
                                              //           // print(
                                              //           //     '============================================');
                                              //           // print(addOrSubtractLikeBool);
                                              //           // print(
                                              //           //     '============================================');
                                              //         },

                                              //         icon: () {
                                              //           bool
                                              //               addOrSubtractLikeBoolAnonymous;
                                              //           return addOrSubtractLikeBoolAnonymous =
                                              //               data['Liked_By'].contains(
                                              //                   loggedInUserGlobal!
                                              //                       .email);
                                              //         }()
                                              //             ? Icon(
                                              //                 Icons
                                              //                     .recommend_outlined,
                                              //                 color: Colors.green,
                                              //               )
                                              //             : Icon(
                                              //                 Icons
                                              //                     .thumb_up_outlined,
                                              //                 color:
                                              //                     Colors.red[400],
                                              //               ),

                                              //         // addOrSubtractLikeBool
                                              //         //     ? Icon(Icons.thumb_up_alt)
                                              //         //     : Icon(Icons.emoji_emotions),
                                              //         // likeIconFlag == 1
                                              //         //     ? Icon(Icons.emoji_emotions)
                                              //         //     : Icon(Icons.favorite_border),

                                              //         // if (likeIconFlag==1){
                                              //         //   Icon(Icons.emoji_emotions)
                                              //         // }else if (likeIconFlag==-1) {
                                              //         //  Icon(Icons.favorite_border)
                                              //         // }else if (likeIconFlag==0) {
                                              //         //  Icon(Icons.favorite_border)

                                              //         // },

                                              //         // likeButtonBoolGlobal!
                                              //         //     ? Icon(Icons.thumb_up_off_alt)
                                              //         //     : Icon(
                                              //         //         Icons.thumb_up_off_alt,
                                              //         // ),
                                              //         // Icon(Icons.thumb_up_off_alt),
                                              //       ),
                                              //     ),
                                              //     Flexible(
                                              //       flex: 1,
                                              //       fit: FlexFit.tight,
                                              //       child: IconButton(
                                              //         onPressed: () {},
                                              //         icon: Icon(
                                              //           Icons.favorite_border,
                                              //           color: Colors.blue[400],
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     //TODO I will call comments notes
                                              //     Flexible(
                                              //       flex: 1,
                                              //       fit: FlexFit.tight,
                                              //       child: IconButton(
                                              //         onPressed: () {
                                              //           // FIXME idPost this is the post Id
                                              //           idPostComment =
                                              //               data['Post_Id'];
                                              //           print(
                                              //               '=====================================================');
                                              //           print(_usersStream);
                                              //           print(document.id);
                                              //           print(loggedInUserGlobal);
                                              //           print(loggedInUserGlobal!
                                              //               .email);
                                              //           print(
                                              //               '=====================================================');
                                              //           // print(
                                              //           //     '==============================================================');
                                              //           // print(data['Post_Id']);
                                              //           // print(
                                              //           //     '==============================================================');
                                              //           Navigator.pushNamed(context,
                                              //               CommentsScreen.id);
                                              //         },
                                              //         icon: Icon(
                                              //           Icons.notes,
                                              //           color: Colors.red[400],
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     Flexible(
                                              //       flex: 1,
                                              //       fit: FlexFit.tight,
                                              //       child: IconButton(
                                              //         onPressed: () {},
                                              //         icon: Icon(
                                              //           Icons.send,
                                              //           color: Colors.blue[400],
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              );
                              // FIXME end new code
                            },
                          ).toList(),
                        )
                      : () {
                          return SizedBox();
                        }(),
                );
              },
            ),
          ],
        )

        // TableCalendar(
        //   firstDay: DateTime.utc(2010, 10, 16),
        //   lastDay: DateTime.utc(2030, 3, 14),
        //   focusedDay: DateTime.now(),
        // ),Column(children: [],),
        // StreamBuilder<QuerySnapshot>(
        //   stream: _usersStream,
        //   builder: (BuildContext context,
        //       AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       print(
        //           '*******************************************************************');
        //       print(
        //         Error(),
        //       );
        //       print(
        //         Error().stackTrace,
        //       );
        //       print(
        //           '*******************************************************************');
        //       return Text('Something went wrong');
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }
        //     // int msgCount = snapshot.data.size;
        //     return Expanded(
        //       child: new ListView(
        //         physics: const AlwaysScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         children: snapshot.data!.docs.map(
        //           (DocumentSnapshot document) {
        //             Map<String, dynamic> data =
        //                 document.data() as Map<String, dynamic>;
        //             // likeIconFlag = 0;
        //             // addOrSubtractLikeBool = false;
        //             //TODO Now I can manipulate this container to achieve the desired result. Later I will have to extract this widget.

        //             // print(
        //             //     '=======================================================');
        //             // print(iGlobalTrending);
        //             // iGlobalTrending = iGlobalTrending + 1;
        //             // print(iGlobalTrending);
        //             // print(
        //             //     '=======================================================');
        //             return Expanded(
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   // TODO Container's height will also depend on the message's length
        //                   height: 200,
        //                   margin: EdgeInsets.all(2),
        //                   child: Column(
        //                     children: [
        //                       Flexible(
        //                         flex: 1,
        //                         fit: FlexFit.tight,
        //                         child: Container(
        //                           child: Text('${data['User_Id']}',
        //                               style: TextStyle(fontSize: 15)),
        //                         ),
        //                       ),
        //                       // TODO this flex value will depend on the length of the text. I will have to convert different whole numbers depending on the length
        //                       Flexible(
        //                         flex: 5,
        //                         fit: FlexFit.tight,
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(15.0),
        //                           child: Container(
        //                             child: Text('${data['Message']}',
        //                                 style: TextStyle(fontSize: 20)),
        //                           ),
        //                         ),
        //                       ),
        //                       // Flexible(
        //                       //   flex: 5,
        //                       //   fit: FlexFit.tight,
        //                       //   child: Padding(
        //                       //     padding: const EdgeInsets.all(15.0),
        //                       //     child: Container(
        //                       //       child: Text('${data['Post_Id']}',
        //                       //           style: TextStyle(fontSize: 20)),
        //                       //     ),
        //                       //   ),
        //                       // ),
        //                       // TODO onpresed this icon should change and count will increase decrease depeding on how many times it has been clicked
        //                       Row(
        //                         children: [
        //                           // TODO Thumb up means you liked it heart means you have bookmarked it. You can bookmark comments as well
        //                           Flexible(
        //                             flex: 1,
        //                             fit: FlexFit.tight,
        //                             child: IconButton(
        //                               onPressed: () {
        //                                 // NOTES *Start* - Naive solution
        //                                 // document.reference.update({
        //                                 //   'No_Of_Likes':
        //                                 //       document['No_Of_Likes'] + 1
        //                                 // });
        //                                 // NOTES *End* - Naive solution

        //                                 // NOTES *Start* - Better solution

        //                                 bool addOrSubtractLikeBool =
        //                                     data['Liked_By'].contains(
        //                                         loggedInUserGlobal!.email);
        //                                 addOrSubtractLikeBool
        //                                     ? FirebaseFirestore.instance
        //                                         .runTransaction(
        //                                         (transaction) async {
        //                                           DocumentSnapshot
        //                                               freshSnapShot =
        //                                               await transaction.get(
        //                                                   document
        //                                                       .reference);
        //                                           transaction.update(
        //                                             freshSnapShot.reference,
        //                                             {
        //                                               'No_Of_Likes':
        //                                                   freshSnapShot[
        //                                                           'No_Of_Likes'] -
        //                                                       1,
        //                                               'Liked_By': FieldValue
        //                                                   .arrayRemove(
        //                                                 [
        //                                                   loggedInUserGlobal!
        //                                                       .email
        //                                                 ],
        //                                               ),
        //                                             },
        //                                           );
        //                                           print(
        //                                               '============================================');
        //                                           print(
        //                                               'true ==  $addOrSubtractLikeBool');
        //                                           print('subtracted likes');

        //                                           print(data['Liked_By']);
        //                                           // likeIconFlag = -1;
        //                                           print(
        //                                               '============================================');
        //                                           addOrSubtractLikeBool =
        //                                               false;
        //                                         },
        //                                       )
        //                                     : FirebaseFirestore.instance
        //                                         .runTransaction(
        //                                         (transaction) async {
        //                                           DocumentSnapshot
        //                                               freshSnapShot =
        //                                               await transaction.get(
        //                                                   document
        //                                                       .reference);
        //                                           transaction.update(
        //                                             freshSnapShot.reference,
        //                                             {
        //                                               'No_Of_Likes':
        //                                                   freshSnapShot[
        //                                                           'No_Of_Likes'] +
        //                                                       1,
        //                                               'Liked_By': FieldValue
        //                                                   .arrayUnion(
        //                                                 [
        //                                                   loggedInUserGlobal!
        //                                                       .email
        //                                                 ],
        //                                               ),
        //                                             },
        //                                           );
        //                                           print(
        //                                               '============================================');
        //                                           print(
        //                                               'false ==  $addOrSubtractLikeBool');
        //                                           print('added likes');
        //                                           // likeIconFlag = 1;
        //                                           print(
        //                                               '============================================');
        //                                           addOrSubtractLikeBool =
        //                                               true;
        //                                         },
        //                                       );

        //                                 // NOTES *End* - Better solution
        //                                 // print(
        //                                 //     '============================================');
        //                                 // print(addOrSubtractLikeBool);
        //                                 // print(
        //                                 //     '============================================');
        //                               },

        //                               icon: () {
        //                                 bool addOrSubtractLikeBoolAnonymous;
        //                                 return addOrSubtractLikeBoolAnonymous =
        //                                     data['Liked_By'].contains(
        //                                         loggedInUserGlobal!.email);
        //                               }()
        //                                   ? Icon(
        //                                       Icons.recommend_outlined,
        //                                       color: Colors.green,
        //                                     )
        //                                   : Icon(
        //                                       Icons.thumb_up_outlined,
        //                                       color: Colors.red[400],
        //                                     ),

        //                               // addOrSubtractLikeBool
        //                               //     ? Icon(Icons.thumb_up_alt)
        //                               //     : Icon(Icons.emoji_emotions),
        //                               // likeIconFlag == 1
        //                               //     ? Icon(Icons.emoji_emotions)
        //                               //     : Icon(Icons.favorite_border),

        //                               // if (likeIconFlag==1){
        //                               //   Icon(Icons.emoji_emotions)
        //                               // }else if (likeIconFlag==-1) {
        //                               //  Icon(Icons.favorite_border)
        //                               // }else if (likeIconFlag==0) {
        //                               //  Icon(Icons.favorite_border)

        //                               // },

        //                               // likeButtonBoolGlobal!
        //                               //     ? Icon(Icons.thumb_up_off_alt)
        //                               //     : Icon(
        //                               //         Icons.thumb_up_off_alt,
        //                               // ),
        //                               // Icon(Icons.thumb_up_off_alt),
        //                             ),
        //                           ),
        //                           Flexible(
        //                             flex: 1,
        //                             fit: FlexFit.tight,
        //                             child: IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(
        //                                 Icons.favorite_border,
        //                                 color: Colors.blue[400],
        //                               ),
        //                             ),
        //                           ),
        //                           //TODO I will call comments notes
        //                           Flexible(
        //                             flex: 1,
        //                             fit: FlexFit.tight,
        //                             child: IconButton(
        //                               onPressed: () {
        //                                 // FIXME idPost this is the post Id
        //                                 // idPostComment = data['Post_Id'];
        //                                 print(
        //                                     '=====================================================');
        //                                 print(_usersStream);
        //                                 print(document.id);
        //                                 print(loggedInUserGlobal);
        //                                 print(loggedInUserGlobal!.email);
        //                                 print(
        //                                     '=====================================================');
        //                                 // print(
        //                                 //     '==============================================================');
        //                                 // print(data['Post_Id']);
        //                                 // print(
        //                                 //     '==============================================================');
        //                                 Navigator.pushNamed(
        //                                     context, CommentsScreen.id);
        //                               },
        //                               icon: Icon(
        //                                 Icons.notes,
        //                                 color: Colors.red[400],
        //                               ),
        //                             ),
        //                           ),
        //                           Flexible(
        //                             flex: 1,
        //                             fit: FlexFit.tight,
        //                             child: IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(
        //                                 Icons.send,
        //                                 color: Colors.blue[400],
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   // child: Center(
        //                   //   child: Text(
        //                   //     '${data['message']} (${data['userid']})',
        //                   //     style: TextStyle(fontSize: 50),
        //                   //   ),
        //                   // ),
        //                 ),
        //               ),
        //             );
        //             // FIXME end new code
        //           },
        //         ).toList(),
        //       ),
        //     );
        //   },
        // ),

        // ),
        ,
        bottomNavigationBar: CustomBottomAppBar(),
      ),
    );
  }
}
