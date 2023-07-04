import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:dartz/dartz.dart';

class GetPendingUseCaseImpl
    implements UseCase<GetPendingsParams, List<PendingEntity>> {
  PendingRepository repository;

  GetPendingUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<PendingEntity>>> call(GetPendingsParams params) {
    return repository.getPendings(
      date: params.date,
      startAfter: params.startAfter,
      ammount: params.ammount,
    );
  }
}
