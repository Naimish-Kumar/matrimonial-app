import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/manage_profile_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../helpers/show_message_state.dart';
import '../manage_profile_reducer/career_reducer.dart';
import 'manage_profile_get_middlewares.dart';

ThunkAction<AppState> eudcationDeleteMiddleware({dynamic id}) {
  return (Store<AppState> store) async {
    store.dispatch(EducationLoader.delete);

    try {
      var data = await ManageProfileRepository().educationDelete(id: id);
      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));

      store.dispatch(educationGetMiddleware());
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(EducationLoader.delete);
  };
}

ThunkAction<AppState> careerDeleteMiddleware({dynamic id}) {
  return (Store<AppState> store) async {
    store.dispatch(CareerLoader.delete);

    try {
      var data = await ManageProfileRepository().careerDelete(id: id);

      store.dispatch(careerGetMiddleware());

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(CareerLoader.delete);
  };
}
