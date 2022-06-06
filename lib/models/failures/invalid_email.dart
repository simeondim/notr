import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/with_sub_failure.dart';

class InvalidEmail implements Failure, WithSubFailure {
  const InvalidEmail(this.subFailure);

  @override
  final Failure subFailure;
}
