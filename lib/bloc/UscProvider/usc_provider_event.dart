part of 'usc_provider_bloc.dart';

@immutable
abstract class UscProviderEvent extends Equatable {
  const UscProviderEvent();

  @override
  List<Object> get props => [];
}

class LoadUscProvider extends UscProviderEvent {}

class AddUscProvider extends UscProviderEvent {
  final Map<String, dynamic> provider;

  AddUscProvider(this.provider);
}
