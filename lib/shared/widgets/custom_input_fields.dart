// import 'package:flutter/material.dart';

// enum InputFieldType { text, password, email, number, date, time, dropdown, multiLine }

// class CustomInputField extends StatefulWidget {
//   final InputFieldType fieldType;
//   final String? label;
//   final List<String>? dropdownItems;
//   final TextEditingController? controller;
//   final ValueChanged<String>? onChanged;

//   final String? hintText;
//   final TextStyle? hintStyle;
//   final Color? fillColor;
//   final Widget? prefixIcon;
//   final TextStyle? style;
//   final Color? cursorColor;

//   const CustomInputField({
//     Key? key,
//     required this.fieldType,
//     this.label,
//     this.dropdownItems,
//     this.controller,
//     this.onChanged,
//     this.hintText,
//     this.hintStyle,
//     this.fillColor,
//     this.prefixIcon,
//     this.style,
//     this.cursorColor,
//   }) : super(key: key);

//   @override
//   State<CustomInputField> createState() => _CustomInputFieldState();
// }

// class _CustomInputFieldState extends State<CustomInputField> {
//   late TextEditingController _controller;
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? TextEditingController();
//   }

//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }

//   Future<void> _pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _controller.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   Future<void> _pickTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime ?? TimeOfDay.now(),
//     );
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//         _controller.text = picked.format(context);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (widget.fieldType) {
//       case InputFieldType.text:
//       case InputFieldType.multiLine:
//         return TextField(
//           controller: _controller,
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             labelText: widget.label,
//           ),
//           obscureText: widget.fieldType == InputFieldType.password,
//           keyboardType: widget.fieldType == InputFieldType.multiLine
//               ? TextInputType.multiline
//               : TextInputType.text,
//           maxLines: widget.fieldType == InputFieldType.multiLine ? null : 1,
//         );
//       case InputFieldType.password:
//         return TextField(
//           controller: _controller,
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             labelText: widget.label,
//           ),
//           obscureText: true,
//         );
//       case InputFieldType.email:
//         return TextField(
//           controller: _controller,
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             labelText: widget.label,
//           ),
//           keyboardType: TextInputType.emailAddress,
//         );
//       case InputFieldType.number:
//         return TextField(
//           controller: _controller,
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             labelText: widget.label,
//           ),
//           keyboardType: TextInputType.number,
//         );
//       case InputFieldType.date:
//         return TextField(
//           controller: _controller,
//           decoration: InputDecoration(
//             labelText: widget.label,
//             hintText: "YYYY-MM-DD",
//           ),
//           readOnly: true,
//           onTap: () => _pickDate(context),
//         );
//       case InputFieldType.time:
//         return TextField(
//           controller: _controller,
//           decoration: InputDecoration(
//             labelText: widget.label,
//             hintText: "HH:MM",
//           ),
//           readOnly: true,
//           onTap: () => _pickTime(context),
//         );
//       case InputFieldType.dropdown:
//         return DropdownButtonFormField<String>(
//           value: _controller.text.isNotEmpty ? _controller.text : null,
//           items: widget.dropdownItems?.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               _controller.text = newValue!;
//               if (widget.onChanged != null) {
//                 widget.onChanged!(_controller.text);
//               }
//             });
//           },
//           decoration: InputDecoration(
//             labelText: widget.label,
//           ),
//         );
//       default:
//         return Container(); // Fallback for undefined field type
//     }
//   }
// }

import 'package:flutter/material.dart';

enum InputFieldType {
  text,
  password,
  email,
  number,
  date,
  time,
  dropdown,
  multiLine
}

class CustomInputField extends StatefulWidget {
  final InputFieldType fieldType;
  final String? label;
  final String? hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextStyle? style;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;

  const CustomInputField({
    Key? key,
    required this.fieldType,
    this.label,
    this.hintText,
    this.labelStyle,
    this.hintStyle,
    this.fillColor,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.style,
    this.cursorColor,
    this.contentPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: widget.labelStyle ?? Theme.of(context).textTheme.subtitle1,
          ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          style: widget.style ?? Theme.of(context).textTheme.bodyText2,
          cursorColor:
              widget.cursorColor ?? Theme.of(context).colorScheme.secondary,
          obscureText:
              widget.fieldType == InputFieldType.password && _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.grey.shade600),
            filled: true,
            fillColor: widget.fillColor ??
                Theme.of(context).inputDecorationTheme.fillColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.fieldType == InputFieldType.password
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color:
                          Theme.of(context).iconTheme.color?.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
          keyboardType: _getKeyboardType(widget.fieldType),
          maxLines: widget.fieldType == InputFieldType.multiLine ? null : 1,
        ),
      ],
    );
  }

  TextInputType _getKeyboardType(InputFieldType fieldType) {
    switch (fieldType) {
      case InputFieldType.number:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputFieldType.email:
        return TextInputType.emailAddress;
      case InputFieldType.date:
      case InputFieldType.time:
        return TextInputType
            .none; // These are handled by separate picker widgets
      case InputFieldType.multiLine:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
}
