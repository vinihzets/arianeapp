// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BlocState<T> {
  final T? data;

  BlocState({
    required this.data,
  });
}

class BlocStableState<T> extends BlocState<T> {
  BlocStableState({super.data});
}

class BlocEmptyState<T> extends BlocState<T> {
  BlocEmptyState({super.data});
}

class BlocErrorState<T> extends BlocState<T> {
  BlocErrorState({super.data});
}

class BlocLoadingState<T> extends BlocState<T> {
  BlocLoadingState({super.data});
}
