import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bootstrap/helpers.dart';

class InputField extends StatefulWidget {
  InputField({
    Key? key,
    required this.hint,
    this.isSecret = false,
    required this.label,
    required this.onChanged,
    required this.textInputType,
  }) : super(key: key);

  final String label;
  final String hint;
  bool isSecret;
  final TextInputType textInputType;
  final Function(String) onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.label,
              style: TextStyle(
                color: Color(0xFFA5A7AB),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextFormField(
            onChanged: widget.onChanged,
            obscureText: widget.isSecret,
            keyboardType: widget.textInputType,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.textInputType == TextInputType.visiblePassword
                  ? IconButton(
                      splashRadius: 1,
                      icon: FaIcon(
                        widget.isSecret
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.isSecret = !widget.isSecret;
                        });
                      },
                    )
                  : null,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              hintText: widget.hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xFFF3F4F6),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xFFF3F4F6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
