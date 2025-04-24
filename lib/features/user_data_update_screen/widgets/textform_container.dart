import 'package:flutter/material.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/users_screen/user_data_model.dart';

class TextFormContainer extends StatefulWidget {
  final String initialValue;
  final int maxline;
  final bool readonly;
  final String labelText;
  final User? user;
  final bool isDatePicker;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const TextFormContainer({
    super.key,
    required this.initialValue,
    required this.labelText,
    this.user,
    this.readonly = false,
    this.maxline = 1,
    this.isDatePicker = false,
    this.onChanged,
    this.validator,
  });

  @override
  State<TextFormContainer> createState() => _TextFormContainerState();
}

class _TextFormContainerState extends State<TextFormContainer> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Set initial value in controller
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final formatted =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setState(() {
        _controller.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.paddingLarge.v,
        vertical: CustomPadding.padding.v,
      ),
      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        controller: _controller,
        maxLines: widget.maxline,
        readOnly: widget.readonly || widget.isDatePicker,
        onTap: widget.isDatePicker ? _pickDate : null,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(widget.labelText),
          labelStyle: TextStyle(color: CustomColors.textColorDarkGrey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.textColorLightGrey),
          ),
        ),
      ),
    );
  }
}


// class TextFormContainer extends StatelessWidget {
//   final String initialValue;
//   final int maxline;
//   final bool readonly;
//   final String labelText;
//   final User? user;
//   final bool isDatePicker;
//   const TextFormContainer({
//     super.key,
//     required this.initialValue,
//     required this.labelText,
//     this.user,
//     this.readonly = false,
//     this.maxline = 1,
//     this.isDatePicker=false
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: CustomPadding.paddingLarge.v,
//         vertical: CustomPadding.padding.v,
//       ),
//       child: TextFormField(
//         maxLines: maxline,
//         readOnly: readonly,
//         initialValue: initialValue,
//            onTap:
//             isDatePicker
//                 ? () async {
//                   final selectedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime(2100),
//                   );

//                   if (selectedDate != null) {
//                     // show selected date as snackbar or save via callback
//                     print('Selected date: $selectedDate');
//                     // You can use a controller or notify parent through a callback
//                   }
//                 }
//                 : null,
//         decoration: InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           label: Text(labelText),
//           labelStyle: TextStyle(color: CustomColors.textColorDarkGrey),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: CustomColors.textColorLightGrey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: CustomColors.textColorLightGrey),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class TextFormContainer extends StatelessWidget {
//   final String? initialValue;
//   final bool readonly;
//   final String? labelText;
//   final User? user;

//   const TextFormContainer({
//     super.key,
//     this.initialValue,
//     this.labelText,
//     this.user,
//     this.readonly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: CustomPadding.paddingLarge.v,
//         vertical: CustomPadding.padding.v,
//       ),
//       child: TextFormField(
//         readOnly: readonly,
//         initialValue: initialValue,
//         decoration: InputDecoration(
//           label: labelText != null ? Text(labelText!) : null,
//           labelStyle: TextStyle(color: CustomColors.textColorDarkGrey),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: CustomColors.textColorLightGrey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: CustomColors.textColorLightGrey),
//           ),
//         ),
//       ),
//     );
//   }
// }
