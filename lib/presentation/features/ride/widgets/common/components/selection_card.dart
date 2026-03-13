import 'package:flutter/material.dart';
import 'package:mobile_library/mobile_library.dart';

/// Selection state
enum SelectionState {
  /// default
  idle,

  /// not selected
  notSelected,

  /// selected
  selected,
}

/// Selection card
class SelectionCard extends StatelessWidget {
  /// constructor
  const SelectionCard({
    required this.child,
    required this.backgroundColor,
    required this.selection,
    required this.onSelection,
    this.padding,
    super.key,
  });

  /// Card child
  final Widget child;

  /// Card background color
  final Color backgroundColor;

  /// Selection state
  final SelectionState selection;

  /// On selection
  final ValueChanged<SelectionState> onSelection;

  /// Padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          final widget = Container(
            padding: padding ?? EdgeInsets.all(40.sp),
            decoration: BoxDecoration(color: backgroundColor),
            child: child,
          );

          return InkWell(
            onTap: () => onSelection(
              selection == SelectionState.idle
                  ? SelectionState.selected
                  : SelectionState.notSelected,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50.r)),
              child: selection == SelectionState.selected
                  ? widget
                  : ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        selection == SelectionState.notSelected
                            ? Colors.grey
                            : Colors.grey.withValues(alpha: .6),
                        BlendMode.color,
                      ),
                      child: widget,
                    ),
            ),
          );
        },
      ),
    );
  }
}
