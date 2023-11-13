import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motox/data/models/model_car.dart';
import 'package:motox/data/models/model_user.dart';
import 'package:motox/data/repositories/user_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetching>(profileFetching);
    on<SelectImageFromGallery>(selectImageFromGallery);
    on<FetchUserCars>(fetchUserCars);
  }

  FutureOr<void> profileFetching(
      ProfileFetching event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final user = await UserRepository.getCurrentUserById(
        FirebaseAuth.instance.currentUser!.uid);
    emit(ProfileFetchSuccess(user: user));
  }

  FutureOr<void> selectImageFromGallery(
      SelectImageFromGallery event, Emitter<ProfileState> emit) async {
    final image = await UserRepository.selectImageFromGallery();
    if (image != null) {
      await UserRepository.uploadProfileImageToFirebase(
          FirebaseAuth.instance.currentUser!.uid, image);
      final user = await UserRepository.getCurrentUserById(
          FirebaseAuth.instance.currentUser!.uid);
      emit(ProfileFetchSuccess(user: user));
    }
  }

  FutureOr<void> fetchUserCars(
      FetchUserCars event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading(isCarLoading: true));
    final userCars =
        await UserRepository.userCars(FirebaseAuth.instance.currentUser!.uid);
    emit(FetchUserCarsSuccess(userCarList: userCars));
  }
}
