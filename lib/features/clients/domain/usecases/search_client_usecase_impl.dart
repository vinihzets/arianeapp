import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/architecture/usecase.dart';

class SearchClientUseCaseImpl
    implements UseCase<SearchClientParams, List<ClientEntity>> {
  ClientRepository repository;

  SearchClientUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(SearchClientParams params) {
    return repository.searchClient(params);
  }
}
