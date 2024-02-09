import 'package:dartz/dartz.dart';
import 'package:travela/core/error/failures.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';
import 'package:travela/features/destination/domain/repositories/destination_repository.dart';

class GetTopDestinationUseCase {
  final DestinationRepository _repository;

  GetTopDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.getTops();
  }
}
