import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';

class SettingsCubit extends Cubit<void> {
  SettingsCubit({
    required this.authRepository,
  }) : super(());

  final AuthRepository authRepository;

  void onLogOutPressed() {
    authRepository.signOut();
  }
}
