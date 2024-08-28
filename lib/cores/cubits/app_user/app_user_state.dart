part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

class AppUserLoggedInState extends AppUserState {
  final Profile profile;

  AppUserLoggedInState({required this.profile});
}
