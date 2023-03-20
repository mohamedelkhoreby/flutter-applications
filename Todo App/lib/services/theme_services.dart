import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final key = 'isDarMode';

  saveThemeToBox(bool isdarkMode) {
    box.write(key, isdarkMode);
  }

  bool loadThemeFrombox() {
    return box.read<bool>(key) ?? false;
  }
  
  ThemeMode get theme => loadThemeFrombox() 
  ? ThemeMode.dark 
  : ThemeMode.light;
  
  void switchTheme() {
    Get.changeThemeMode(loadThemeFrombox() 
    ? ThemeMode.light 
    : ThemeMode.dark);
    saveThemeToBox(!loadThemeFrombox());
  }
}
