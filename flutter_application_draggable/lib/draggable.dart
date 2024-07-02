import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<Color>(
      data: Colors.blue,
      feedback: Container(
        width: 50,
        height: 50,
        color: Colors.blue.withOpacity(0.5),
        child: const Center(child: Text('Dragging')),
      ),
      childWhenDragging: Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: const Center(child: Text('Original position')),
      ),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: const Center(child: Text('Drag me')),
      ),
    );
  }
}
