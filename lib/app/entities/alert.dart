class Alert {
  String? title;
  String? message;
  bool success = false;
  Alert({this.title, this.message});
  Alert.success(res) {
    title = "Sucesso";
    message = res;
    success = true;
  }

  Alert.error(res) {
    title = "Error";
    message = res;
    success = false;
  }
}
