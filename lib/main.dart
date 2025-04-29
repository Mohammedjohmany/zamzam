import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zamzam/core/config/service_locator.dart';

import 'package:zamzam/features/auth_feature/bloc/bloc/auth_bloc.dart';
import 'package:zamzam/features/auth_feature/model/register_model.dart';
import 'package:zamzam/features/auth_feature/model/user_model.dart';
import 'package:zamzam/features/auth_feature/screen/login.dart';
import 'package:zamzam/features/auth_feature/screen/sign_up_screen.dart';
import 'package:zamzam/features/auth_feature/service/auth_service.dart';
import 'package:zamzam/features/company_feature/model/offers_model.dart';
import 'package:zamzam/features/company_feature/service/company_service.dart';
import 'package:zamzam/features/company_feature/service/offers_service.dart';
import 'package:zamzam/features/company_feature/ui/detalies_page.dart';
import 'package:zamzam/features/company_feature/ui/home_page.dart';
import 'package:zamzam/features/location_feautre/model/location_model.dart';
import 'package:zamzam/features/location_feautre/screen/location_screen.dart';
import 'package:zamzam/features/location_feautre/service/location_service.dart';
import 'package:zamzam/resource/string_app.dart';
import 'package:zamzam/splash.dart';

CompanyService companyService = CompanyService();
OffersService offersService = OffersService();
void main()async{
  
   WidgetsFlutterBinding.ensureInitialized();
   await setup();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//    print(await companyService.getCompanies(limit: 10, skip: 0,));
// String mm=companyService. url+StringApp.companies;
// print(mm);w
String url = "https://zamzaam.onrender.com/"; 
print(await LocationService().createLocation(LocationModel(address: "32")));
//print(await offersService.getOffersByCompanyId(companyId: 2, limit: 10, skip: 0));
//print( '${url}${StringApp.companies}${OffersModel().companyId}/offers');
//print(await offersService.getOffersByCompanyId(limit: 5, skip: 0, companyId: ));
await Future.delayed(const Duration(seconds: 3)); 
  FlutterNativeSplash.remove();
  runApp( 
     
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}


    
 


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );}}











    class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

