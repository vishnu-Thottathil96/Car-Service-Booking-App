part of 'brand_selection_bloc.dart';

class BrandSelectionEvent {}

class SelectionIndexChange extends BrandSelectionEvent {
  final int seletedIndex;
  final String selectedBrand;
  SelectionIndexChange(
      {required this.seletedIndex, required this.selectedBrand});
}

class SelectionModelIndexChange extends BrandSelectionEvent {
  final int selectedModelIndex;
  final String selectedModel;
  SelectionModelIndexChange(
      {required this.selectedModelIndex, required this.selectedModel});
}

class FinishSetupButtonClicked extends BrandSelectionEvent {
  final Car car;

  FinishSetupButtonClicked({required this.car});
}
