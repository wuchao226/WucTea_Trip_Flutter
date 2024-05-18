import 'package:flutter/material.dart';

///带禁用功能的按钮
class LoginButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback? onPressed;
  const LoginButton(this.title, {super.key, this.enabled = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      height: 45,
      onPressed: enabled ? onPressed : null,
      disabledColor: Colors.white60,
      color: Colors.orange,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
