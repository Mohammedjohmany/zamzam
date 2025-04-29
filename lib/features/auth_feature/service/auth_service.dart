import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamzam/core/config/service_locator.dart';
import 'package:zamzam/core/constant/constant_word.dart';
import 'package:zamzam/features/auth_feature/model/register_model.dart';
import 'package:zamzam/features/auth_feature/model/user_model.dart';
import 'package:zamzam/resource/string_app.dart';

class AuthService{
Dio dio = Dio();
late Response response ;
String url = "https://zamzaam.onrender.com/";




  Future<bool> signUp (RegisterModel registerModel)async{
   try {
     response = await dio.post(url+StringApp.user,data: {
      "username":registerModel.userModel.username,
      "password":registerModel.userModel.password,
      "email":registerModel.email,
     });
     print(response.data);


     if (response.statusCode==200) {
       return true;
     }
     else return false;
   } catch (e) {
     print(e);
     return false;
   }       
  }










 Future<bool> login (UserModel userModel)async{
   try {
     response = await dio.post(url+StringApp.login,queryParameters: {
      "username":userModel.username,
      "password":userModel.password,
     
     });
         sl.get<SharedPreferences>().setString(TOKEN, response.data['access_token']);
     print(response.data);


     if (response.statusCode==200) {
       return true;
     }
     else return false;
   } catch (e) {
     print(e);
     return false;
   }       
  }
}














