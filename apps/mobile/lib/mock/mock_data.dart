// All mock data — no backend dependency.

class MockClient {
  const MockClient({
    required this.id,
    required this.name,
    required this.hindiName,
    required this.tamilName,
    required this.initials,
    required this.statusKey,
    required this.actionKey,
    required this.avatarColor,
  });
  final String id;
  final String name;
  final String hindiName;
  final String tamilName;
  final String initials;
  final String statusKey; // kycPending | docBlurry | sipStarted | kycDone
  final String actionKey; // remind | reupload
  final int avatarColor;  // ARGB
}

class MockActivity {
  const MockActivity({
    required this.id,
    required this.description,
    required this.hindiDescription,
    required this.tamilDescription,
    required this.time,
    required this.iconCode,
    required this.iconColor,
  });
  final String id;
  final String description;
  final String hindiDescription;
  final String tamilDescription;
  final String time;
  final int iconCode;
  final int iconColor;
}

abstract final class MockData {
  static const double totalAum    = 48200000; // ₹4.82 Cr
  static const int    totalClients = 12;
  static const double monthDelta  = 38000;

  // Sparkline data — 6 months of AUM in lakhs
  static const List<double> sparklineData = [38.2, 40.5, 41.0, 43.8, 46.5, 48.2];

  // Month stats
  static const int clientsAdded  = 3;
  static const int remindersSent = 7;
  static const int kycCompleted  = 2;

  static const List<MockClient> attentionClients = [
    MockClient(
      id: 'c1',
      name: 'Anand Kumar',
      hindiName: 'आनंद कुमार',
      tamilName: 'ஆனந்த் குமார்',
      initials: 'AK',
      statusKey: 'kycPending',
      actionKey: 'remind',
      avatarColor: 0xFF0C544C,
    ),
    MockClient(
      id: 'c2',
      name: 'Lakshmi Devi',
      hindiName: 'लक्ष्मी देवी',
      tamilName: 'லக்ஷ்மி தேவி',
      initials: 'LD',
      statusKey: 'docBlurry',
      actionKey: 'reupload',
      avatarColor: 0xFF168072,
    ),
    MockClient(
      id: 'c3',
      name: 'Rajesh Patel',
      hindiName: 'राजेश पटेल',
      tamilName: 'ராஜேஷ் படேல்',
      initials: 'RP',
      statusKey: 'kycPending',
      actionKey: 'remind',
      avatarColor: 0xFF8B6914,
    ),
  ];

  static const List<MockActivity> recentActivity = [
    MockActivity(
      id: 'a1',
      description: 'Meena Sharma completed KYC',
      hindiDescription: 'मीना शर्मा ने KYC पूर्ण किया',
      tamilDescription: 'மீனா சர்மா KYC முடித்தார்',
      time: '2h ago',
      iconCode: 0xe876,
      iconColor: 0xFF1A7A4A,
    ),
    MockActivity(
      id: 'a2',
      description: 'SIP of ₹5,000 started for Ravi G.',
      hindiDescription: 'रवि G के लिए ₹5,000 SIP शुरू',
      tamilDescription: 'ரவி G-க்கு ₹5,000 SIP தொடங்கியது',
      time: '5h ago',
      iconCode: 0xe8e8,
      iconColor: 0xFF0C544C,
    ),
    MockActivity(
      id: 'a3',
      description: 'New client Preethi added',
      hindiDescription: 'नया ग्राहक प्रीति जोड़ा गया',
      tamilDescription: 'புதிய வாடிக்கையாளர் பிரீதி சேர்க்கப்பட்டார்',
      time: 'Yesterday',
      iconCode: 0xe7fe,
      iconColor: 0xFF1657C4,
    ),
  ];
}
