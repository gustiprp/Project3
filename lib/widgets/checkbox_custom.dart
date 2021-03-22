import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxCustom extends StatelessWidget{
  
  final ValueChanged<bool> onChanged;
  final bool value;
  final String label;

  const CheckBoxCustom({Key key, this.onChanged, this.value, this.label}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Checkbox(value: value, onChanged: (bool value) => onChanged(value), key: key, activeColor: Colors.amber,),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }

}