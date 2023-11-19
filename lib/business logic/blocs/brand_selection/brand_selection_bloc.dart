import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/repositories/user_repository.dart';
import 'package:motox/presentation/screens/model_selection/select_model.dart';

part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc
    extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  BrandSelectionBloc() : super(BrandSelectionInitial()) {
    on<SelectionIndexChange>(selectionIndexChange);
    on<SelectionModelIndexChange>(selectionModelIndexChange);
    on<FinishSetupButtonClicked>(finishSetupButtonClicked);
  }

  FutureOr<void> selectionIndexChange(
      SelectionIndexChange event, Emitter<BrandSelectionState> emit) {
    emit(BrandSelected(
        selectedIndex: event.seletedIndex, selectedBrand: event.selectedBrand));
  }

  FutureOr<void> selectionModelIndexChange(
      SelectionModelIndexChange event, Emitter<BrandSelectionState> emit) {
    emit(ModelSelected(
        selectedModelIndex: event.selectedModelIndex,
        selectedModel: event.selectedModel));
  }

  FutureOr<void> finishSetupButtonClicked(
      FinishSetupButtonClicked event, Emitter<BrandSelectionState> emit) async {
    emit(FinishButtonLoadingState());
    await UserRepository.addCarsForUser(
        car: event.car, userId: FirebaseAuth.instance.currentUser!.uid);
    emit(CarAddSuccessState());
  }
}
