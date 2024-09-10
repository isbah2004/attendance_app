import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphicTextField extends StatefulWidget {
  final String title;
  final Widget? prefix, suffix;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final Null Function(dynamic value)? onChanged;
  final List<TextInputFormatter>? inputFormatter;

  const NeumorphicTextField({
    super.key,
    this.prefix,
    this.suffix,
    required this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    required this.keyboardType,
    this.obscureText,
    this.maxLines = 1,
    this.onChanged,
    required this.title,
    this.inputFormatter,
  });

  @override
   State<NeumorphicTextField> createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                inset: !_isFocused, // Set inset based on focus state
                blurRadius: 3,
                offset: const Offset(5, 5),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              ),
              BoxShadow(
                inset: !_isFocused, // Set inset based on focus state
                blurRadius: 3,
                offset: const Offset(-5, -5),
                color: Colors.white38,
              ),
            ],
          ),
          duration: const Duration(milliseconds: 300),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatter,
            obscureText: widget.obscureText ?? false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 11),
              border: InputBorder.none,
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
            ),
          ),
        ),
      ],
    );
  }
}