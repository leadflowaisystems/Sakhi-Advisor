import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_typography.dart';
import '../utils/l10n.dart';

class SakhiScaffold extends StatelessWidget {
  const SakhiScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNav,
    this.fab,
    this.backgroundColor,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNav;
  final Widget? fab;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SakhiColors.canvas,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNav,
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class SakhiBottomNav extends StatelessWidget {
  const SakhiBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.strings,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final SakhiStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: SakhiColors.surface,
        border: Border(
          top: BorderSide(color: SakhiColors.hairline, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: strings.navHome,
                selected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.people_rounded,
                label: strings.navClients,
                selected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: strings.navReports,
                selected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: Icons.notifications_rounded,
                label: strings.navReminders,
                selected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
              _NavItem(
                icon: Icons.more_horiz_rounded,
                label: strings.navMore,
                selected: currentIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? SakhiColors.primary50
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 22,
                color: selected ? SakhiColors.brand : SakhiColors.neutral400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: SakhiText.caption.copyWith(
                color: selected ? SakhiColors.brand : SakhiColors.neutral400,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
