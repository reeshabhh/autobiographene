import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// Custom imports

import 'package:autobiographene/ui/comments_screen.dart';
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/curved_bottom_nav_bar.dart';


// import 'screens.dart';

String? textValGlobalTrending;
FirebaseStorage storageTrending = FirebaseStorage.instance;
final _textEditingControllerPosts = TextEditingController();
void clearTextPostTrending() {
  _textEditingControllerPosts.clear();
}

int iGlobalTrending = 0;
final snackBarTrending = SnackBar(
  content: Text('Yay! Your message was posted!'),
);

class TrendingScreenPaginatedDiscarded extends StatefulWidget {
  static const String id = 'trending_screen_paginated';

  @override
  _TrendingScreenPaginatedDiscardedState createState() => _TrendingScreenPaginatedDiscardedState();
}

class _TrendingScreenPaginatedDiscardedState extends State<TrendingScreenPaginatedDiscarded> {
  String? _printDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Trending Right Now!'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PaginateFirestore(
              //item builder type is compulsory.
              itemBuilder: (index, context, document) {
                final data = document.data() as Map?;
                // return ListTile(
                //   leading: CircleAvatar(child: Icon(Icons.person)),
                //   title: data == null
                //       ? Text('Error in data')
                //       : Text(data['Message']),
                //   subtitle: Text(documentSnapshot.id),
                // );
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Spacer(),
                          Container(
                            child: () {
                              Timestamp _timeStamp = data!['Datetime'];
                              var _timeStampToDate = _timeStamp.toDate();
                              final DateFormat formatter = DateFormat('d MMM');
                              final String formattedTimeStampToDate =
                                  formatter.format(_timeStampToDate);
                              // print(formattedTimeStampToDate);
                              final DateFormat formatterTime =
                                  DateFormat('h:mm aaa');
                              final String formattedTimeStampToDateTime =
                                  formatterTime.format(_timeStampToDate);
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
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white, //background color of box
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
                              '${data!['Message']}',
                              style: TextStyle(fontSize: 17, shadows: <Shadow>[
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            bool _addOrSubtractLikeBool = data['Liked_By']
                                .contains(loggedInUserGlobal!.email);
                            _addOrSubtractLikeBool
                                ? FirebaseFirestore.instance.runTransaction(
                                    (transaction) async {
                                      DocumentSnapshot freshSnapShot =
                                          await transaction
                                              .get(document.reference);
                                      transaction.update(
                                        freshSnapShot.reference,
                                        {
                                          'No_Of_Likes':
                                              freshSnapShot['No_Of_Likes'] - 1,
                                          'Liked_By': FieldValue.arrayRemove(
                                            [loggedInUserGlobal!.email],
                                          ),
                                        },
                                      );
                                      _addOrSubtractLikeBool = false;
                                    },
                                  )
                                : FirebaseFirestore.instance.runTransaction(
                                    (transaction) async {
                                      DocumentSnapshot freshSnapShot =
                                          await transaction
                                              .get(document.reference);
                                      transaction.update(
                                        freshSnapShot.reference,
                                        {
                                          'No_Of_Likes':
                                              freshSnapShot['No_Of_Likes'] + 1,
                                          'Liked_By': FieldValue.arrayUnion(
                                            [loggedInUserGlobal!.email],
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
                                data['Bookmarked_By']
                                    .contains(loggedInUserGlobal!.email);
                            _addOrSubtractBookmarkBool
                                ? FirebaseFirestore.instance.runTransaction(
                                    (transaction) async {
                                      DocumentSnapshot freshSnapShot =
                                          await transaction
                                              .get(document.reference);
                                      transaction.update(
                                        freshSnapShot.reference,
                                        {
                                          'No_Of_Bookmarks':
                                              freshSnapShot['No_Of_Bookmarks'] -
                                                  1,
                                          'Bookmarked_By':
                                              FieldValue.arrayRemove(
                                            [loggedInUserGlobal!.email],
                                          ),
                                        },
                                      );
                                      _addOrSubtractBookmarkBool = false;
                                    },
                                  )
                                : FirebaseFirestore.instance.runTransaction(
                                    (transaction) async {
                                      DocumentSnapshot freshSnapShot =
                                          await transaction
                                              .get(document.reference);
                                      transaction.update(
                                        freshSnapShot.reference,
                                        {
                                          'No_Of_Bookmarks':
                                              freshSnapShot['No_Of_Bookmarks'] +
                                                  1,
                                          'Bookmarked_By':
                                              FieldValue.arrayUnion(
                                            [loggedInUserGlobal!.email],
                                          ),
                                        },
                                      );
                                      _addOrSubtractBookmarkBool = true;
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
                            Navigator.pushNamed(context, CommentsScreen.id);
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
              // orderBy is compulsory to enable pagination
              query: FirebaseFirestore.instance
                  .collection('C_All_Posts')
                  .where("Is_Private", isEqualTo: false)
                  // .orderBy('Datetime', descending: true)
                  // .where("Is_Private", isEqualTo: false)
                  .orderBy('No_Of_Likes', descending: true),
              //Change types accordingly
              itemBuilderType: PaginateBuilderType.listView,
              // to fetch real-time data
              isLive: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedBottomNavBar(2),
    );
    // );
  }
}
