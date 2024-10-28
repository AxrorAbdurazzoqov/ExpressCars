import 'package:express_cars/src/core/common/car_info_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box box;
  static const savedBox = 'saved_box';

  //! Singleton
  HiveService.init();
  static HiveService get instance => _instance;
  static final HiveService _instance = HiveService.init();

  //! init
  Future<void> createBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter((CarInfoModelAdapter()));
    Hive.registerAdapter((FeaturesAdapter()));
    box = await Hive.openBox(savedBox);
  }

  //! write
  void writeData({required key, required value}) async {
    await box.put(key, value);
  }

  //! read
  dynamic readData({required key}) {
    return box.get(key);
  }

  //! read all
  Map get readAllData {
    return box.toMap();
  }

  //! delete
  void deleteData({required key}) {
    box.delete(key);
  }
}
