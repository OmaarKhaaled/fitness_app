import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.isChecked,
    required this.onChecked,
  });
  final bool isChecked;
  final ValueChanged<bool> onChecked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(milliseconds: 100),
        decoration: ShapeDecoration(
          color: isChecked
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color: isChecked ? Colors.transparent : const Color(0xFFDCDEDE),
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: isChecked
            ? const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(Icons.check, color: Colors.white),
              )
            : const SizedBox(),
      ),
    );
  }
}
