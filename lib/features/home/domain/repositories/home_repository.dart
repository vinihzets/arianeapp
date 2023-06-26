import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> signOut();
}
