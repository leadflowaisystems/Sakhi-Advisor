import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/sakhi_colors.dart';
import '../../theme/sakhi_elevation.dart';
import '../../theme/sakhi_typography.dart';
import '../../utils/l10n.dart';
import '../../mock/mock_data.dart';
import '../../widgets/sakhi_scaffold.dart';
import '../../widgets/sakhi_avatar.dart';
import '../../widgets/sakhi_section_header.dart';
import '../../widgets/shimmer_skeleton.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/milestone_celebration.dart';
import '../../widgets/stagger_entrance.dart';
import 'widgets/hero_card.dart';
import 'widgets/stat_tile.dart';
import 'widgets/attention_row.dart';
import 'widgets/activity_row.dart';

enum HomeState { loading, empty, data }

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.locale,
    this.initialState = HomeState.data,
  });

  final SakhiLocale locale;
  final HomeState initialState;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeState _state;
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  Future<void> _onRefresh() async {
    setState(() => _state = HomeState.loading);
    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _state = HomeState.data);
  }

  SakhiStrings get _s => SakhiStrings.of(widget.locale);

  @override
  Widget build(BuildContext context) {
    return SakhiScaffold(
      appBar: _buildAppBar(),
      bottomNav: SakhiBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        strings: _s,
      ),
      fab: _state == HomeState.data ? _buildFab() : null,
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: SakhiColors.canvas,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _s.greet('Priya'),
            style: SakhiText.title.copyWith(color: SakhiColors.neutral900),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            _s.heroMonthLabel,
            style: SakhiText.caption,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => MilestoneCelebration.show(
              context,
              message: widget.locale == SakhiLocale.english
                  ? 'Great work, Priya! 🎉'
                  : 'அருமை, பிரியா! 🎉',
            ),
            child: const SakhiAvatar(
              initials: 'PA',
              size: 36,
              backgroundColor: SakhiColors.brand,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return switch (_state) {
      HomeState.loading => _LoadingState(),
      HomeState.empty   => _buildEmpty(),
      HomeState.data    => _buildData(),
    };
  }

  Widget _buildEmpty() {
    return Center(
      child: SakhiEmptyState(
        title: _s.emptyTitle,
        subtitle: _s.emptySubtitle,
        actionLabel: _s.emptyAction,
        onAction: () => MilestoneCelebration.show(
          context,
          message: widget.locale == SakhiLocale.english
              ? 'First client added!'
              : 'முதல் வாடிக்கையாளர் சேர்க்கப்பட்டார்!',
        ),
      ),
    );
  }

  Widget _buildData() {
    return RefreshIndicator(
      color: SakhiColors.brand,
      backgroundColor: SakhiColors.surface,
      strokeWidth: 2.5,
      onRefresh: _onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ── Hero card ─────────────────────────────────────────────
                StaggerEntrance(
                  index: 0,
                  child: HeroCard(strings: _s),
                ),

                const SizedBox(height: 24),

                // ── Month stats ───────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SakhiSectionHeader(title: _s.sectionMonthSoFar),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          icon: Icons.person_add_rounded,
                          iconBg: SakhiColors.primary50,
                          value: MockData.clientsAdded,
                          label: _s.statClientsAdded,
                          index: 0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatTile(
                          icon: Icons.notifications_active_rounded,
                          iconBg: SakhiColors.amber50,
                          value: MockData.remindersSent,
                          label: _s.statRemindersSent,
                          index: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatTile(
                          icon: Icons.verified_rounded,
                          iconBg: SakhiColors.successBg,
                          value: MockData.kycCompleted,
                          label: _s.statKycCompleted,
                          index: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Attention section ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SakhiSectionHeader(
                    title: _s.sectionAttention,
                    action: _s.seeAll,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < MockData.attentionClients.length;
                          i++) ...[
                        AttentionRow(
                          client: MockData.attentionClients[i],
                          strings: _s,
                          index: i,
                          onAction: () => HapticFeedback.mediumImpact(),
                        ),
                        if (i < MockData.attentionClients.length - 1)
                          const SizedBox(height: 8),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Recent activity ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SakhiSectionHeader(
                    title: _s.sectionRecent,
                    action: _s.seeAll,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: SakhiElevation.cardDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        for (int i = 0;
                            i < MockData.recentActivity.length;
                            i++)
                          ActivityRow(
                            activity: MockData.recentActivity[i],
                            locale: widget.locale,
                            index: i,
                            showDivider:
                                i < MockData.recentActivity.length - 1,
                          ),
                      ],
                    ),
                  ),
                ),

                // Bottom padding for FAB
                const SizedBox(height: 96),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return _PressFab(
      onTap: () => MilestoneCelebration.show(
        context,
        message: widget.locale == SakhiLocale.english
            ? 'Adding new client...'
            : 'புதிய வாடிக்கையாளரை சேர்க்கிறோம்...',
      ),
    );
  }
}

class _PressFab extends StatefulWidget {
  const _PressFab({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_PressFab> createState() => _PressFabState();
}

class _PressFabState extends State<_PressFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0,
      upperBound: 1,
    );
    _scale = Tween(begin: 1.0, end: 0.93)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.mediumImpact();
        _ctrl.forward();
      },
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: SakhiColors.brand,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: SakhiColors.brand.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

// ── Loading skeleton ─────────────────────────────────────────────────────────
class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero skeleton
          Container(
            height: 168,
            decoration: BoxDecoration(
              color: SakhiColors.neutral100,
              borderRadius: BorderRadius.circular(SakhiElevation.r20),
            ),
            child: const Center(
              child: ShimmerSkeleton(width: 200, height: 20),
            ),
          ),
          const SizedBox(height: 24),
          const ShimmerSkeleton(width: 160, height: 18),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: SakhiColors.neutral100,
                  borderRadius: BorderRadius.circular(16),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: SakhiColors.neutral100,
                  borderRadius: BorderRadius.circular(16),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: SakhiColors.neutral100,
                  borderRadius: BorderRadius.circular(16),
                ),
              )),
            ],
          ),
          const SizedBox(height: 24),
          const ShimmerSkeleton(width: 180, height: 18),
          const SizedBox(height: 12),
          for (int i = 0; i < 3; i++) ...[
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: SakhiColors.neutral100,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
