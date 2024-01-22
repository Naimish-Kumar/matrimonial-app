import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

class AuthHelper {
  setAuthData(SignInResponse data) {
    prefs.setString(Const.accessToken, data.accessToken!);
    // prefs.setString(Const.userName, data.user!.name!);
    // prefs.setString(Const.maritalStatus, data.user!.maritalStatusId!.name!);
    // prefs.setInt(Const.userId, data.user!.id!);
    // prefs.setString(Const.userHeight, data.user!.height.toString());
    // prefs.setString(Const.userAge, data.user!.birthday.toString());
    // prefs.setString(Const.userEmail,
    // data.user!.email == null ? data.user!.phone! : data.user!.email!);
    store.dispatch(AuthData(data.user!));
  }
}
