import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/notice_request.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'http/core/hi_error.dart';
import 'http/dao/login_dao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const RegistrationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  Future<void> _incrementCounter() async {
    // try {
    // var result = await HiNet.getInstance().fire(NoticeRequest());
    // print(result);
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on NeedLogin catch (e) {
    //   print(e);
    // } on HiNetError catch (e) {
    //   print(e);
    // }

    try {
      // var result = await LoginDao.register(
      //   'jvadd',
      //   'ddd112222',
      //   '123445',
      //   '5566',
      // );
      var result = await LoginDao.login('tospery', 'abcd1234');
      print(result);

      var result2 = await HiNet.getInstance().fire(NoticeRequest());
      print(result2);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('2', style: Theme.of(context).textTheme.headlineMedium),
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
