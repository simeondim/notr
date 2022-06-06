import 'package:notr/models/failures/failure.dart';

abstract class WithSubFailure implements Failure {
  Failure? get subFailure;
}
