import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quotes_app/core/error/failures.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:quotes_app/features/quotes/domain/usecases/random_quote_usecase.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  final RandomQuoteUsecase _randomQuoteUsecase;
  QuotesCubit(this._randomQuoteUsecase) : super(QuotesInitialState());

  Future<void> getRandomQuote() async {
    emit(QuotesLoadingState());
    Either<Failure, Quote> response =
        await _randomQuoteUsecase.execute(NoParams());
    emit(response.fold((failure) {
      return QuotesErrorState(failure.convert());
    }, (quote) {
      return QuotesSuccessState(quote);
    }));
  }
}

extension FailureToMessage on Failure {
  String convert() {
    switch (runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }
}
