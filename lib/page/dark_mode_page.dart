import 'package:flutter/material.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/color.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

///夜间模式页面
class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  // ignore: constant_identifier_names
  static const _ITEMS = [
    {"name": '跟随系统', "mode": ThemeMode.system},
    {"name": '开启', "mode": ThemeMode.dark},
    {"name": '关闭', "mode": ThemeMode.light},
  ];
  // ignore: prefer_typing_uninitialized_variables
  var _currentTheme;

  @override
  void initState() {
    super.initState();
    var themeMode = context.read<ThemeProvider>().getThemeMode();
    for (var element in _ITEMS) {
      if (element['mode'] == themeMode) {
        _currentTheme = element;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('夜间模式')),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: _ITEMS.length),
    );
  }

  Widget _item(int index) {
    var theme = _ITEMS[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(child: Text(theme['name'] as String)),
            Opacity(
                opacity: _currentTheme == theme ? 1 : 0,
                child: const Icon(Icons.done, color: primary))
          ],
        ),
      ),
    );
  }

  void _switchTheme(int index) {
    var theme = _ITEMS[index];
    context.read<ThemeProvider>().setTheme(theme['mode'] as ThemeMode);
    setState(() {
      _currentTheme = theme;
    });
  }
}
