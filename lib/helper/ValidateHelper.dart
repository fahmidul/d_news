class ValidateHelper {
  static String validateStringData(String data) {
    try {
       return data != null ? data : "";
    } catch (e) {}
    return "";
  }
}
