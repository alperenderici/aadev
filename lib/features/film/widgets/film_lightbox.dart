import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aad/features/film/models/film_roll.dart';
import 'package:aad/features/film/widgets/film_image.dart';
import 'package:aad/features/film/widgets/film_theme.dart';

/// Full-screen frame viewer for a roll, opened from the contact sheet.
///
/// Swipe or use the arrow keys to move through the roll; Escape closes it.
/// Frames load at their full 1800px size here, one page at a time, so opening
/// the viewer never pulls the whole roll down.
class FilmLightbox extends StatefulWidget {
  final FilmRoll roll;
  final int initialIndex;

  const FilmLightbox({
    super.key,
    required this.roll,
    required this.initialIndex,
  });

  /// Opens the viewer for [roll] starting at [initialIndex].
  static Future<void> show(
    BuildContext context, {
    required FilmRoll roll,
    required int initialIndex,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black,
        transitionDuration: const Duration(milliseconds: 180),
        pageBuilder: (_, _, _) =>
            FilmLightbox(roll: roll, initialIndex: initialIndex),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  State<FilmLightbox> createState() => _FilmLightboxState();
}

class _FilmLightboxState extends State<FilmLightbox> {
  late final PageController _controller;
  late final FocusNode _focusNode;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _step(int delta) {
    final next = _index + delta;
    if (next < 0 || next >= widget.roll.frameCount) return;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.arrowDown:
      case LogicalKeyboardKey.space:
        _step(1);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.arrowUp:
        _step(-1);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.escape:
        Navigator.of(context).maybePop();
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final roll = widget.roll;
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: roll.frameCount,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  maxScale: 4,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      isNarrow ? 8 : 64,
                      isNarrow ? 64 : 72,
                      isNarrow ? 8 : 64,
                      isNarrow ? 72 : 64,
                    ),
                    child: FilmImage(
                      url: roll.fullUrl(index),
                      fit: BoxFit.contain,
                      placeholderColor: Colors.black,
                    ),
                  ),
                );
              },
            ),

            // Close button
            Positioned(
              top: 12,
              right: 12,
              child: _RoundButton(
                icon: Icons.close,
                tooltip: 'Kapat (Esc)',
                onTap: () => Navigator.of(context).maybePop(),
              ),
            ),

            // Roll name, top left
            Positioned(
              top: 22,
              left: 20,
              right: 72,
              child: Text(
                roll.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FilmTheme.counter.copyWith(
                  color: FilmTheme.textSecondary,
                ),
              ),
            ),

            // Previous / next, desktop only — touch users swipe.
            if (!isNarrow) ...[
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _RoundButton(
                    icon: Icons.chevron_left,
                    tooltip: 'Önceki (←)',
                    onTap: _index > 0 ? () => _step(-1) : null,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _RoundButton(
                    icon: Icons.chevron_right,
                    tooltip: 'Sonraki (→)',
                    onTap: _index < roll.frameCount - 1 ? () => _step(1) : null,
                  ),
                ),
              ),
            ],

            // Frame counter
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${(_index + 1).toString().padLeft(2, '0')} / '
                    '${roll.frameCount.toString().padLeft(2, '0')}',
                    style: FilmTheme.counter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  const _RoundButton({required this.icon, required this.tooltip, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.white.withValues(alpha: onTap == null ? 0.03 : 0.08),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              icon,
              size: 22,
              color: onTap == null
                  ? FilmTheme.textFaint
                  : FilmTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
