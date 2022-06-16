import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}
