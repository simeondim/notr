import 'package:notr/managers/application_error_manager.dart';
import 'package:notr/models/either.dart';
import 'package:notr/models/failure_manager.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/unknown.dart';

Future<Either<Failure, T>> errorHandler<T>(
  AsyncCallBack<T> callback, {
  List<FailureManager> failureManagers = const [],
}) async {
  try {
    return Right(await callback());
  } catch (error, stack) {
    if (error is Failure) return Left(error);

    for (final manager in failureManagers) {
      final failure = manager.getFailure(error);
      if (failure != null) return Left(failure);
    }

    const ApplicationErrorManager().handleError(error, stack);
    return Left(const Unknown());
  }
}
