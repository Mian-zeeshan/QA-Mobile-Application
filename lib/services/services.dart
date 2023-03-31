import 'package:get_it/get_it.dart';
import 'package:kfccheck/common/local_storage_provider.dart';
import 'package:kfccheck/common/user.dart';
import '../common/firebase_handler.dart';

var locator = GetIt.instance;

initServices() {
  locator.registerLazySingleton(() => LocalStorageProvider());
  locator.registerLazySingleton(() => LocalUser());
  locator.registerLazySingleton(() => FirebaseHandler());
}
