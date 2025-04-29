import 'package:dio/dio.dart';
import 'package:zamzam/core/config/header_config.dart';
import 'package:zamzam/features/location_feautre/model/location_model.dart';
import 'package:zamzam/resource/string_app.dart';

class LocationService{
  Dio dio = Dio();
  
  String url= "https://zamzaam.onrender.com/";


Future <bool> createLocation(LocationModel locationModel)async{
  try {
    final response = await dio.post(url+StringApp.locations,options: HeaderConfig.getHeader(), data: locationModel.toMap());
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