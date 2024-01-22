import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';
import 'package:intl/intl.dart';
import '../const/const.dart';

bool isNumber(String text){
  return RegExp('^[0-9]+\$').hasMatch(text);
}

String capitalize(String text){
  return toBeginningOfSentenceCase(text)??text;
}

String? get getToken => prefs.getString(Const.accessToken);

bool settingIsActive(String key,String value){
  return store.state.systemSettingState!.settingResponse?.data![key]==value;
}
dynamic getSettingValue(String key){
  return store.state.systemSettingState!.settingResponse?.data![key];
}

  setProfileDropdownValues () {
    !store.state.manageProfileCombineState!.profiledropdownResponseData!
        .result!
        ? store.dispatch(profiledropdownMiddleware())
        : null;
  }

  bool get isLogedin=>store.state.authState?.userData?.id !=null;

Map<String,String> get commonHeader=>{
  "Accept": "application/json",
  "Content-Type": "application/json",
};

Map<String,String> get authHeader=>{
  "Authorization": "Bearer $getToken",
};

