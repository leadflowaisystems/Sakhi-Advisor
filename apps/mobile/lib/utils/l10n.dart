// Localisation — English, Hindi (Devanagari) & Tamil for the Home screen.
enum SakhiLocale { english, hindi, tamil }

class SakhiStrings {
  const SakhiStrings._(this._locale);

  final SakhiLocale _locale;
  SakhiLocale get locale => _locale;

  static SakhiStrings of(SakhiLocale locale) => SakhiStrings._(locale);

  String get appName => _s('Sakhi Advisor', 'साखी एडवाइजर', 'சாக்கி அட்வைசர்');

  String greet(String name) => switch (_locale) {
    SakhiLocale.english => 'Good morning, $name',
    SakhiLocale.hindi   => 'सुप्रभात, $name',
    SakhiLocale.tamil   => 'காலை வணக்கம், $name',
  };

  String get heroPracticeLabel => _s('Your practice', 'आपका व्यवसाय', 'உங்கள் தொழில்');
  String get heroMonthLabel    => _s('June 2025', 'जून 2025', 'ஜூன் 2025');
  String get heroSubtitle      => _s(
    'Assets across 12 clients',
    '12 ग्राहकों की संपत्ति',
    '12 வாடிக்கையாளர் சொத்துகள்',
  );
  String get heroTrend => _s('↑ ₹38,000 this month', '↑ ₹38,000 इस माह', '↑ ₹38,000 இம்மாதம்');

  String get sectionMonthSoFar => _s('Your month so far', 'इस माह अब तक', 'இந்த மாதம் இதுவரை');
  String get statClientsAdded  => _s('Clients added', 'ग्राहक जोड़े', 'வாடிக்கையாளர்கள்');
  String get statRemindersSent => _s('Reminders sent', 'रिमाइंडर', 'நினைவூட்டல்கள்');
  String get statKycCompleted  => _s('KYC done', 'KYC पूर्ण', 'KYC முடிந்தது');

  String get sectionAttention  => _s('Needs your attention', 'ध्यान चाहिए', 'கவனம் தேவை');
  String get seeAll            => _s('See all', 'सभी देखें', 'அனைத்தும்');
  String get remind            => _s('Remind', 'याद दिलाएं', 'நினைவூட்டு');
  String get reupload          => _s('Re-upload', 'पुनः अपलोड', 'மீண்டும் ஏற்று');

  String get sectionRecent     => _s('Recent activity', 'हाल की गतिविधि', 'சமீபத்திய செயல்');
  String get addClient         => _s('Add client', 'ग्राहक जोड़ें', 'வாடிக்கையாளரை சேர்');

  // Bottom nav
  String get navHome      => _s('Home',      'होम',       'முகப்பு');
  String get navClients   => _s('Clients',   'ग्राहक',    'வாடிக்கையாளர்');
  String get navReports   => _s('Reports',   'रिपोर्ट',   'அறிக்கைகள்');
  String get navReminders => _s('Reminders', 'रिमाइंडर',  'நினைவூட்டல்');
  String get navMore      => _s('More',      'और',        'மேலும்');

  // Empty state
  String get emptyTitle    => _s(
    'Your journey starts here',
    'आपकी यात्रा यहाँ शुरू होती है',
    'உங்கள் பயணம் இங்கே தொடங்குகிறது',
  );
  String get emptySubtitle => _s(
    'Add your first client and start building your practice.',
    'पहला ग्राहक जोड़ें और व्यवसाय शुरू करें।',
    'உங்கள் முதல் வாடிக்கையாளரை சேர்த்து தொழிலை தொடங்குங்கள்.',
  );
  String get emptyAction   => _s(
    'Add your first client',
    'पहला ग्राहक जोड़ें',
    'முதல் வாடிக்கையாளரை சேர்க்கவும்',
  );

  // Status labels
  String get kycPending => _s('KYC Pending', 'KYC लंबित',      'KYC நிலுவை');
  String get docBlurry  => _s('Doc blurry',  'दस्तावेज़ धुंधला', 'ஆவணம் மங்கலாக');
  String get sipStarted => _s('SIP started', 'SIP शुरू',        'SIP தொடங்கியது');
  String get kycDone    => _s('KYC done',    'KYC पूर्ण',       'KYC முடிந்தது');
  String get newClient  => _s('New client',  'नया ग्राहक',       'புதிய வாடிக்கையாளர்');

  // Celebration
  String get celebGreatWork => _s('Great work, Priya! 🎉', 'शाबाश, Priya! 🎉', 'அருமை, பிரியா! 🎉');
  String get celebFirstClient => _s('First client added!', 'पहला ग्राहक जोड़ा!', 'முதல் வாடிக்கையாளர் சேர்க்கப்பட்டார்!');
  String get celebAddingClient => _s('Adding new client...', 'नया ग्राहक जोड़ रहे हैं...', 'புதிய வாடிக்கையாளரை சேர்க்கிறோம்...');

  String _s(String en, String hi, String ta) => switch (_locale) {
    SakhiLocale.english => en,
    SakhiLocale.hindi   => hi,
    SakhiLocale.tamil   => ta,
  };
}
