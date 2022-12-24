import '../Utilities/Snacki.dart';

class RequestStatus {
  Status status = Status.NotCalled;
  String? _message;

  get message => _message ?? 'خطایی رخ داده است';

  set message(_m) {
    status = Status.Error;
    _message = _m;
  }

  @override
  bool operator ==(_status) {
    if (_status is Status) {
      return status == _status;
    }
    return false;
  }

  @override
  int get hashCode {
    return status.hashCode;
  }

  void loading() {
    status = Status.Loading;
  }

  void success({String? message}) {
    status = Status.Success;
    if (message != null) {
      Snacki().GETSnackBar(true, message);
    }
  }

  void notCalled() {
    status = Status.NotCalled;
  }

  void error(String message) {
    status = Status.Error;
    _message = message;
    Snacki().GETSnackBar(false, message);
  }

  void clear() {
    status = Status.NotCalled;
    _message = null;
  }
}

enum Status {
  NotCalled,
  Loading,
  Success,
  Error,
}
