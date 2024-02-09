import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';
import 'package:travela/features/destination/domain/usecases/search_destination_usecase.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc
    extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  final SearchDestinationUseCase _useCase;
  SearchDestinationBloc(this._useCase) : super(SearchDestinationInitial()) {
    on<OnSearchDestinationEvent>((event, emit) async {
      emit(SearchDestinationLoading());
      final result = await _useCase(event.query);
      result.fold(
        (failure) => emit(SearchDestinationFailure(message: failure.message)),
        (data) => emit(SearchDestinationSuccess(data: data)),
      );
    });
  }
}
