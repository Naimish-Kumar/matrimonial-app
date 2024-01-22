import 'package:active_matrimonial_flutter_app/models_response/static_page_response.dart';

import '../../../repository/app_info_repository.dart';
import '../../../screens/core.dart';
import '../../app/app_state.dart';

class StaticPageState {
  bool? isFetching;
  List? staticPageList = [];
  String? error;
  String? faq;
  String? privacyPolicy;
  String? termsAndCondition;
  StaticPageState({
    this.isFetching,
    this.staticPageList,
    this.error,
    this.faq,
    this.privacyPolicy,
    this.termsAndCondition,
  });

  StaticPageState.initialState()
      : isFetching = true,
        staticPageList = [],
        faq = '',
        privacyPolicy = '',
        termsAndCondition = '',
        error = '';
}

StaticPageState? staticPageReducer(StaticPageState? state, dynamic action) {
  if (action is StaticPageStoreAction) {
    state!.isFetching = false;
    state.staticPageList = action.payload!.data;
    setFaq(state, action);
    return state;
  }
  if (action is StaticPageFailureAction) {
    state!.error = action.error;
    return state;
  }
  return state;
}

setFaq(StaticPageState state, dynamic action) {
  state.privacyPolicy =
      state.staticPageList![state.staticPageList!.length - 2].content;
  state.termsAndCondition = state.staticPageList!.first.content;
  state.faq = state.staticPageList!.last.content;

  return state;
}

class StaticPageStoreAction {
  StaticPageResponse? payload;

  StaticPageStoreAction({this.payload});

  @override
  String toString() {
    return 'StaticPageStoreAction{payload: $payload}';
  }
}

class StaticPageFailureAction {
  String? error;

  StaticPageFailureAction({this.error});

  @override
  String toString() {
    return 'StaticPageFailureAction{error: $error}';
  }
}

ThunkAction<AppState> fetchStaticPageAction() {
  return (Store<AppState> store) async {
    try {
      var data = await AppInfoRepository().fetchStaticPage();
      store.dispatch(StaticPageStoreAction(payload: data));
    } catch (e) {
      store.dispatch(StaticPageFailureAction(error: e.toString()));
      //debugPrint(e);
      return;
    }
  };
}
