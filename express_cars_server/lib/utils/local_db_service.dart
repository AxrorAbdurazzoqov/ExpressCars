import 'package:hive/hive.dart';

class HiveService {
  static late Box box;
  static const datadBox = 'data_box';

  //! Singleton
  HiveService.init();
  static HiveService get instance => _instance;
  static final HiveService _instance = HiveService.init();

  //! init
  Future<void> createBox() async {
    box = await Hive.openBox(datadBox);
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
