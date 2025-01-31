import 'dart:io';

import 'package:bhumi_mobile/common/my_snackbar.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUserUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  SignupBloc({
    required RegisterUserUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const SignupState.initial()) {
    //load jobs here
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);

    // add(LoadCoursesAndBatches());
  }

  // void _onLoadCoursesAndBatches(
  //   LoadCoursesAndBatches event,
  //   Emitter<RegisterState> emit,
  // ) {
  //   emit(state.copyWith(isLoading: true));
  //   _batchBloc.add(LoadBatches());
  //   _courseBloc.add(CourseLoad());
  //   emit(state.copyWith(isLoading: false, isSuccess: true));
  // }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fullName: event.fullName,
      email: event.email,
      contact: event.contact,
      address: event.address,
      password: event.password,
      image: state.imageName,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
