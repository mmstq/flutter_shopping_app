import 'package:bookbuddy/ViewModel/login_notifier.dart';
import 'package:bookbuddy/ViewModel/notes_fetch_notifier.dart';
import 'package:bookbuddy/Network/middleware.dart';
import 'package:bookbuddy/Network/note_api.dart';
import 'package:get_it/get_it.dart';


final GetIt service = GetIt.I;

void setupLocator(){
  service.registerFactory(() => LoginNotifier());
  service.registerFactory(() => ProductNotifier());
  service.registerLazySingleton(() => NoteAPI());
  service.registerLazySingleton(() => MiddleWare());
}