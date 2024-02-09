import 'package:dartz/dartz.dart';
import 'package:travela/core/error/failures.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';
import 'package:travela/features/destination/domain/repositories/destination_repository.dart';

class GetAllDestinationUseCase {
  final DestinationRepository _repository;

  GetAllDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.getDestinations();
  }
}
