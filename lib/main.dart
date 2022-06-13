
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
// import 'package:flutter_bilibili/http/core/hi_error.dart';
// import 'package:flutter_bilibili/http/core/hi_net.dart';
// import 'package:flutter_bilibili/http/request/test_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  } 

  // void test() {
  //   const jsonString =
  //       "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
  //   //json 转map
  //   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //   print('name:${jsonMap['name']}');
  //   print('url:${jsonMap['url']}');
  //   //map 转json
  //   String json = jsonEncode(jsonMap);
  //   print('json:$json');
  // }

  // void test() {
  //   const jsonString = "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
  //   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //   // ignore: avoid_print
  //   print('name = ${jsonMap['name']}');
  //   // ignore: avoid_print
  //   print('url = ${jsonMap['url']}');
  //   String string = jsonEncode(jsonMap);
  //   // ignore: avoid_print
  //   print('json = $string');
  // }

  Future<void> _incrementCounter() async {
    // TestRequest request = TestRequest();
    // request.add('aa', 'abc').add('bb', '123').add('requestPrams', 'kkkk');
    // try {
    //   // ignore: unused_local_variable
    //   var result = await HiNet.getInstance().fire(request);
    // } on NeedAuth catch(e) {
    //   // ignore: avoid_print
    //   print(e);
    // } on NeedLogin catch(e) {
    //   // ignore: avoid_print
    //   print(e);
    // } on HiNetError catch(e) {
    //   // ignore: avoid_print
    //   print(e);
    // }

    //     HiCache.getInstance().setString("aa", "1234");
    // var value = HiCache.getInstance().get("aa");
    // print('value:$value');

    HiCache.getInstance().setString('aa', '1234');
    var value = HiCache.getInstance().get('aa');
    // ignore: avoid_print
    print('value = $value');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
