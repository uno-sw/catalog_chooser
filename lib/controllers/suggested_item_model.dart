import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggested_item_model.freezed.dart';

@freezed
abstract class SuggestedItemModel with _$SuggestedItemModel {
  const factory SuggestedItemModel({
    @required SuggestedItemPosition nth,
    @required SuggestedItemPosition nthFromEnd,
    SuggestedItemStep steps,
    SuggestedItemStep stepsOverEdge,
  }) = _SuggestedItemModel;
}

@freezed
abstract class SuggestedItemPosition implements _$SuggestedItemPosition {
  SuggestedItemPosition._();
  factory SuggestedItemPosition(int value) = _SuggestedItemPosition;

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
        '${value <= 1 ? 'step' : 'steps'} '
        '${forward ? 'forward' : 'backward'}'
      );

  @override
  String toString() => '$value $suffixLabel';
}
