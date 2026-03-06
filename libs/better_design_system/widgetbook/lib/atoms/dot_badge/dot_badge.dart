import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Dot Mode', type: BetterDotBadge)
Widget dotModeBetterDotBadge(BuildContext context) {
  final color = context.knobs.object.dropdown(
    label: 'Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.info,
    labelBuilder: (value) => value.name,
  );
  final isAnimating = context.knobs.boolean(
    label: 'Animating',
    initialValue: false,
  );

  return Wrap(
    spacing: 16,
    runSpacing: 16,
    alignment: WrapAlignment.center,
    children:
        DotBadgeSize.values.map((size) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BetterDotBadge(
                color: color,
                dotBadgeSize: size,
                isAnimating: isAnimating,
              ),
              const SizedBox(height: 4),
              Text(size.name, style: Theme.of(context).textTheme.labelSmall),
            ],
          );
        }).toList(),
  );
}

@UseCase(name: 'Counter Mode', type: BetterDotBadge)
Widget counterModeBetterDotBadge(BuildContext context) {
  final color = context.knobs.object.dropdown(
    label: 'Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.error,
    labelBuilder: (value) => value.name,
  );
  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: DotBadgeSize.values,
    initialOption: DotBadgeSize.medium,
    labelBuilder: (value) => value.name,
  );
  final isAnimating = context.knobs.boolean(
    label: 'Animating',
    initialValue: false,
  );

  return Wrap(
    spacing: 24,
    runSpacing: 16,
    alignment: WrapAlignment.center,
    children: [
      _CounterExample(
        count: 1,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
      _CounterExample(
        count: 5,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
      _CounterExample(
        count: 9,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
      _CounterExample(
        count: 99,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
      _CounterExample(
        count: 100,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
      _CounterExample(
        count: 999,
        size: size,
        color: color,
        isAnimating: isAnimating,
      ),
    ],
  );
}

class _CounterExample extends StatelessWidget {
  const _CounterExample({
    required this.count,
    required this.size,
    required this.color,
    required this.isAnimating,
  });

  final int count;
  final DotBadgeSize size;
  final SemanticColor color;
  final bool isAnimating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BetterDotBadge.counter(
          count: count,
          dotBadgeSize: size,
          color: color,
          isAnimating: isAnimating,
        ),
        const SizedBox(height: 4),
        Text('count: $count', style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

@UseCase(name: 'Wrapper Example', type: BetterDotBadgeWrapper)
Widget wrapperExampleBetterDotBadge(BuildContext context) {
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 0,
    max: 150,
  );
  final color = context.knobs.object.dropdown(
    label: 'Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.error,
    labelBuilder: (value) => value.name,
  );
  final isAnimating = context.knobs.boolean(
    label: 'Animating',
    initialValue: false,
  );
  final showAsDot = context.knobs.boolean(
    label: 'Show as Dot',
    initialValue: false,
  );

  final options =
      showAsDot
          ? DotBadgeOptions.dot(color: color, isAnimating: isAnimating)
          : DotBadgeOptions.counter(
            count: count,
            color: color,
            isAnimating: isAnimating,
          );

  return Wrap(
    spacing: 32,
    runSpacing: 32,
    alignment: WrapAlignment.center,
    children: [
      // Icon example
      BetterDotBadgeWrapper(
        options: options,
        child: Icon(
          BetterIcons.notification02Outline,
          size: 32,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      // Avatar example
      BetterDotBadgeWrapper(
        options: options,
        child: CircleAvatar(radius: 24, child: Icon(BetterIcons.userOutline)),
      ),
      // Container example
      BetterDotBadgeWrapper(
        options: options,
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Text('Inbox')),
        ),
      ),
    ],
  );
}

@UseCase(name: 'All Colors', type: BetterDotBadge)
Widget allColorsBetterDotBadge(BuildContext context) {
  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: DotBadgeSize.values,
    initialOption: DotBadgeSize.medium,
    labelBuilder: (value) => value.name,
  );
  final showCounter = context.knobs.boolean(
    label: 'Show Counter',
    initialValue: false,
  );
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 1,
    max: 150,
  );

  return Wrap(
    spacing: 16,
    runSpacing: 16,
    alignment: WrapAlignment.center,
    children:
        SemanticColor.values.map((color) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCounter)
                BetterDotBadge.counter(
                  count: count,
                  color: color,
                  dotBadgeSize: size,
                )
              else
                BetterDotBadge(color: color, dotBadgeSize: size),
              const SizedBox(height: 4),
              Text(color.name, style: Theme.of(context).textTheme.labelSmall),
            ],
          );
        }).toList(),
  );
}
