import 'package:notr/models/failures/failure.dart';

abstract class FailureManager {
  Failure? getFailure(Object object);
}
