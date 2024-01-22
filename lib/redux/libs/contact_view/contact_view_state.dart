class ContactViewState {
  bool? isviewed;

  ContactViewState({this.isviewed});

  ContactViewState.initialState() : isviewed = false;
}

ContactViewState? contact_view_reducer(ContactViewState? state, dynamic action) {
  if (action is ContactViewAction) {
    return contact_view(state!, action);
  }

  return state;
}

contact_view(ContactViewState state, dynamic action) {
  state.isviewed = true;

  return state;
}

class ContactViewAction {}
