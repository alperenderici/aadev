import 'package:flutter/material.dart';
import 'package:aad/features/film/models/film_roll.dart';
import 'package:aad/features/film/widgets/film_image.dart';
import 'package:aad/features/film/widgets/film_lightbox.dart';
import 'package:aad/features/film/widgets/film_theme.dart';
import 'package:aad/features/film/widgets/masonry_grid.dart';

/// `/35mm/<id>` — one roll as a contact sheet, with whatever is catalogued
/// about it above the frames.
class FilmRollPage extends StatelessWidget {
  final FilmRoll roll;

  const FilmRollPage({super.key, required this.roll});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600
        ? 2
        : width < 1000
        ? 3
        : width < 1440
        ? 4
        : 5;
    final horizontalPadding = width < 600 ? 16.0 : 40.0;

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
                  32,
                ),
                sliver: SliverToBoxAdapter(child: _RollHeader(roll: roll)),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  80,
                ),
                sliver: SliverToBoxAdapter(
                  child: MasonryGrid(
                    columnCount: columns,
                    spacing: width < 600 ? 8 : 12,
                    aspectRatios: List.generate(
                      roll.frameCount,
                      roll.aspectRatio,
                    ),
                    itemBuilder: (context, index) => _FrameTile(
                      roll: roll,
                      index: index,
                      onTap: () => FilmLightbox.show(
                        context,
                        roll: roll,
                        initialIndex: index,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RollHeader extends StatelessWidget {
  final FilmRoll roll;

  const _RollHeader({required this.roll});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 600;

    final entries = <({String label, String value})>[
      if (roll.filmStock != null) (label: 'FİLM', value: roll.filmStock!),
      if (roll.camera != null) (label: 'MAKİNE', value: roll.camera!),
      if (roll.shotOn != null) (label: 'ÇEKİM', value: roll.shotOn!),
      if (roll.developedAt != null) (label: 'YIKAMA', value: roll.developedAt!),
      if (roll.developedOn != null)
        (label: 'YIKAMA TARİHİ', value: roll.developedOn!),
      if (roll.scannedAt != null) (label: 'TARAMA', value: roll.scannedAt!),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).canPop()
              ? Navigator.of(context).pop()
              : Navigator.of(context).pushReplacementNamed('/35mm'),
          borderRadius: BorderRadius.circular(4),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text('← tüm rulolar', style: FilmTheme.label),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          roll.title,
          style: TextStyle(
            fontSize: isNarrow ? 28 : 38,
            height: 1.15,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: FilmTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 18),

        if (entries.isNotEmpty)
          Wrap(
            spacing: 36,
            runSpacing: 18,
            children: [
              for (final entry in entries)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(entry.label, style: FilmTheme.label),
                    const SizedBox(height: 3),
                    Text(entry.value, style: FilmTheme.value),
                  ],
                ),
            ],
          )
        else
          Text(
            'Bu rulonun künyesi henüz girilmedi.',
            style: FilmTheme.value.copyWith(color: FilmTheme.textFaint),
          ),

        if (roll.notes != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: 640,
            child: Text(
              roll.notes!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: FilmTheme.textSecondary,
              ),
            ),
          ),
        ],

        const SizedBox(height: 26),
        Text(
          '${roll.frameCount} KARE',
          style: FilmTheme.label.copyWith(color: FilmTheme.accent),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: FilmTheme.border),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _FrameTile extends StatefulWidget {
  final FilmRoll roll;
  final int index;
  final VoidCallback onTap;

  const _FrameTile({
    required this.roll,
    required this.index,
    required this.onTap,
  });

  @override
  State<_FrameTile> createState() => _FrameTileState();
}

class _FrameTileState extends State<_FrameTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovered ? FilmTheme.accent : Colors.transparent,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FilmImage(url: widget.roll.thumbUrl(widget.index)),
              // Frame number, revealed on hover like a strip edge marking.
              AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                opacity: _hovered ? 1 : 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    color: Colors.black.withValues(alpha: 0.65),
                    child: Text(
                      (widget.index + 1).toString().padLeft(2, '0'),
                      style: FilmTheme.label.copyWith(
                        color: FilmTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
