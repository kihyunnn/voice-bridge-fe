import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'chat_state.dart';
import 'package:provider/provider.dart';

class MessageListView extends StatefulWidget {
  // final List<Message> messages;

  // const MessageListView({Key? key, required this.messages}) : super(key: key);
  const MessageListView({Key? key}) : super(key: key);

  @override
  _MessageListViewState createState() => _MessageListViewState(); // 상태 클래스를 반환
}

class _MessageListViewState extends State<MessageListView> {
  final ScrollController _scrollController = ScrollController(); // ScrollController 생성

  @override
  void initState() {
    super.initState(); // 부모 클래스의 initState 호출
    WidgetsBinding.instance.addPostFrameCallback((_) { // 렌더링이 완료된 후에 호출
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), // 300ms 동안 스크롤 이동
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var messageProvider = Provider.of<MessageProvider>(context);
    var messages = messageProvider.messages; // messages 리스트를 가져옴
    return Scrollbar(
      controller: _scrollController, // ScrollController를 Scrollbar와 ListView에 연결
      child: ListView.builder(
        controller: _scrollController, // 동일한 ScrollController를 사용
        itemCount: messages.length, // messages 리스트의 길이만큼 아이템 생성
        itemBuilder: (context, index) {
          // final message = widget.messages[index];
          final message = messages[index]; // widget.messages 대신 messages를 사용
          return ChatBubble(message: message);
        },
      ),
    );
  }
}
