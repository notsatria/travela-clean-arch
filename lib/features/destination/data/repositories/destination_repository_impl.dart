import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:travela/core/error/exceptions.dart';
import 'package:travela/core/error/failures.dart';
import 'package:travela/core/platform/network_info.dart';
import 'package:travela/features/destination/data/datasource/destination_local_datasource.dart';
import 'package:travela/features/destination/data/datasource/destination_remote_datasource.dart';
import 'package:travela/features/destination/domain/entities/destination_entity.dart';
import 'package:travela/features/destination/domain/repositories/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationRemoteDataSource remoteDataSource;
  final DestinationLocalDataSource localDataSource;

  DestinationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinations() async {
    bool online = await networkInfo.isConnected();

    if (online) {
      try {
        final result = await remoteDataSource.getDestinations();
        await localDataSource.cacheAllDestinations(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on NotFoundException {
        return const Left(NotFoundFailure(message: 'Data not found'));
      } on ServerException {
        return const Left(ServerFailure(message: 'Server error'));
      } on TimeoutException {
        return const Left(TimeoutFailure(message: 'Timeout. No Response'));
      }
    } else {
      try {
        final result = await localDataSource.getAllDestinations();
        return Right(result.map((e) => e.toEntity).toList());
      } on CacheException {
        return const Left(CacheFailure(message: 'Cache error'));
      } on NotFoundException {
        return const Left(NotFoundFailure(message: 'Data not found'));
      }
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getTops() async {
   try {
      final result = await remoteDataSource.getTops();
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure(message: 'Data not found'));
    } on ServerException {
      return const Left(ServerFailure(message: 'Server error'));
    } on TimeoutException {
      return const Left(TimeoutFailure(message: 'Timeout. No Response'));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> searchDestinations(
      String query) async {
    try {
      final result = await remoteDataSource.searchDestinations(query);
      return Right(result.map((e) => e.toEntity).toList());
    } on NotFoundException {
      return const Left(NotFoundFailure(message: 'Data not found'));
    } on ServerException {
      return const Left(ServerFailure(message: 'Server error'));
    } on TimeoutException {
      return const Left(TimeoutFailure(message: 'Timeout. No Response'));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
