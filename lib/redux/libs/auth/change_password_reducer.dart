import 'package:active_matrimonial_flutter_app/redux/libs/auth/change_password_state.dart';

enum obscure { oldpass, newpass, confirmpass }

ChangePasswordState? change_password_reducer(
    ChangePasswordState? state, dynamic action) {
  if (action is CpLoader) {
    return loader(state!, action);
  }

  if (action == obscure.oldpass) {
    state!.oldpass = !state.oldpass;
    return state;
  }
  if (action == obscure.newpass) {
    state!.newpass = !state.newpass;
    return state;
  }
  if (action == obscure.confirmpass) {
    state!.confirmpass = !state.confirmpass;
    return state;
  }

  return state;
}

loader(ChangePasswordState state, CpLoader action) {
  state.cp_loader = !state.cp_loader;
  return state;
}

class CpLoader {}
