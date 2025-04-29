import 'package:dio/dio.dart';
import 'package:zamzam/features/company_feature/model/company_model.dart';
import 'package:zamzam/resource/string_app.dart';

class CompanyService{
  Dio dio = Dio();
  late final Response response;
  String url= "https://zamzaam.onrender.com/";




 Future <List< CompanyModel>> getCompanies({required int limit ,required int skip })async{
  try {
    response = await dio.get(url+StringApp.companies,queryParameters:{
      "limit":limit,
      "skip":skip
    } );
         
            return List.generate(
        response.data.length,
        (index) => CompanyModel.fromMap(response.data[index]),
      );
     
    
  } catch (e) {
    print(e);
    return [];
  }
 }

}