


import 'package:active_matrimonial_flutter_app/models_response/common_models/user.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/authstate.dart';

AuthState? authReducer(AuthState? state,dynamic auction){
  if(auction is AuthData) {

    state = AuthState(userData: auction.data);
  }
  if(auction is ClearAuthData) {
    state = AuthState(userData: null);
  }
  return state;
}

class AuthData{
  User data;
  AuthData(this.data);
}
class ClearAuthData{
}
