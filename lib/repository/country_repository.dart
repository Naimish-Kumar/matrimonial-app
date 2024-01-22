


import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_api_request.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/models_response/country_response.dart';

class CountryRepository{
 Future<CountryResponse> getCountry()async {
   String url = "${AppConfig.BASE_URL}/countries";
   Map<String,String> header=commonHeader ;
   var response = await AizApi.get(Uri.parse(url),headers: header);
   return countryResponseFromJson(response.body);
  }
}