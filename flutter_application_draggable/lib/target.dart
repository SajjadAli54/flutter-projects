import 'package:flutter/material.dart';

class DragTargetWidget extends StatefulWidget {
  const DragTargetWidget({super.key});

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  Color _color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Color>(
      onAccept: (color) {
        setState(() {
          _color = color;
        });
      },
      builder: (BuildContext context, List<dynamic> accepted,
          List<dynamic> rejected) {
        return Container(
          width: 200,
          height: 200,
          color: _color,
          child: const Center(child: Text('Drop here')),
        );
      },
    );
  }
}
