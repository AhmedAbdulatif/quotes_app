import 'package:flutter/material.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/features/quotes/domain/entities/quote.dart';

class QuoteContent extends StatelessWidget {
  const QuoteContent({Key? key, required this.quote}) : super(key: key);
  final Quote quote;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: Column(
        children: [
          Text(
            quote.quote,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            quote.author,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
