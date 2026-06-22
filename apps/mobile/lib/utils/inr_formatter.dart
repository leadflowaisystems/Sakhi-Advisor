// INR formatter with Indian lakh/crore grouping: ₹4,82,000 / ₹1.2Cr
class InrFormatter {
  static String format(double amount, {bool compact = false}) {
    if (compact) return _compact(amount);
    return '₹${_groupIndian(amount.round())}';
  }

  static String formatInt(int amount) => '₹${_groupIndian(amount)}';

  // Indian grouping: last 3 digits, then pairs: 4,82,000
  static String _groupIndian(int n) {
    if (n < 0) return '-${_groupIndian(-n)}';
    final s = n.toString();
    if (s.length <= 3) return s;
    final buf = StringBuffer();
    final len = s.length;
    // first group: rightmost 3
    final firstGroupEnd = len - 3;
    // remaining digits — group by 2 from right
    final remaining = s.substring(0, firstGroupEnd);
    buf.write(_groupPairs(remaining));
    buf.write(',');
    buf.write(s.substring(firstGroupEnd));
    return buf.toString();
  }

  static String _groupPairs(String s) {
    if (s.length <= 2) return s;
    final buf = StringBuffer();
    final start = s.length % 2;
    if (start > 0) {
      buf.write(s.substring(0, start));
    }
    for (int i = start; i < s.length; i += 2) {
      if (buf.isNotEmpty) buf.write(',');
      buf.write(s.substring(i, i + 2));
    }
    return buf.toString();
  }

  static String _compact(double n) {
    if (n >= 1e7) {
      final cr = n / 1e7;
      return '₹${cr.toStringAsFixed(cr >= 10 ? 1 : 2)}Cr';
    }
    if (n >= 1e5) {
      final lk = n / 1e5;
      return '₹${lk.toStringAsFixed(lk >= 10 ? 1 : 2)}L';
    }
    if (n >= 1e3) {
      final k = n / 1e3;
      return '₹${k.toStringAsFixed(0)}K';
    }
    return format(n);
  }
}
