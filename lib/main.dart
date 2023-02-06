import 'package:get_it/get_it.dart';
import 'package:paga_eu/preferenciaTema.dart';
import 'package:paga_eu/screens/initial_screen.dart';
import 'package:flutter/material.dart';

import 'mobx_store/pessoa_store.dart';

void main() {

  GetIt.I.registerSingleton<PessoaStore>(PessoaStore());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    PreferenciaTema.setTema();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override 
  void didChangePlatformBrightness() {
      PreferenciaTema.setTema();
    super.didChangePlatformBrightness();
  }


  @override
  Widget build(BuildContext context) {
    ChangeNotifier();
    return ValueListenableBuilder(
      valueListenable: PreferenciaTema.tema,
      builder: (BuildContext context, Brightness tema, _) =>
       MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          
          primaryColorDark: Colors.yellow,
          primaryColorLight: Colors.purple,
          brightness: tema,
        ),
        home:  InitialScreen(),
      ),
    );
  }
}







