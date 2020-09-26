import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'floating_panel.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestion = context.watch<SuggestionState>();
    final pageController = context.watch<SuggestionController>().pageController;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FloatingPanel(
        child: AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            return _PageIndicatorContent(
              pageCount: suggestion.nthList.length,
              currentPage: pageController.page == null
                  ? pageController.initialPage.toDouble()
                  : pageController.page,
            );
          },
        ),
      ),
    );
  }
}

class _PageIndicatorContent extends StatelessWidget {
  const _PageIndicatorContent({
    Key key,
    @required this.pageCount,
    @required this.currentPage,
  }) : super(key: key);

  final int pageCount;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${currentPage.round() + 1} of $pageCount',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 4.0),
        _ProgressBar(progress: currentPage / (pageCount - 1)),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key key, @required this.progress}) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        width: 100.0,
        height: 8.0,
        color: Colors.grey[200],
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progress,
          heightFactor: 1.0,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}