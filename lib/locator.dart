import 'package:bramstore/services/storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
Future setupLocator() async {
  locator.registerLazySingleton(() => StorageService());
}
