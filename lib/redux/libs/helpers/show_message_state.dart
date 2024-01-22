import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class ShowMessageState {
  ShowMessageState.initialState();
}

class ShowMessageAction {
  var msg;

  @override
  String toString() {
    return 'ShowMessageAction{msg: $msg}';
  }

  var color;
  ShowMessageAction({this.msg, this.color});
}

ShowMessageState? show_message_reducer(
    ShowMessageState? state, dynamic action) {
  if (action is ShowMessageAction) {
    return show_message(state, action);
  }
  return state;
}

show_message(ShowMessageState? state, dynamic action) {
  OneContext().showSnackBar(
    builder: (_) => SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: action.color,
      content: Text(action.msg!),
    ),
  );
}
