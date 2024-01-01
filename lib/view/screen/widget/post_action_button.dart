import 'package:flutter/material.dart';

class PostActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;
  PostActionButton(
      {super.key,
      required this.icon,
      required this.label,
      this.onTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 5),
            Text(label),
          ],
        ),
      ),
    );
  }
}
