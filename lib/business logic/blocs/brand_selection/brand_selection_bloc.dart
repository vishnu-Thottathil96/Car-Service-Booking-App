import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  BrandSelectionBloc() : super(BrandSelectionInitial()) {
    on<BrandSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
