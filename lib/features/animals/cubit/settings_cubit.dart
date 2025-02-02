import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(dogsPreferred: false));

  void changePreference({required bool dogsPreferred}) =>
      emit(SettingsState(dogsPreferred: dogsPreferred));
}
