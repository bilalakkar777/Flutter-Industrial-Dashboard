import 'package:flutter_bloc/flutter_bloc.dart';

class MainBackgroundState {
  MainBackgroundState();

  bool isInitialized = false;
}

class MainBackgroundCubit extends Cubit<MainBackgroundState> {
  MainBackgroundCubit() : super(MainBackgroundState());

  //Make async method
  Future<void> initialize() async {
    state.isInitialized = true;

    emit(state);
  }
}
