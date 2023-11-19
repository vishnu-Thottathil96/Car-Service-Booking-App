part of 'brand_selection_bloc.dart';

class BrandSelectionState {}

class BrandSelectionInitial extends BrandSelectionState {}

class BrandSelected extends BrandSelectionState {
  int selectedIndex;
  String selectedBrand;
  BrandSelected({required this.selectedIndex, required this.selectedBrand});
}

class ModelSelected extends BrandSelectionState {
  int selectedModelIndex;
  String selectedModel;
  ModelSelected(
      {required this.selectedModelIndex, required this.selectedModel});
}

class CarAddSuccessState extends BrandSelectionState {}

class FinishButtonLoadingState extends BrandSelectionState {}
