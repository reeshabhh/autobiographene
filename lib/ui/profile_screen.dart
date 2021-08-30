import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// Custom imports
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/custom_bottom_app_bar.dart';


class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email = loggedInUserGlobal!.email;
  Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('C_All_Posts')
      .where('User_Id', isEqualTo: loggedInUserGlobal!.email)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
        ),
        body: Column(
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Text(
                    email!,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
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
        ),
        bottomNavigationBar:  CustomBottomAppBar(),
      ),
    );
  }
}
