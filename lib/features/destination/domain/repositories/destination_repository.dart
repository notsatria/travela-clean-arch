import 'package:dartz/dartz.dart';
import 'package:travela/core/error/failures.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';

abstract class DestinationRepository {
  Future<Either<Failure, List<DestinationEntity>>> getDestinations();
  Future<Either<Failure, List<DestinationEntity>>> getTops();
  Future<Either<Failure, List<DestinationEntity>>> searchDestinations(
      String query);
}
