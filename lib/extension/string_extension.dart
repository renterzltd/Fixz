extension StringUtils on String {
  String replaceVariables(Map<String, String> map) {
    String value = this;
    map.forEach((key, it) {
      value.replaceAll("%&$key", it);
    });
    return value;
  }

  String toNotNullString() {
    return (this != null && this != "null") ? this : "";
  }
}