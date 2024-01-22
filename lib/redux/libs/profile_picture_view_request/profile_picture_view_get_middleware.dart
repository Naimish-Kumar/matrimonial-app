import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/models_response/profile_picture_view_request_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_reducer.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:active_matrimonial_flutter_app/screens/startup_pages/splash_screen.dart';

ThunkAction<AppState> getProfilePictureViewRequestMiddleware({page = 1}) {
  return (Store<AppState> store) async {
    // store.dispatch(GetProfilePictureViewAction());
    try {
      var data = await ProfilePictureViewRepository()
          .getProfilePictureViewRequestList(page: page);
      store.dispatch(
          GetProfilePictureViewSucceededAction(profileypictureviewlist: data));
    } catch (e) {
      store.dispatch(GetProfilePictureViewFailureAction(error: "Faild to Fetch Data."));

      return;
    }
  };
}

class ProfilePictureViewRepository {
  Future<ProfilePictureViewRequestGetResponse> getProfilePictureViewRequestList(
      {page}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/profile-picture-view-request?page=$page";
    var accessToken = prefs.getString(Const.accessToken);

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      });
      var data = profilePictureViewRequestGetResponseFromJson(response.body);

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
