import 'package:bloc/bloc.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarInitial()) {
    on<TabChange>((event, emit) {
      emit(BottomBarState(tabIndex: event.tabIndex));
    });
  }
}
