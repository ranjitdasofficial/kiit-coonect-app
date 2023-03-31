import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Init {
  static void initAll() async {
    await GetStorage.init();
    await Hive.initFlutter();
  }
}
