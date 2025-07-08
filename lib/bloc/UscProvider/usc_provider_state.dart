part of 'usc_provider_bloc.dart';

@immutable
abstract class UscProviderState {}

class UscProviderInitial extends UscProviderState {}

class UscProviderLoading extends UscProviderState {}

class UscProviderLoaded extends UscProviderState {
  final List<Map<String, dynamic>> provider;

  UscProviderLoaded(this.provider);
}

class UscProviderError extends UscProviderState {}
