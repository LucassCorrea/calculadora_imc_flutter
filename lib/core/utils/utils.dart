class Utils {
  static double toDouble(String text) {
    try {
      return double.parse(text);
    } catch (e) {
      return 0.0;
    }
  }
}
