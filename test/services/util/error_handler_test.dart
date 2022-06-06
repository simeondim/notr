import 'package:flutter_test/flutter_test.dart';
import 'package:notr/models/failure_manager.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/unknown_failure.dart';
import 'package:notr/services/util/error_handler.dart';

class MockNullFailureManager implements FailureManager {
  @override
  Failure? getFailure(Object error) {
    return null;
  }
}

class EmptyInput implements Failure {
  const EmptyInput();
}

class MockEmptyInputFailureManager implements FailureManager {
  @override
  Failure? getFailure(Object error) {
    return const EmptyInput();
  }
}

main() {
  final nullFailureManager = MockNullFailureManager();
  final emptyInputManager = MockEmptyInputFailureManager();

  test(
    "should return the callback value",
    () async {
      final either = await errorHandler<bool>(() async => true);

      expect(either.returnedValue, isA<bool>());
      expect(either.returnedValue, isTrue);
    },
  );

  test(
    "should return UnknownFailure when managers cannot deal with the error",
    () async {
      final either = await errorHandler<bool>(
        () => throw Object(),
        failureManagers: [
          nullFailureManager,
        ],
      );

      expect(either.returnedValue, isA<UnknownFailure>());
    },
  );

  test(
    "should return failure from managers if the error is known for the manager",
    () async {
      final either = await errorHandler<bool>(
        () => throw Object(),
        failureManagers: [
          emptyInputManager,
        ],
      );

      expect(either.returnedValue, isA<EmptyInput>());
    },
  );
}
