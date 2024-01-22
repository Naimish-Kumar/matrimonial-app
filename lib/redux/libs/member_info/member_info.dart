import 'package:active_matrimonial_flutter_app/models_response/member_info_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../app_config.dart';
import '../../../const/const.dart';
import '../../../screens/core.dart';
import '../../../screens/startup_pages/splash_screen.dart';
import '../../app/app_state.dart';

class MemberInfoStoreAction {
  MemberInfoResponse? payload;

  MemberInfoStoreAction({this.payload});

  @override
  String toString() {
    return 'MemberInfoStoreAction{payload: $payload}';
  }
}

class MemberInfoFailureAction {
  String? error;

  MemberInfoFailureAction({this.error});

  @override
  String toString() {
    return 'MemberInfoFailureAction{error: $error}';
  }
}

class MemberInfoState {
  bool? isFetching;
  MemberInfoData? memberInfo;
  String? error;

  MemberInfoState({
    this.isFetching,
    this.memberInfo,
    this.error,
  });

  MemberInfoState.initialState()
      : isFetching = true,
        memberInfo = null,
        error = '';
}

MemberInfoState? member_info_reducer(MemberInfoState? state, dynamic action) {
  if (action is MemberInfoStoreAction) {
    state!.isFetching = false;
    state.memberInfo = action.payload!.data;
    return state;
  }
  if (action is MemberInfoFailureAction) {
    state!.error = action.error;
    return state;
  }

  if (action == Reset.memberInfo) {
    state = MemberInfoState.initialState();
    return state;
  }
  return state;
}

class MemberInfoRepository {
  Future<MemberInfoResponse> fetchMemberInfo({required int userId}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/member-info/$userId";
    var accessToken = prefs.getString(Const.accessToken);

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = memberInfoResponseFromJson(response.body);

    return data;
  }
}

ThunkAction<AppState> memberInfoMiddleware({required int userId}) {
  return (Store<AppState> store) async {
    try {
      var data = await MemberInfoRepository().fetchMemberInfo(userId: userId);

      store.dispatch(MemberInfoStoreAction(payload: data));
    } catch (e) {
      store.dispatch(MemberInfoFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}
