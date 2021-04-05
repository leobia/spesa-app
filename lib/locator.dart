import 'package:get_it/get_it.dart';
import 'package:spesa_app/core/services/api.dart';
import 'package:spesa_app/core/viewmodels/ItemListCRUDModel.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => Api('lists'));
  locator.registerLazySingleton(() => ItemListCRUDModel());
}
