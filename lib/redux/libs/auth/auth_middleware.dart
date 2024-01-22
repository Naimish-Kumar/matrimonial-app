import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> authMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await AuthRepository().getAuthData();
      store.dispatch(AuthData(data));
    } catch (e) {
      print(e.toString());
      return;
    }
  };
}
