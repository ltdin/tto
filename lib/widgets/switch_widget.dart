import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    @required this.switchControl,
    @required this.onValueChanged,
    this.colorSwitch = PRIMARY_COLOR,
  });
  final bool switchControl;
  final Color colorSwitch;
  final ValueChanged<bool> onValueChanged;

  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State<SwitchWidget> {
  bool switchControl;

  @override
  void initState() {
    switchControl = widget.switchControl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: toggleSwitch,
      value: switchControl,
      activeColor: widget.colorSwitch,
      activeTrackColor: widget.colorSwitch.withOpacity(0.38),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.withOpacity(0.38),
    );
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
      });
    } else {
      setState(() {
        switchControl = false;
      });
    }
    widget.onValueChanged.call(switchControl);
  }
}
