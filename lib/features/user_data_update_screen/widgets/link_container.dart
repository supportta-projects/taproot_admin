import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';

class LinkContainer extends StatefulWidget {
  final String name;
  final String svg;
  final String initaialValue;
   final ValueChanged<String>? onChanged; 

  const LinkContainer({
    super.key,
    required this.user,
    required this.name,
    required this.svg,
    this.initaialValue = '',
    this.onChanged,
  });

  final User user;

  @override
  State<LinkContainer> createState() => _LinkContainerState();
}

class _LinkContainerState extends State<LinkContainer> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: widget.initaialValue);
     _controller.addListener(() {
      widget.onChanged!(_controller.text);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70.v,
            color: Colors.white,
            child: Row(
              children: [
                Gap(CustomPadding.paddingXL.v),

                SvgPicture.asset(widget.svg),
                Gap(CustomPadding.paddingLarge.v),
                Text(
                  widget.name,
                  style: context.inter60016.copyWith(
                    fontSize: 16.fSize,
                    color: CustomColors.textColorGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 70,
            color: Colors.white,
            child: TextFormContainer(
              controller: _controller,
              initialValue: widget.initaialValue,
              labelText: 'Link',
              user: widget.user,
            ),
          ),
        ),
      ],
    );
  }
}
