// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

class AppLogoutRequest extends AppEvent {
  const AppLogoutRequest();
}

// ignore: unused_element
class AppUserChanged extends AppEvent {}
