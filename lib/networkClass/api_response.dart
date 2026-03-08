class ApiResponse<T> {
  Status? status;
  T? data;
  String message = "";
  bool success = false;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.responseData(this.data, this.success, this.message) {
    status = success ? Status.COMPLETED : Status.ERROR;
  }

  ApiResponse.response(this.success, this.message) {
    status = success ? Status.COMPLETED : Status.ERROR;
  }

  ApiResponse.error(this.message, {this.data}) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  bool isCompleted() => status == Status.COMPLETED;
}

enum Status { COMPLETED, ERROR }
