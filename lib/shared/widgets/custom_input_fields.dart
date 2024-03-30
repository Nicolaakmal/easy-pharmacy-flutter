import 'package:flutter/material.dart';

enum InputFieldType { text, password, email, number, date, time, dropdown, multiLine }

class CustomInputField extends StatefulWidget {
  final InputFieldType fieldType;
  final String? label;
  final List<String>? dropdownItems;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomInputField({
    Key? key,
    required this.fieldType,
    this.label,
    this.dropdownItems,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late TextEditingController _controller;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.fieldType) {
      case InputFieldType.text:
      case InputFieldType.multiLine:
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.label,
          ),
          obscureText: widget.fieldType == InputFieldType.password,
          keyboardType: widget.fieldType == InputFieldType.multiLine
              ? TextInputType.multiline
              : TextInputType.text,
          maxLines: widget.fieldType == InputFieldType.multiLine ? null : 1,
        );
      case InputFieldType.password:
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.label,
          ),
          obscureText: true,
        );
      case InputFieldType.email:
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.label,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      case InputFieldType.number:
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.label,
          ),
          keyboardType: TextInputType.number,
        );
      case InputFieldType.date:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: "YYYY-MM-DD",
          ),
          readOnly: true,
          onTap: () => _pickDate(context),
        );
      case InputFieldType.time:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: "HH:MM",
          ),
          readOnly: true,
          onTap: () => _pickTime(context),
        );
      case InputFieldType.dropdown:
        return DropdownButtonFormField<String>(
          value: _controller.text.isNotEmpty ? _controller.text : null,
          items: widget.dropdownItems?.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _controller.text = newValue!;
              if (widget.onChanged != null) {
                widget.onChanged!(_controller.text);
              }
            });
          },
          decoration: InputDecoration(
            labelText: widget.label,
          ),
        );
      default:
        return Container(); // Fallback for undefined field type
    }
  }
}
