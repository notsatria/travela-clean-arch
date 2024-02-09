import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';
import 'package:travela/features/destination/domain/usecases/get_all_destination_usecase.dart';

part 'all_destination_event.dart';
part 'all_destination_state.dart';

class AllDestinationBloc
    extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetAllDestinationUseCase _useCase;

  AllDestinationBloc(this._useCase) : super(AllDestinationInitial()) {
    on<GetAllDestinationEvent>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await _useCase();
      result.fold(
        (failure) => emit(AllDestinationFailure(message: failure.message)),
        (data) => emit(AllDestinationSuccess(data: data)),
      );
    });
  }
}
