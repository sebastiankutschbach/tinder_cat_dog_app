part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool dogsPreferred;
  const SettingsState({required this.dogsPreferred});

  @override
  List<Object> get props => [dogsPreferred];
}
