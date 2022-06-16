import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/features/quotes/data/datasources/local_data_source.dart';
import 'package:quotes_app/features/quotes/data/datasources/remote_data_source.dart';
import 'package:quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  QuoteRepositoryImpl(
      this._networkInfo, this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await _networkInfo.isConnected) {
      try {
        final quoteResponse = await _remoteDataSource.getRandomQuote();
        _localDataSource.cacheQuote(quoteResponse);
        return Right(quoteResponse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final quoteResponse = await _localDataSource.getLastRandomQuote();
        return Right(quoteResponse);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
