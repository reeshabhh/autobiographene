import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class TrendingTestStreamBuilder extends StatefulWidget {
  static const String id = 'trending_test_stream_builder';

  @override
  _TrendingTestStreamBuilderState createState() =>
      _TrendingTestStreamBuilderState();
}

class _TrendingTestStreamBuilderState extends State<TrendingTestStreamBuilder> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              (_scrollController.position.maxScrollExtent) &&
          !_scrollController.position.outOfRange) {
        _getChats();
      }
    });
  }

  final StreamController<List<DocumentSnapshot>> _chatController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  List<List<DocumentSnapshot>> _allPagedResults = [<DocumentSnapshot>[]];

  static const int chatLimit = 10;
  DocumentSnapshot? _lastDocument;
  bool _hasMoreData = true;

  Stream<List<DocumentSnapshot>> listenToChatsRealTime() {
    _getChats();
    return _chatController.stream;
  }

  void _getChats() {
    final CollectionReference _chatCollectionReference =
        FirebaseFirestore.instance.collection("C_All_Posts");
    // .doc(widget.chatRoomId)
    // .collection("channel");
    var pagechatQuery = _chatCollectionReference
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
        // .orderBy(
        //   'Datetime',
        //   descending: true,
        // )
        // .orderBy(
        //   'No_Of_Likes',
        //   descending: true,
        // )
        // .orderBy('createdAt', descending: true)
        .limit(chatLimit);

    if (_lastDocument != null) {
      pagechatQuery = pagechatQuery.startAfterDocument(_lastDocument!);
    }

    if (!_hasMoreData) return;

    var currentRequestIndex = _allPagedResults.length;
    pagechatQuery.snapshots().listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var generalChats = snapshot.docs.toList();

          var pageExists = currentRequestIndex < _allPagedResults.length;

          if (pageExists) {
            _allPagedResults[currentRequestIndex] = generalChats;
          } else {
            _allPagedResults.add(generalChats);
          }

          var allChats = _allPagedResults.fold<List<DocumentSnapshot>>(
              <DocumentSnapshot>[],
              (initialValue, pageItems) => initialValue..addAll(pageItems));

          _chatController.add(allChats);

          if (currentRequestIndex == _allPagedResults.length - 1) {
            _lastDocument = snapshot.docs.last;
          }

          _hasMoreData = generalChats.length == chatLimit;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<DocumentSnapshot>>(
          stream: listenToChatsRealTime(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting ||
                chatSnapshot.connectionState == ConnectionState.none) {
              return chatSnapshot.hasData
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text("Start a conversation."),
                    );
            } else {
              if (chatSnapshot.hasData) {
                final chatDocs = chatSnapshot.data!;
                final user = Provider.of<User?>(context);
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemBuilder: (ctx, i) {
                    Map chatData = chatDocs[i].data() as Map;
                    return Text('Messagebubble');
                    // return MessageBubble(
                    //     username: chatData['username'],
                    //     message: chatData['text'],
                    //     isMe: chatData['senderId'] == user!.uid,
                    //     key: ValueKey(chatDocs[i].id));
                  },
                  itemCount: chatDocs.length,
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          }),
    );
  }
}
