import 'package:flutter/material.dart';

/// A column-balanced grid for tiles of differing height.
///
/// A contact sheet mixes portrait and landscape frames, and forcing them into
/// one aspect ratio either crops them or leaves gaps. This lays the tiles out
/// left to right into the currently shortest column, so each frame keeps its
/// own proportions and the columns still end at roughly the same depth.
///
/// The whole list is built at once — a roll holds a few dozen frames, so the
/// bookkeeping a lazy version would need buys nothing here.
class MasonryGrid extends StatelessWidget {
  /// Aspect ratio (width / height) of each tile, in order.
  final List<double> aspectRatios;

  /// Builds the tile at [index]; laid out to the matching aspect ratio.
  final Widget Function(BuildContext context, int index) itemBuilder;

  final int columnCount;
  final double spacing;

  const MasonryGrid({
    super.key,
    required this.aspectRatios,
    required this.itemBuilder,
    required this.columnCount,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    final columns = List.generate(columnCount, (_) => <int>[]);
    // Height of each column in units of column-width, so the packing does not
    // depend on the pixel width we are laid out at.
    final heights = List.filled(columnCount, 0.0);

    for (var i = 0; i < aspectRatios.length; i++) {
      var shortest = 0;
      for (var c = 1; c < columnCount; c++) {
        if (heights[c] < heights[shortest]) shortest = c;
      }
      columns[shortest].add(i);
      heights[shortest] += 1 / aspectRatios[i];
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var c = 0; c < columnCount; c++) ...[
          if (c > 0) SizedBox(width: spacing),
          Expanded(
            child: Column(
              children: [
                for (final index in columns[c]) ...[
                  if (index != columns[c].first) SizedBox(height: spacing),
                  AspectRatio(
                    aspectRatio: aspectRatios[index],
                    child: itemBuilder(context, index),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
