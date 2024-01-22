class ChatState {
  bool? isFetching;
  String? error;
  List? chatList = [];

  ChatState({
    this.isFetching,
    this.error,
    this.chatList,
  });

  ChatState.initialState()
      : isFetching = true,
        error = '',
        chatList = [];
}
