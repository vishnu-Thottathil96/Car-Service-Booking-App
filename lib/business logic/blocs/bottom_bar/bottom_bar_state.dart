part of 'bottom_bar_bloc.dart';

class BottomBarState {
  final int tabIndex;
  const BottomBarState({required this.tabIndex});
}

final class BottomBarInitial extends BottomBarState {
  BottomBarInitial() : super(tabIndex: 0);
}
