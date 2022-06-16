import 'package:quotes_app/core/api/api_client.dart';
import 'package:quotes_app/core/api/end_points.dart';

import 'package:quotes_app/features/quotes/data/models/quote_model.dart';

abstract class RemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient _client;
  RemoteDataSourceImpl(this._client);
  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await _client.get(EndPoints.randomQuote);
    return QuoteModel.fromJson(response);
  }
}
