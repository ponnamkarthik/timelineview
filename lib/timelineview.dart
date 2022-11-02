library timelineview;

import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

class TimelineView extends StatefulWidget {
  final int activeIndex;
  final List<Widget> labelWidgets;
  final List<Widget>? iconWidgets;
  final Function(int)? onChanged;
  final double lineHeight;
  final double circleRadius;
  final Widget? lineWidget;
  final Widget? unSelectedWidget;
  final Widget? selectedWidget;
  final bool showLabels;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;
  final Color? unFinishedLineColor;
  final Color? finishedLineColor;
  final bool hasFinished;
  
  TimelineView({
    required this.activeIndex,
    required this.labelWidgets,
    this.iconWidgets,
    this.onChanged,
    this.lineHeight = 2.0,
    this.circleRadius = 15.0,
    this.lineWidget,
    this.unSelectedWidget,
    this.selectedWidget,
    this.showLabels = true,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.finishedLineColor,
    this.unFinishedLineColor,
    this.hasFinished = false,
  })  : assert(
            labelWidgets.length > 1, "labelWidgets should be greater than 1");

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.iconWidgets ?? [],
            ),
        Padding(
          padding: EdgeInsets.all(widget.iconWidgets == null ? 0 : 4.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: (widget.circleRadius) - (widget.lineHeight / 2),
                left: (widget.circleRadius),
                right: (widget.circleRadius),
                child: Row(
                  children: <Widget>[
                  for (int i = 0; i < widget.labelWidgets.length - 1; i++)
                    Expanded(
                      child: widget.lineWidget ??
                          Container(
                            height: widget.lineHeight,
                            color: i > widget.activeIndex - 1 ? widget.unFinishedLineColor ?? Colors.red : widget.finishedLineColor ?? Colors.red,
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
                        if (widget.onChanged != null) widget.onChanged!(i);
                      },
                      child: (widget.hasFinished && i <= widget.activeIndex) || i == widget.activeIndex
                          ? Column(
                              crossAxisAlignment: i == widget.labelWidgets.length - 1
                                  ? CrossAxisAlignment.end
                                  : i == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.center,
                              children: <Widget>[
                                widget.selectedWidget ??
                                    Container(
                                      height: widget.circleRadius * 2,
                                      width: widget.circleRadius * 2,
                                      child: Animator(
                                          key: ValueKey(i),
                                          cycles: 1,
                                          duration: Duration(milliseconds: 500),
                                          tween: Tween<double>(
                                              begin: 0, end: widget.circleRadius * 2),
                                          builder: (context, anim, child) =>
                                              Container(
                                                width: anim.value as double,
                                                height: anim.value as double,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.red,
                                                    width: (anim.value as double) / 4,
                                                  ),
                                                ),
                                              )),
                                    ),
                                SizedBox(
                                  height: 2.0,
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
                              crossAxisAlignment: i == widget.labelWidgets.length - 1
                                  ? CrossAxisAlignment.end
                                  : i == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.center,
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
                                SizedBox(
                                  height: 2.0,
                                ),
                                if (widget.showLabels)
                                  DefaultTextStyle(
                                    style: widget.unSelectedTextStyle ??
                                        Theme.of(context).textTheme.bodyText2!,
                                    child: widget.labelWidgets[i],
                                  )
                              ],
                            ),
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DotPainter extends CustomPainter {
  late Paint _paint;

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
