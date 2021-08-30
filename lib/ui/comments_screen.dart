import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Custom imports
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/curved_bottom_nav_bar.dart';
import 'package:autobiographene/ui/widgets/custom_privacy_switch.dart';



var uuidComment = Uuid();

final idComment = uuidComment.v1();
var idPostComment;
final snackBarComment = SnackBar(
  content: Text('Yay! Your notes was posted!'),
);
final _textEditingControllerComment = TextEditingController();
void clearTextComment() {
  _textEditingControllerComment.clear();
}

class CommentsScreen extends StatefulWidget {
  static const String id = 'comments_screen';
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _firestore = FirebaseFirestore.instance;
String? _textValComment;

  // final _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('C_All_Notes')
      .where('Post_Id', isEqualTo: idPostComment)
       // FIXME orderby with where does not work
      
      // .orderBy('Datetime', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Comment Screen',
            style: TextStyle(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _textEditingControllerComment,
                onChanged: (String value) {
                  // TODO if value == null then throw an error.Please type sth 25-jul-21
                  print(
                      'onChanged event before _textValComment = $_textValComment');
                  _textValComment = value;
                  print('onChanged event after _textValComment = $_textValComment');
                },
                decoration: InputDecoration(
                  hintText: 'How did it go?', // TODO: This will be random
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0.0, 15, 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: CustomPrivacySwitch(),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        var now = new DateTime.now();
                        try {
                          // print(idPostComment);
                          _firestore.collection('C_All_Notes').add(
                            {
                              'Datetime': now,
                              'Notes': _textValComment,
                              'User_Id': loggedInUserGlobal!.email,
                              'Post_Id': idPostComment,
                              'Comment_Id': idComment,
                              'No_Of_Likes': 0,
                              'No_Of_Shares': 0,
                              'No_Of_Bookmarks': 0,
                              'No_Of_Comments': 0,
                            },
                          );
                          clearTextComment();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarComment);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // print('=====================================================');
                // print(idPostComment);
                // print('=====================================================');
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return Expanded(
                  child: new ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        //TODO Now I can manipulate this container to achieve the desired result. Later I will have to extract this widget.
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
                                        child: Text('${data['Notes']}',
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
                                            FirebaseFirestore.instance
                                                .runTransaction(
                                                    (transaction) async {
                                              DocumentSnapshot freshSnapShot =
                                                  await transaction
                                                      .get(document.reference);
                                               transaction.update(
                                                  freshSnapShot.reference, {
                                                'No_Of_Likes': freshSnapShot[
                                                        'No_Of_Likes'] +
                                                    1,
                                              });
                                            });
                                          },
                                          icon: Icon(Icons.thumb_up_off_alt),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite_border),
                                        ),
                                      ),
                                      //TODO I will call comments notes
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {
                                            // FIXME idPost this is the post Id
                                            Navigator.pushNamed(
                                                context, CommentsScreen.id);
                                          },
                                          icon: Icon(Icons.notes),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.send),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedBottomNavBar(7),
    );
  }
}
