import 'package:galery_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, P> {
  Future<Either<Failure, Type>> call(P params);
}
