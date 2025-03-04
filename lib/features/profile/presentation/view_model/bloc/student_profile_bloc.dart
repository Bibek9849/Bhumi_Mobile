import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/presentation/view/login_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:bhumi_mobile/features/profile/domain/use_case/get_student_profile_usecase.dart';
import 'package:bhumi_mobile/features/profile/domain/use_case/update_student_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final GetStudentProfileUsecase _getStudentProfileUsecase;
  final UpdateStudentProfileUsecase _updateStudentProfileUsecase;

  StudentProfileBloc({
    required GetStudentProfileUsecase getStudentProfileUsecase,
    required UpdateStudentProfileUsecase updateStudentProfileUsecase,
  })  : _getStudentProfileUsecase = getStudentProfileUsecase,
        _updateStudentProfileUsecase = updateStudentProfileUsecase,
        super(StudentProfileInitial()) {
    on<FetchStudentProfile>(_onFetchStudentProfile);
    on<UpdateStudentProfile>(_onUpdateStudentProfile);
  }
  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }

  /// 🔹 Fetch Student Profile
  Future<void> _onFetchStudentProfile(
      FetchStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileLoading());

    final result = await _getStudentProfileUsecase();

    result.fold(
      (failure) =>
          emit(StudentProfileError(message: _mapFailureToMessage(failure))),
      (student) => emit(StudentProfileLoaded(student: student)),
    );
  }

  /// 🔹 Update Student Profile
  Future<void> _onUpdateStudentProfile(
      UpdateStudentProfile event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileLoading());

    final result = await _updateStudentProfileUsecase(event.updatedData);

    result.fold(
      (failure) =>
          emit(StudentProfileError(message: _mapFailureToMessage(failure))),
      (updatedStudent) {
        emit(StudentProfileUpdated(student: updatedStudent));
        // emit(StudentProfileLoaded(student: updatedStudent)); // ✅ Update UI immediately
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else if (failure is SharedPrefsFailure) {
      return "Failed to retrieve user authentication details.";
    } else {
      return "An unexpected error occurred.";
    }
  }
}
