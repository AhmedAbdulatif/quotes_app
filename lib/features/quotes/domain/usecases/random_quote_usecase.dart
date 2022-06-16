import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class RandomQuoteUsecase extends Usecase<Quote, NoParams> {
  final QuoteRepository _quoteRepository;
  RandomQuoteUsecase(this._quoteRepository);
  @override
  Future<Either<Failure, Quote>> execute(NoParams params) {
    return _quoteRepository.getRandomQuote();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
