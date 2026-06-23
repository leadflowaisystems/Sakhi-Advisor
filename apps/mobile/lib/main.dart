import 'package:flutter/material.dart';
import 'theme/sakhi_theme.dart';
import 'theme/sakhi_colors.dart';
import 'theme/sakhi_typography.dart';
import 'utils/l10n.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const SakhiApp());
}

class SakhiApp extends StatefulWidget {
  const SakhiApp({super.key});

  @override
  State<SakhiApp> createState() => _SakhiAppState();
}

class _SakhiAppState extends State<SakhiApp> {
  SakhiLocale _locale = SakhiLocale.english;
  HomeState _homeState = HomeState.data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sakhi Advisor',
      debugShowCheckedModeBanner: false,
      theme: buildSakhiTheme(),
      // Warm canvas fills the sides on wide screens
      color: SakhiColors.canvas,
      builder: (context, child) => ColoredBox(
        color: SakhiColors.canvas,
        child: child!,
      ),
      home: _PhoneFrame(
        child: Stack(
          children: [
            HomeScreen(
              key: ValueKey('${_locale}_$_homeState'),
              locale: _locale,
              initialState: _homeState,
            ),
            _PreviewToolbar(
              locale: _locale,
              homeState: _homeState,
              onLocaleChanged: (l) => setState(() => _locale = l),
              onStateChanged: (s) => setState(() => _homeState = s),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Phone frame: centres content at max 440 dp on wide screens ───────────────
class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SakhiColors.canvas,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: child,
        ),
      ),
    );
  }
}

// ── Preview toolbar ───────────────────────────────────────────────────────────
class _PreviewToolbar extends StatefulWidget {
  const _PreviewToolbar({
    required this.locale,
    required this.homeState,
    required this.onLocaleChanged,
    required this.onStateChanged,
  });

  final SakhiLocale locale;
  final HomeState homeState;
  final ValueChanged<SakhiLocale> onLocaleChanged;
  final ValueChanged<HomeState> onStateChanged;

  @override
  State<_PreviewToolbar> createState() => _PreviewToolbarState();
}

class _PreviewToolbarState extends State<_PreviewToolbar> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top + 54;
    return Positioned(
      top: top,
      right: 8,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: SakhiColors.neutral900.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _expanded ? Icons.close : Icons.tune_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Preview',
                      style: SakhiText.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_expanded) ...[
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: SakhiColors.neutral900.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Language',
                        style: SakhiText.caption.copyWith(
                            color: Colors.white54, fontSize: 10)),
                    const SizedBox(height: 4),
                    _ToggleRow(
                      options: const ['EN', 'हिंदी', 'தமிழ்'],
                      selected: switch (widget.locale) {
                        SakhiLocale.english => 0,
                        SakhiLocale.hindi   => 1,
                        SakhiLocale.tamil   => 2,
                      },
                      onSelect: (i) => widget.onLocaleChanged(
                        switch (i) {
                          1 => SakhiLocale.hindi,
                          2 => SakhiLocale.tamil,
                          _ => SakhiLocale.english,
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('State',
                        style: SakhiText.caption.copyWith(
                            color: Colors.white54, fontSize: 10)),
                    const SizedBox(height: 4),
                    _ToggleRow(
                      options: const ['Data', 'Loading', 'Empty'],
                      selected: switch (widget.homeState) {
                        HomeState.data    => 0,
                        HomeState.loading => 1,
                        HomeState.empty   => 2,
                      },
                      onSelect: (i) => widget.onStateChanged(
                        switch (i) {
                          1 => HomeState.loading,
                          2 => HomeState.empty,
                          _ => HomeState.data,
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < options.length; i++)
          GestureDetector(
            onTap: () => onSelect(i),
            child: Container(
              margin: EdgeInsets.only(right: i < options.length - 1 ? 3 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: selected == i ? SakhiColors.brandMid : Colors.white12,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                options[i],
                style: SakhiText.caption.copyWith(
                  color: Colors.white,
                  fontWeight:
                      selected == i ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
