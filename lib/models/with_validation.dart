import 'package:notr/models/failures/failure.dart';

abstract class WithValidation {
  Failure? validate();
}
