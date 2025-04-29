import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;
Future<void> setup() async{
  sl.registerSingleton(await SharedPreferences.getInstance());
}