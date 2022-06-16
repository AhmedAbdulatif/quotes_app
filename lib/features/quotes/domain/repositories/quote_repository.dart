import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/features/quotes/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
