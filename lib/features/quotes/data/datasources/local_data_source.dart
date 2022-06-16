import 'dart:convert';

import 'package:quotes_app/core/error/exceptions.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/quotes/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheQuote(QuoteModel quoteModel);
}

class LocalDataSourceImp implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImp(this._sharedPreferences);
  @override
  Future<void> cacheQuote(QuoteModel quoteModel) {
    return _sharedPreferences.setString(
        AppStrings.cacheQuoteKey, json.encode(quoteModel));
  }

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString = _sharedPreferences.getString(AppStrings.cacheQuoteKey);
    if (jsonString != null) {
      final quote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return quote;
    } else {
      throw CacheException();
    }
  }
}
