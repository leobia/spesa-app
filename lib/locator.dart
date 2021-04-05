import 'package:get_it/get_it.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/core/utils/api.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => Api('lists'));
  locator.registerLazySingleton(() => ListsRepository());
}
