import 'package:dio/dio.dart';
import 'package:zamzam/features/company_feature/model/company_model.dart';
import 'package:zamzam/features/company_feature/model/offers_model.dart';
import 'package:zamzam/resource/string_app.dart';

class OffersService{
  Dio dio = Dio();
  
  String url= "https://zamzaam.onrender.com/";




 Future <List< OffersModel>> getAllOffers({required int limit ,required int skip })async{
  try {
 final  response = await dio.get(url+StringApp.offers,queryParameters:{
      "limit":limit,
      "skip":skip
    } );
         
            return List.generate(
        response.data.length,
        (index) => OffersModel.fromMap(response.data[index]),
      );
     
    
  } catch (e) {
    print(e);
    return [];
  }
 }




Future<List<OffersModel>> getOffersByCompanyId({
  required int companyId,
  required int limit,
  required int skip,
}) async {
  try {
    final response = await dio.get(
      '${url}${StringApp.companies}${companyId}/offers',  
      queryParameters: {
      
        "limit": limit,
        "skip": skip,
      },
      
    );

    return List.generate(
      response.data.length,
      (index) => OffersModel.fromMap(response.data[index]),
    );
  } catch (e) {
    print(e);
    return [];
  }
}





}