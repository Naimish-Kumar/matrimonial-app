class BlogState {
  List? blogList = [];
  String? error;
  bool? isFetching;

  BlogState({
    this.blogList,
    this.error,
    this.isFetching,
  });

  BlogState.initialState()
      : blogList = [],
        error = '',
        isFetching = true;
}
