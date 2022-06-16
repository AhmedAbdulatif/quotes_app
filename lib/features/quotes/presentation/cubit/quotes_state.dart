part of 'quotes_cubit.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesInitialState extends QuotesState {}

class QuotesLoadingState extends QuotesState {}

class QuotesSuccessState extends QuotesState {
  final Quote quote;
  const QuotesSuccessState(this.quote);

  @override
  List<Object> get props => [quote];
}

class QuotesErrorState extends QuotesState {
  final String message;
  const QuotesErrorState(this.message);
  @override
  List<Object> get props => [message];
}
