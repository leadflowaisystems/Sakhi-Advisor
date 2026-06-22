// Minimal localisation — English & Tamil strings for the Home screen preview.
// Extend with Hindi (Devanagari) as needed.
enum SakhiLocale { english, tamil }

class SakhiStrings {
  const SakhiStrings._(this._locale);

  final SakhiLocale _locale;

  static SakhiStrings of(SakhiLocale locale) => SakhiStrings._(locale);

  String get appName => _s('Sakhi Advisor', 'சாக்கி அட்வைசர்');

  String greet(String name) => _locale == SakhiLocale.english
      ? 'Good morning, $name'
      : 'காலை வணக்கம், $name';

  String get heroPracticeLabel => _s('Your practice', 'உங்கள் தொழில்');
  String get heroMonthLabel    => _s('June 2025', 'ஜூன் 2025');
  String get heroSubtitle      => _s(
    'Assets you\'re guiding across 12 clients',
    '12 வாடிக்கையாளர்கள் வழியாக நீங்கள் வழிநடத்தும் சொத்துகள்',
  );
  String get heroTrend => _s('↑ ₹38,000 this month', '↑ ₹38,000 இந்த மாதம்');

  String get sectionMonthSoFar => _s('Your month so far', 'இந்த மாதம் இதுவரை');
  String get statClientsAdded  => _s('Clients added', 'வாடிக்கையாளர்கள்');
  String get statRemindersSent => _s('Reminders sent', 'நினைவூட்டல்கள்');
  String get statKycCompleted  => _s('KYC completed', 'KYC முடிந்தது');

  String get sectionAttention  => _s('Needs your attention', 'கவனம் தேவை');
  String get seeAll            => _s('See all', 'அனைத்தும்');
  String get remind            => _s('Remind', 'நினைவூட்டு');
  String get reupload          => _s('Re-upload', 'மீண்டும் ஏற்று');

  String get sectionRecent     => _s('Recent activity', 'சமீபத்திய செயல்');
  String get addClient         => _s('Add client', 'வாடிக்கையாளரை சேர்');

  // Bottom nav
  String get navHome      => _s('Home', 'முகப்பு');
  String get navClients   => _s('Clients', 'வாடிக்கையாளர்');
  String get navReports   => _s('Reports', 'அறிக்கைகள்');
  String get navReminders => _s('Reminders', 'நினைவூட்டல்');
  String get navMore      => _s('More', 'மேலும்');

  // Empty state
  String get emptyTitle    => _s('Your journey starts here', 'உங்கள் பயணம் இங்கே தொடங்குகிறது');
  String get emptySubtitle => _s(
    'Add your first client and start building your practice.',
    'உங்கள் முதல் வாடிக்கையாளரை சேர்த்து தொழிலை தொடங்குங்கள்.',
  );
  String get emptyAction   => _s('Add your first client', 'முதல் வாடிக்கையாளரை சேர்க்கவும்');

  // Status labels
  String get kycPending    => _s('KYC Pending', 'KYC நிலுவை');
  String get docBlurry     => _s('Doc blurry', 'ஆவணம் மங்கலாக உள்ளது');
  String get sipStarted    => _s('SIP started', 'SIP தொடங்கியது');
  String get kycDone       => _s('KYC done', 'KYC முடிந்தது');
  String get newClient     => _s('New client', 'புதிய வாடிக்கையாளர்');

  String _s(String en, String ta) =>
      _locale == SakhiLocale.english ? en : ta;
}
