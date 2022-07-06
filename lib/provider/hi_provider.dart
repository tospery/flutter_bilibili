// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';

List<SingleChildWidget> topProviders = [
    ChangeNotifierProvider(create: (_)=>ThemeProvider())
];