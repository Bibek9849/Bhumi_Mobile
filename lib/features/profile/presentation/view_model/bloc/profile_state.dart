// part of 'profile_bloc.dart';

// sealed class ProfileState extends Equatable {
//   const ProfileState();

//   @override
//   List<Object> get props => [];
// }

// // ProfileInitial state for the initial state
// class ProfileInitial extends ProfileState {}

// // ProfileLoading state when the profile is being loaded
// class ProfileLoading extends ProfileState {}

// // ProfileLoaded state when the profile is successfully loaded
// class ProfileLoaded extends ProfileState {
//   final String username;
//   final String profileImage;

//   const ProfileLoaded({required this.username, required this.profileImage});

//   @override
//   List<Object> get props => [username, profileImage];
// }

// // ProfileError state when there's an error
// class ProfileError extends ProfileState {
//   final String message;

//   const ProfileError(this.message);

//   @override
//   List<Object> get props => [message];
// }
