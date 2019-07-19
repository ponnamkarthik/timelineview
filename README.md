# TimelineView

# How to use

```dart
TimelineView(
    activeIndex: activeIndex, // active index default (0)
    showLabels: false, // weather to show lables at bottom or not default (true)
    circleRadius: 15.0, // radius of the circle ignored if selected and unSelectedWidgets are provided
    lineHeight: 2.0, // Height of line will be ignored if lineWidget is provided
    lineWidget: _lineWidget, // Widget will be placed in the line
    selectedTextStyle: , // selected item label style
    selectedWidget: , // selected widget
    unSelectedTextStyle: , // unselected item label style
    unSelectedWidget: , // unselected widget
    onChanged: (index) {
        setState(() {
            activeIndex = index;
        });
    }, // onSelection changed trigger
    labelWidgets: <Widget>[
        Text("One"),
        Text("TwoThree"),
        Text("Four"),
    ], // list of items
),
```
