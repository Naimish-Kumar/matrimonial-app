import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/blog_repository.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'blog_action.dart';

ThunkAction<AppState> blogMiddleware() {
  return (Store<AppState> store) async {
    try {
      var data = await BlogRepository().fetchBlog();

      store.dispatch(BlogStoreAction(payload: data));
    } catch (e) {
      store.dispatch(BlogFailureAction(error: e.toString()));
      debugPrint(e.toString());
      return;
    }
  };
}
