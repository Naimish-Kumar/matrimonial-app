import 'dart:async';

import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_action.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/ignore_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/ignore/remove_ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../../../main.dart';

IgnoreState? ignore_reducer(IgnoreState? state, dynamic action) {
  if (action is IgnoreItemRemoveAction) {
    return remove_item(state!, action);
  }
  if (action is AddIgnoreAction) {
    return backtomain(state, action);
  }

  if (action is IgnoreStoreAction) {
    state!.isFetching = false;
    if (action.payload!.meta!.lastPage != state.page) {
      state.page += 1;
    } else {
      state.hasMore = false;
    }
    state.ignoreList!.addAll(action.payload!.data!);
    return state;
  }
  if (action is IgnoreFailureAction) {
    state!.error = action.error;
    return state;
  }
  if (action == Reset.ignoreList) {
    state = IgnoreState.initialState();
    return state;
  }

  return state;
}

backtomain(IgnoreState? state, AddIgnoreAction action) {
  store.dispatch(homeMiddleware());

  Timer(Duration(seconds: 1), () {
    OneContext().navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Main()), (route) => false);
  });
  return state;
}

remove_item(IgnoreState state, IgnoreItemRemoveAction action) {
  state.ignoreList!.remove(action.data);
  store.dispatch(removeIgnoreMiddleware(user: action.data));

  return state;
}
