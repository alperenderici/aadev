import 'package:flutter/material.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/features/film/data/film_rolls_data.dart';
import 'package:aad/features/film/models/film_roll.dart';
import 'package:aad/features/film/widgets/film_image.dart';
import 'package:aad/features/film/widgets/film_theme.dart';

/// `/35mm` — the index of the film archive, one cover per roll.
///
/// Unlisted by design: nothing on the site links here and `robots.txt` keeps it
/// out of search results, so the page is reachable only by typing the address.
class FilmGalleryPage extends StatefulWidget {
  const FilmGalleryPage({super.key});

  @override
  State<FilmGalleryPage> createState() => _FilmGalleryPageState();
}

class _FilmGalleryPageState extends State<FilmGalleryPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logPageView('35mm_gallery');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600
        ? 1
        : width < 1000
        ? 2
        : width < 1440
        ? 3
        : 4;
    final horizontalPadding = width < 600 ? 20.0 : 40.0;

    return Scaffold(
      backgroundColor: FilmTheme.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  56,
                  horizontalPadding,
                  40,
                ),
                sliver: const SliverToBoxAdapter(child: _Header()),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  80,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 3 / 4,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final roll = FilmRollsData.rolls[index];
                    return _RollCard(
                      roll: roll,
                      onTap: () {
                        AnalyticsService.logPageView('35mm_roll_${roll.id}');
                        Navigator.of(context).pushNamed('/35mm/${roll.id}');
                      },
                    );
                  }, childCount: FilmRollsData.rolls.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final rollCount = FilmRollsData.rolls.length;
    final frameCount = FilmRollsData.totalFrames;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/'),
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text('← alialperenderici.dev', style: FilmTheme.label),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          '35mm',
          style: TextStyle(
            fontFamily: FilmTheme.monoFamily,
            fontSize: 56,
            height: 1.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
            color: FilmTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        const SizedBox(
          width: 560,
          child: Text(
            'Filmli makineyle çektiğim kareler. Her rulo çekildiği film, '
            'kullanılan makine ve yıkandığı yerle birlikte duruyor.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: FilmTheme.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '$rollCount RULO · $frameCount KARE',
          style: FilmTheme.label.copyWith(color: FilmTheme.accent),
        ),
        const SizedBox(height: 28),
        const Divider(height: 1, color: FilmTheme.border),
      ],
    );
  }
}

class _RollCard extends StatefulWidget {
  final FilmRoll roll;
  final VoidCallback onTap;

  const _RollCard({required this.roll, required this.onTap});

  @override
  State<_RollCard> createState() => _RollCardState();
}

class _RollCardState extends State<_RollCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final roll = widget.roll;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: FilmTheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _hovered ? FilmTheme.accent : FilmTheme.border,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOut,
                      scale: _hovered ? 1.04 : 1.0,
                      child: FilmImage(url: roll.coverUrl),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${roll.frameCount}',
                          style: FilmTheme.label.copyWith(
                            color: FilmTheme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roll.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: FilmTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _subtitle(roll),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FilmTheme.label,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Whatever is known about the roll, in one line: stock, camera, date.
  String _subtitle(FilmRoll roll) {
    final parts = [
      roll.filmStock,
      roll.camera,
      roll.shotOn,
    ].whereType<String>().toList();
    return parts.isEmpty ? '—' : parts.join(' · ').toUpperCase();
  }
}
