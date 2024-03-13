class GstCalculation {
  static double addGstToPrice(double originalPrice) {
    const double gstRate = 18.0;
    double gstAmount = originalPrice * (gstRate / 100);
    double priceWithGst = originalPrice + gstAmount;
    String priceWithGstRounded = priceWithGst.toStringAsFixed(2);
    return double.parse(priceWithGstRounded);
  }

  static double calculateNthPercentageOfPrice(
      double originalPrice, double percentage) {
    double percentageAmount = originalPrice * (percentage / 100);
    String percentageAmountRounded = percentageAmount.toStringAsFixed(2);
    return double.parse(percentageAmountRounded);
  }
}
