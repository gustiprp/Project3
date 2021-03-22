import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioCustom<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final Widget label;

  const RadioCustom(
      {Key key,
      this.value,
      this.groupValue,
      this.onChanged,
      this.activeColor,
      this.materialTapTargetSize,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
        key: key,
        value: value,
        groupValue: groupValue,
        onChanged: (value) => onChanged(value),
        activeColor: activeColor,
        materialTapTargetSize: materialTapTargetSize,
        ),
        label,
      ],
    );
  }
}
