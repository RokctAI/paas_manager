// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatisticsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isRefresh =>
      throw _privateConstructorUsedError; // @Default([]) List<Series<OrdinalSales, String>> list,
  List<StatisticsOrder> get listOfOrder => throw _privateConstructorUsedError;
  List<num> get prices => throw _privateConstructorUsedError;
  List<DateTime> get time => throw _privateConstructorUsedError;
  StatisticsModel? get countData => throw _privateConstructorUsedError;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticsStateCopyWith<StatisticsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsStateCopyWith<$Res> {
  factory $StatisticsStateCopyWith(
          StatisticsState value, $Res Function(StatisticsState) then) =
      _$StatisticsStateCopyWithImpl<$Res, StatisticsState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isRefresh,
      List<StatisticsOrder> listOfOrder,
      List<num> prices,
      List<DateTime> time,
      StatisticsModel? countData});
}

/// @nodoc
class _$StatisticsStateCopyWithImpl<$Res, $Val extends StatisticsState>
    implements $StatisticsStateCopyWith<$Res> {
  _$StatisticsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isRefresh = null,
    Object? listOfOrder = null,
    Object? prices = null,
    Object? time = null,
    Object? countData = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefresh: null == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      listOfOrder: null == listOfOrder
          ? _value.listOfOrder
          : listOfOrder // ignore: cast_nullable_to_non_nullable
              as List<StatisticsOrder>,
      prices: null == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<num>,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      countData: freezed == countData
          ? _value.countData
          : countData // ignore: cast_nullable_to_non_nullable
              as StatisticsModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatisticsStateImplCopyWith<$Res>
    implements $StatisticsStateCopyWith<$Res> {
  factory _$$StatisticsStateImplCopyWith(_$StatisticsStateImpl value,
          $Res Function(_$StatisticsStateImpl) then) =
      __$$StatisticsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isRefresh,
      List<StatisticsOrder> listOfOrder,
      List<num> prices,
      List<DateTime> time,
      StatisticsModel? countData});
}

/// @nodoc
class __$$StatisticsStateImplCopyWithImpl<$Res>
    extends _$StatisticsStateCopyWithImpl<$Res, _$StatisticsStateImpl>
    implements _$$StatisticsStateImplCopyWith<$Res> {
  __$$StatisticsStateImplCopyWithImpl(
      _$StatisticsStateImpl _value, $Res Function(_$StatisticsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isRefresh = null,
    Object? listOfOrder = null,
    Object? prices = null,
    Object? time = null,
    Object? countData = freezed,
  }) {
    return _then(_$StatisticsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefresh: null == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      listOfOrder: null == listOfOrder
          ? _value._listOfOrder
          : listOfOrder // ignore: cast_nullable_to_non_nullable
              as List<StatisticsOrder>,
      prices: null == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<num>,
      time: null == time
          ? _value._time
          : time // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      countData: freezed == countData
          ? _value.countData
          : countData // ignore: cast_nullable_to_non_nullable
              as StatisticsModel?,
    ));
  }
}

/// @nodoc

class _$StatisticsStateImpl extends _StatisticsState {
  const _$StatisticsStateImpl(
      {this.isLoading = false,
      this.isRefresh = true,
      final List<StatisticsOrder> listOfOrder = const [],
      final List<num> prices = const [],
      final List<DateTime> time = const [],
      this.countData})
      : _listOfOrder = listOfOrder,
        _prices = prices,
        _time = time,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isRefresh;
// @Default([]) List<Series<OrdinalSales, String>> list,
  final List<StatisticsOrder> _listOfOrder;
// @Default([]) List<Series<OrdinalSales, String>> list,
  @override
  @JsonKey()
  List<StatisticsOrder> get listOfOrder {
    if (_listOfOrder is EqualUnmodifiableListView) return _listOfOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOfOrder);
  }

  final List<num> _prices;
  @override
  @JsonKey()
  List<num> get prices {
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prices);
  }

  final List<DateTime> _time;
  @override
  @JsonKey()
  List<DateTime> get time {
    if (_time is EqualUnmodifiableListView) return _time;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_time);
  }

  @override
  final StatisticsModel? countData;

  @override
  String toString() {
    return 'StatisticsState(isLoading: $isLoading, isRefresh: $isRefresh, listOfOrder: $listOfOrder, prices: $prices, time: $time, countData: $countData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            const DeepCollectionEquality()
                .equals(other._listOfOrder, _listOfOrder) &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            const DeepCollectionEquality().equals(other._time, _time) &&
            (identical(other.countData, countData) ||
                other.countData == countData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isRefresh,
      const DeepCollectionEquality().hash(_listOfOrder),
      const DeepCollectionEquality().hash(_prices),
      const DeepCollectionEquality().hash(_time),
      countData);

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticsStateImplCopyWith<_$StatisticsStateImpl> get copyWith =>
      __$$StatisticsStateImplCopyWithImpl<_$StatisticsStateImpl>(
          this, _$identity);
}

abstract class _StatisticsState extends StatisticsState {
  const factory _StatisticsState(
      {final bool isLoading,
      final bool isRefresh,
      final List<StatisticsOrder> listOfOrder,
      final List<num> prices,
      final List<DateTime> time,
      final StatisticsModel? countData}) = _$StatisticsStateImpl;
  const _StatisticsState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isRefresh; // @Default([]) List<Series<OrdinalSales, String>> list,
  @override
  List<StatisticsOrder> get listOfOrder;
  @override
  List<num> get prices;
  @override
  List<DateTime> get time;
  @override
  StatisticsModel? get countData;

  /// Create a copy of StatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticsStateImplCopyWith<_$StatisticsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
