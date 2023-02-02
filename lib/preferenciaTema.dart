// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PreferenciaTema {
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.dark);
  static setTema(){
    tema.value = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}