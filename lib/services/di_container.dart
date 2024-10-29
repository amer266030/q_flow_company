import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../mangers/data_mgr.dart';

class DIContainer {
  static Future<void> setup() async {
    await GetStorage.init();
    GetIt.I.registerSingleton<DataMgr>(DataMgr());
  }
}
