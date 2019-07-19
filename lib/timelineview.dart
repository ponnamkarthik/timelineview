library timelineview;

import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class TimelineView extends StatefulWidget {
  final int activeIndex;
  final List<Widget> labelWidgets;
  final Function(int) onChanged;
  final double lineHeight;
  final double circleRadius;
  final Widget lineWidget;
  final Widget unSelectedWidget;
  final Widget selectedWidget;
  final bool showLabels;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

  TimelineView({
    @required this.activeIndex,
    @required this.labelWidgets,
    this.onChanged,
    this.lineHeight = 2.0,
    this.circleRadius = 15.0,
    this.lineWidget,
    this.unSelectedWidget,
    this.selectedWidget,
    this.showLabels = true,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
  })  : assert(
            labelWidgets.length > 1, "labelWidgets should be greater than 1"),
        assert(activeIndex >= 0 && activeIndex < labelWidgets.length,
            "Active Index should be between 0 to Length of lableWidgets");

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: (widget.circleRadius) - (widget.lineHeight / 2),
          left: (widget.circleRadius),
          right: (widget.circleRadius),
          child: Row(
            children: <Widget>[
              Expanded(
                child: widget.lineWidget ??
                    Container(
//                  padding: EdgeInsets.all(widget.circleRadius*2),
                      height: widget.lineHeight,
                      color: Colors.red,
                    ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 0; i < widget.labelWidgets.length; i++)
              GestureDetector(
                onTap: () {
                  if (widget.onChanged != null) widget.onChanged(i);
                },
                child: i == widget.activeIndex
                    ? Column(
                        children: <Widget>[
                          widget.selectedWidget ??
                              Container(
                                height: widget.circleRadius *2,
                                width: widget.circleRadius *2,
                                child: Center(
                                  child: Animator(
                                    key: ValueKey(i),
                                      cycles: 1,
                                      duration: Duration(seconds: 2),
                                      tween: Tween<double>(
                                          begin: 0,
                                          end: widget.circleRadius * 2),
                                      builder: (anim) => Container(
                                            width: anim.value,
                                            height: anim.value,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.red,
                                                width: anim.value / 4,
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                          if (widget.showLabels)
                            DefaultTextStyle(
                              style: widget.selectedTextStyle ??
                                  TextStyle(
                                    color: Colors.red,
                                  ),
                              child: widget.labelWidgets[i],
                            )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          widget.unSelectedWidget ??
                              Container(
                                width: widget.circleRadius * 2,
                                height: widget.circleRadius * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                          if (widget.showLabels)
                            DefaultTextStyle(
                              style: widget.unSelectedTextStyle ??
                                  Theme.of(context).textTheme.body1,
                              child: widget.labelWidgets[i],
                            )
                        ],
                      ),
              )
          ],
        ),
      ],
    );
  }
}

class DotPainter extends CustomPainter {
  Paint _paint;

  DotPainter() {
    // get color and radius dynamically
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(20.0, 20.0), 20.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
