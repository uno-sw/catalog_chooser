import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggested_item_model.freezed.dart';

@freezed
abstract class SuggestedItemModel implements _$SuggestedItemModel {
  SuggestedItemModel._();
  factory SuggestedItemModel({
    @required SuggestedItemPosition nth,
    @required SuggestedItemPosition nthFromEnd,
    SuggestedItemStep step,
    SuggestedItemStep stepOverEdge,
  }) = _SuggestedItemModel;

  int get nthRank => valueRanking.indexOf(nth.value);
  int get nthFromEndRank => valueRanking.indexOf(nthFromEnd.value);
  int get stepRank => valueRanking.indexOf(step.value);
  int get stepOverEdgeRank => valueRanking.indexOf(stepOverEdge.value);

  @late
  List<int> get valueRanking =>
      [nth.value, nthFromEnd.value, step?.value, stepOverEdge?.value]
          .fold<List<int>>([], (prev, value) {
            if (value == null || prev.contains(value)) return prev;
            else return prev..add(value);
          })
          ..sort((a, b) => a.compareTo(b));
}

@freezed
abstract class SuggestedItemPosition implements _$SuggestedItemPosition {
  const SuggestedItemPosition._();
  const factory SuggestedItemPosition(int value) = _SuggestedItemPosition;

  String get suffixLabel {
    if (value >= 4 && value <= 19) return 'th';

    switch (value - (value * 0.1).floor() * 10) {
      case 1:  return 'st';
      case 2:  return 'nd';
      case 3:  return 'rd';
      default: return 'th';
    }
  }

  @override
  String toString() => '$value$suffixLabel';
}

@freezed
abstract class SuggestedItemStep implements _$SuggestedItemStep {
  SuggestedItemStep._();
  factory SuggestedItemStep(
    int value, {
    @required bool forward,
  }) = _SuggestedItemStep;

  factory SuggestedItemStep.forward(int value) {
    return SuggestedItemStep(value, forward: true);
  }

  factory SuggestedItemStep.backward(int value) {
    return SuggestedItemStep(value, forward: false);
  }

  @late
  String get suffixLabel => (
        '${value <= 1 ? ' step' : ' steps'} '
        '${forward ? 'forward' : 'backward'}'
      );

  @override
  String toString() => '$value$suffixLabel';
}