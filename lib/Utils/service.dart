import 'package:testcart/ViewModel/edit_profile_viewmodel.dart';
import 'package:testcart/ViewModel/favorite_viewmodel.dart';
import 'package:testcart/ViewModel/login_notifier.dart';
import 'package:testcart/ViewModel/notes_fetch_notifier.dart';
import 'package:testcart/Network/middleware.dart';
import 'package:testcart/Network/note_api.dart';
import 'package:get_it/get_it.dart';


final GetIt service = GetIt.I;

void setupLocator(){
  service.registerFactory(() => LoginNotifier());
  service.registerFactory(() => ProductNotifier());
  service.registerFactory(() => FavoriteNotifier());
  service.registerFactory(() => EditProfileNotifier());
  service.registerLazySingleton(() => NoteAPI());
  service.registerLazySingleton(() => MiddleWare());
}