import 'package:flutter/material.dart';

class CustomCheck extends StatefulWidget {
  bool value;
  final ValueChanged<bool>?
      onChanged; // Callback function to return checkbox state

  CustomCheck({super.key, this.onChanged, required this.value});

  @override
  State<CustomCheck> createState() => _CustomCheckState();
}

class _CustomCheckState extends State<CustomCheck> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.value = !widget.value;
          });
          // Invoke the onChanged callback with the current value of isChecked
          if (widget.onChanged != null) {
            widget.onChanged!(widget.value);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            shape: BoxShape.circle,
            color: widget.value
                ? Theme.of(context).shadowColor
                : Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Icon(
              Icons.done,
              color: widget.value
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).dividerColor,
            ),
          ),
        ),
      ),
    );
  }
}
