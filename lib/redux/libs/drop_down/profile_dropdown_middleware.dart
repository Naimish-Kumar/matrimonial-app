import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/manage_profile_combine_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/drop_down_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> profiledropdownMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await DropDownRepository().fetchProfileDropDown();
      store.dispatch(ManageProfileCommonDropdownValuesSetAction(data));
    } catch (e) {
      print("error profile drop down middleware ${e.toString()}");
      return;
    }
  };
}
