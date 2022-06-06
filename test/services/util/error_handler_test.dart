import 'package:flutter_test/flutter_test.dart';
import 'package:notr/models/failure_manager.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/unknown.dart';
import 'package:notr/services/util/error_handler.dart';

class MockNullFailureManager implements FailureManager {
  @override
  Failure? getFailure(Object error) {
    return null;
  }
}

class MockEmptyInput implements Failure {
  const MockEmptyInput();
}

class MockEmptyInputFailureManager implements FailureManager {
  @override
  Failure? getFailure(Object error) {
    return const MockEmptyInput();
  }
}

main() {
  final nullFailureManager = MockNullFailureManager();
  final emptyInputManager = MockEmptyInputFailureManager();

  test(
    "should return the callback value",
    () async {
      final either = await errorHandler<bool>(() async => true);

      expect(either.value, isTrue);
    },
  );

  test(
    "should return Unknown when managers cannot deal with the error",
    () async {
      final either = await errorHandler<bool>(
        () => throw Object(),
        failureManagers: [
          nullFailureManager,
        ],
      );

      expect(either.value.runtimeType, Unknown);
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

      expect(either.value.runtimeType, MockEmptyInput);
    },
  );
}
