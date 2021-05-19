import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';


class SocketWidget extends StatefulWidget {
  final String title;

  SocketWidget({@required this.title,});

  @override
  _SocketWidgetState createState() => _SocketWidgetState();
}

class _SocketWidgetState extends State<SocketWidget> {
  final TextEditingController _controller = TextEditingController();
  final _channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
  List<int> l = [1,2,3,4,5,6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(l);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}