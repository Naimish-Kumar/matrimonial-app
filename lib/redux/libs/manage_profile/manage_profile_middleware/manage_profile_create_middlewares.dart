import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/manage_profile_repository.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../helpers/show_message_state.dart';
import '../manage_profile_reducer/career_reducer.dart';
import 'manage_profile_get_middlewares.dart';

ThunkAction<AppState> education_create_middleware(
    {dynamic degree, dynamic institution, dynamic start, dynamic end}) {
  return (Store<AppState> store) async {
    store.dispatch(Edusavechanges());

    try {
      var data = await ManageProfileRepository().educationCreate(
          degree: degree, institution: institution, start: start, end: end);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
      store.dispatch(educationGetMiddleware());
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(Edusavechanges());
  };
}

ThunkAction<AppState> careerCreateMiddleware(
    {dynamic designation, dynamic company, dynamic start, dynamic end}) {
  return (Store<AppState> store) async {
    store.dispatch(CareerLoader.save_changes);

    try {
      var data = await ManageProfileRepository().careerCreate(
        designation: designation,
        company: company,
        start: start,
        end: end,
      );

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
      store.dispatch(careerGetMiddleware());
    } catch (e) {
      print("error ${e.toString()}");
      return;
    }
    store.dispatch(CareerLoader.save_changes);
  };
}
