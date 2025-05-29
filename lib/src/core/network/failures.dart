import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.errorMessage);
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

/// General failures Server
class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage, this.statusCode);
  final int? statusCode;
}

/// Cancel token failure
class CancelTokenFailure extends Failure {
  const CancelTokenFailure(super.errorMessage, this.statusCode);
  final int? statusCode;
}

/// General Exceptions
//
class GeneralException extends Failure {
  const GeneralException(super.errorMessage);
}
