part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  final bool isCarLoading;
  ProfileLoading({this.isCarLoading = false});
}

class ProfileFetchSuccess extends ProfileState {
  final UserModel user;
  ProfileFetchSuccess({required this.user});
}

class FetchUserCarsSuccess extends ProfileState {
  final List<Car> userCarList;
  FetchUserCarsSuccess({required this.userCarList});
}
//class ImageUpdatedSuccessfully extends ProfileState {}
