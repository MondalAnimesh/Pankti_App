import 'package:fpdart/fpdart.dart';
import 'package:pankti_app/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure,SuccessType>> call(Params params);
}

class NoParams{}