import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class AccountDetailInput extends StatefulWidget {
  const AccountDetailInput({
    super.key,
    this.text, required this.controller, this.inputFormatters, this.errorText,
  });

  @override
  State<AccountDetailInput> createState() => _AccountDetailInputState();

  final String? text;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
}

class _AccountDetailInputState extends State<AccountDetailInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          decoration: InputDecoration(labelText: widget.text,errorText: widget.errorText),
        ));
  }
}
