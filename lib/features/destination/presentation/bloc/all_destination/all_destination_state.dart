part of 'all_destination_bloc.dart';

sealed class AllDestinationState extends Equatable {
  const AllDestinationState();

  @override
  List<Object> get props => [];
}

final class AllDestinationInitial extends AllDestinationState {}

final class AllDestinationLoading extends AllDestinationState {}

final class AllDestinationFailure extends AllDestinationState {
  final String message;

  const AllDestinationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class AllDestinationSuccess extends AllDestinationState {
  final List<DestinationEntity> data;

  const AllDestinationSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
