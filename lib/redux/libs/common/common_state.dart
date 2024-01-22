import 'package:active_matrimonial_flutter_app/models_response/country_response.dart';

class CommonState{

  List<CountryInfo>? countries =[];

  update({List<CountryInfo>? countries}){
    this.countries =countries??this.countries;
  }


//get country code as list of string
 List<String>? countriesToString(){
    return countries?.map<String>((e) => e.code??"").toList();
  }

}