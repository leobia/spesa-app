import 'package:get_it/get_it.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => ListsRepository());
  locator.registerLazySingleton(() => ListItemRepository());
}
