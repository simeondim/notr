import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/with_sub_failure.dart';

class InvalidPassword implements Failure, WithSubFailure {
  const InvalidPassword(this.subFailure);

  @override
  final Failure subFailure;
}
