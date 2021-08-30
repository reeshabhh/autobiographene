import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Custom imports
import 'package:autobiographene/ui/comments_screen.dart';
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/curved_bottom_nav_bar.dart';


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

class TrendingScreen extends StatefulWidget {
  static const String id = 'trending_screen';

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  // final DateTime dateTo = DateTime.now();
  // final DateTime dateFrom = DateTime.now().subtract(
  //   Duration(days: 4), // 4 Days difference
  // );
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('C_All_Posts')
      .where('Is_Private", isEqualTo: false')
      .where(
        'Datetime',
        isLessThanOrEqualTo: DateTime.now(),
        isGreaterThanOrEqualTo: DateTime.now().subtract(
          Duration(days: 4),
        ),
      )
      .orderBy('Datetime', descending: true)
      .orderBy(
        'No_Of_Likes',
        descending: true,
      )
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Trending Right Now!'),
          ),
        ),
        body: Column(
          children: [
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
                // int msgCount = snapshot.data.size;
                return Expanded(
                  child: new ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        // likeIconFlag = 0;
                        // addOrSubtractLikeBool = false;
                        //TODO Now I can manipulate this container to achieve the desired result. Later I will have to extract this widget.

                        // print(
                        //     '=======================================================');
                        // print(iGlobalTrending);
                        // iGlobalTrending = iGlobalTrending + 1;
                        // print(iGlobalTrending);
                        // print(
                        //     '=======================================================');
                        return Expanded(
                          child: Padding(
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
                                      child: Text('${data['User_Id']}',
                                          style: TextStyle(fontSize: 15)),
                                    ),
                                  ),
                                  // TODO this flex value will depend on the length of the text. I will have to convert different whole numbers depending on the length
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        child: Text('${data['Message']}',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  //   flex: 5,
                                  //   fit: FlexFit.tight,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(15.0),
                                  //     child: Container(
                                  //       child: Text('${data['Post_Id']}',
                                  //           style: TextStyle(fontSize: 20)),
                                  //     ),
                                  //   ),
                                  // ),
                                  // TODO onpresed this icon should change and count will increase decrease depeding on how many times it has been clicked
                                  Row(
                                    children: [
                                      // TODO Thumb up means you liked it heart means you have bookmarked it. You can bookmark comments as well
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {
                                            // NOTES *Start* - Naive solution
                                            // document.reference.update({
                                            //   'No_Of_Likes':
                                            //       document['No_Of_Likes'] + 1
                                            // });
                                            // NOTES *End* - Naive solution

                                            // NOTES *Start* - Better solution

                                            bool addOrSubtractLikeBool =
                                                data['Liked_By'].contains(
                                                    loggedInUserGlobal!.email);
                                            addOrSubtractLikeBool
                                                ? FirebaseFirestore.instance
                                                    .runTransaction(
                                                    (transaction) async {
                                                      DocumentSnapshot
                                                          freshSnapShot =
                                                          await transaction.get(
                                                              document
                                                                  .reference);
                                                      transaction.update(
                                                        freshSnapShot.reference,
                                                        {
                                                          'No_Of_Likes':
                                                              freshSnapShot[
                                                                      'No_Of_Likes'] -
                                                                  1,
                                                          'Liked_By': FieldValue
                                                              .arrayRemove(
                                                            [
                                                              loggedInUserGlobal!
                                                                  .email
                                                            ],
                                                          ),
                                                        },
                                                      );
                                                      print(
                                                          '============================================');
                                                      print(
                                                          'true ==  $addOrSubtractLikeBool');
                                                      print('subtracted likes');

                                                      print(data['Liked_By']);
                                                      // likeIconFlag = -1;
                                                      print(
                                                          '============================================');
                                                      addOrSubtractLikeBool =
                                                          false;
                                                    },
                                                  )
                                                : FirebaseFirestore.instance
                                                    .runTransaction(
                                                    (transaction) async {
                                                      DocumentSnapshot
                                                          freshSnapShot =
                                                          await transaction.get(
                                                              document
                                                                  .reference);
                                                      transaction.update(
                                                        freshSnapShot.reference,
                                                        {
                                                          'No_Of_Likes':
                                                              freshSnapShot[
                                                                      'No_Of_Likes'] +
                                                                  1,
                                                          'Liked_By': FieldValue
                                                              .arrayUnion(
                                                            [
                                                              loggedInUserGlobal!
                                                                  .email
                                                            ],
                                                          ),
                                                        },
                                                      );
                                                      print(
                                                          '============================================');
                                                      print(
                                                          'false ==  $addOrSubtractLikeBool');
                                                      print('added likes');
                                                      // likeIconFlag = 1;
                                                      print(
                                                          '============================================');
                                                      addOrSubtractLikeBool =
                                                          true;
                                                    },
                                                  );

                                            // NOTES *End* - Better solution
                                            // print(
                                            //     '============================================');
                                            // print(addOrSubtractLikeBool);
                                            // print(
                                            //     '============================================');
                                          },

                                          icon: () {
                                            bool addOrSubtractLikeBoolAnonymous;
                                            return addOrSubtractLikeBoolAnonymous =
                                                data['Liked_By'].contains(
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

                                          // addOrSubtractLikeBool
                                          //     ? Icon(Icons.thumb_up_alt)
                                          //     : Icon(Icons.emoji_emotions),
                                          // likeIconFlag == 1
                                          //     ? Icon(Icons.emoji_emotions)
                                          //     : Icon(Icons.favorite_border),

                                          // if (likeIconFlag==1){
                                          //   Icon(Icons.emoji_emotions)
                                          // }else if (likeIconFlag==-1) {
                                          //  Icon(Icons.favorite_border)
                                          // }else if (likeIconFlag==0) {
                                          //  Icon(Icons.favorite_border)

                                          // },

                                          // likeButtonBoolGlobal!
                                          //     ? Icon(Icons.thumb_up_off_alt)
                                          //     : Icon(
                                          //         Icons.thumb_up_off_alt,
                                          // ),
                                          // Icon(Icons.thumb_up_off_alt),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ),
                                      //TODO I will call comments notes
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {
                                            // FIXME idPost this is the post Id
                                            // idPostComment = data['Post_Id'];
                                            print(
                                                '=====================================================');
                                            print(_usersStream);
                                            print(document.id);
                                            print(loggedInUserGlobal);
                                            print(loggedInUserGlobal!.email);
                                            print(
                                                '=====================================================');
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
                                ],
                              ),
                              // child: Center(
                              //   child: Text(
                              //     '${data['message']} (${data['userid']})',
                              //     style: TextStyle(fontSize: 50),
                              //   ),
                              // ),
                            ),
                          ),
                        );
                        // FIXME end new code
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: CurvedBottomNavBar(2),
      ),
    );
  }
}
