import 'package:flutter/material.dart';

class WeekSlider extends StatefulWidget {
  const WeekSlider(this.type, this.value, this.onChanged, {Key? key})
      : super(key: key);
  final int type;
  final int value;
  final Function(int) onChanged;

  @override
  State<WeekSlider> createState() => _WeekSliderState();
}

class _WeekSliderState extends State<WeekSlider> {
  Color activeTrackColor = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.type == 0) {
      activeTrackColor = const Color(0xffff0000);
    } else if (widget.type == 1) {
      activeTrackColor = const Color(0xff00ff45);
    } else if (widget.type == 2) {
      activeTrackColor = const Color(0xff1d00ff);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: const Color(0xff2e343b),
          thumbColor: activeTrackColor,
          overlayColor: const Color(0xff3e3e3e),
          valueIndicatorColor: activeTrackColor,
          trackHeight: 6,
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: Slider(
          value: widget.value.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: (v) {
            widget.onChanged(v.toInt());
          },
        ),
      ),
    );
  }
}
