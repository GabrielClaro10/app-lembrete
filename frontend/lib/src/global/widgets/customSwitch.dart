import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isSwitchOn;

  @override
  void initState() {
    super.initState();
    _isSwitchOn = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 16),
        ),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Switch(
          activeColor: const Color(0xFF34495E),
          value: _isSwitchOn,
          onChanged: (bool value) {
            setState(() {
              _isSwitchOn = value;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
