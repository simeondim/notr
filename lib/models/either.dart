typedef AsyncCallBack<T> = Future<T> Function();

typedef Callback<T> = void Function(T value);

abstract class Either<L, R> {
  Either() {
    if (!isLeft && !isRight) {
      throw Exception('The ether should be Left or Right.');
    }
  }

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  Object get value;

  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight);

  void either(Callback<L> fnL, Callback<R> fnR) {
    if (isLeft) {
      final Left<L, R> left = this as Left<L, R>;
      return fnL(left.val);
    }

    if (isRight) {
      final Right<L, R> right = this as Right<L, R>;
      return fnR(right.val);
    }
  }
}

// Failure
class Left<L, R> extends Either<L, R> {
  Left(this.val);

  final L val;

  @override
  Object get value => val as Object;

  @override
  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight) => onLeft(val);
}

// Success
class Right<L, R> extends Either<L, R> {
  Right(this.val);
  final R val;

  @override
  Object get value => val as Object;

  @override
  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight) => onRight(val);
}
