import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_base_validator.dart';
import 'lo_field_state.dart';
import 'lo_form_state.dart';
import 'types.dart';

/// All form fields inside [LoForm] must be wrapped inside this.
class LoField<TKey, TValue> extends StatefulWidget {
  const LoField({
    Key? key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.builder,
  }) : super(key: key);

  /// {@macro LoFieldState.loKey}
  final TKey loKey;

  /// {@macro LoFieldState.initialValue}
  final TValue? initialValue;

  /// {@macro LoFieldState.validators}
  final List<LoFieldBaseValidator<TValue>>? validators;

  /// {@macro LoFieldState.debounceTime}
  final Duration? debounceTime;

  /// Builder for the field widget using [LoFieldState].
  final Widget Function(LoFieldState<TKey, TValue>) builder;

  @override
  _LoFieldState<TKey, TValue> createState() => _LoFieldState<TKey, TValue>();
}

class _LoFieldState<TKey, TValue> extends State<LoField<TKey, TValue>> {
  @override
  void initState() {
    super.initState();
    context.read<LoFormState<TKey>>().registerField<TValue>(
          loKey: widget.loKey,
          initialValue: widget.initialValue,
          validators: widget.validators,
          debounceTime: widget.debounceTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoFormState<TKey>>(
      builder: (_, form, __) {
        return FocusScope(
          child: Focus(
            onFocusChange: (focus) => form.onFieldFocusChanged<TValue>(
              widget.loKey,
              focus,
            ),
            child: widget.builder(
              form.fields.get<TValue>(widget.loKey),
            ),
          ),
        );
      },
    );
  }
}
