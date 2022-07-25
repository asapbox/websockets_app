import 'package:flutter/material.dart';
import 'api_websocket.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Testing Web Socket App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int counter = 0;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final channel = ApiWebSocket.channel;

  void increment() {
    widget.counter += 1;
  }

  void _sendMessage() {
    increment();
    channel.sink.add(widget.counter.toString());
    debugPrint('counter = ${widget.counter.toString()}');
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(
              height: 20.0,
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? '${snapshot.data}' : '',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
