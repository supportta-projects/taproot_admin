import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/common_user_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/detail_row_copy.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/gradient_text.dart';

class BasicDetailContainer extends StatefulWidget {
  final TextEditingController? namecontroller;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final TextEditingController? whatsappController;
  final PortfolioDataModel? portfolio;
  final bool autofocus;
  final dynamic user;
  final bool isEdit;
  final String? initialValue;

  const BasicDetailContainer({
    super.key,
    required this.user,
    this.autofocus = false,
    this.isEdit = false,
    this.portfolio,
    this.initialValue,
    this.namecontroller,
    this.emailController,
    this.phoneController,
    this.whatsappController,
  });

  @override
  State<BasicDetailContainer> createState() => _BasicDetailContainerState();
}

class _BasicDetailContainerState extends State<BasicDetailContainer> {
  late User user;

  @override
  void initState() {
    user = widget.user;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonUserContainer(
      title: 'Basic Details',
      children: [
        Gap(CustomPadding.paddingLarge.v),
        widget.isEdit
            ? TextFormContainer(
              autofocus: widget.autofocus,
              controller: widget.namecontroller,
              // controller: widget.namecontroller,
              user: widget.user,
              // initialValue:widget.initialValue,
              labelText: 'Full Name',
            )
            : DetailRow(
              label: 'Full Name',
              value: widget.portfolio?.personalInfo.name ?? 'loading...',
            ),

        widget.isEdit
            ? TextFormContainer(
              controller: widget.emailController,
              user: widget.user,
              // initialValue: widget.portfolio!.personalInfo.email,
              labelText: 'Email',
            )
            : DetailRow(
              label: 'Email',
              value: widget.portfolio?.personalInfo.email ?? 'loading...',
            ),
        widget.isEdit
            ? TextFormContainer(
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9+]*$')),
                // FilteringTextInputFormatter.digitsOnly,
              ],
              user: widget.user,
              controller: widget.phoneController,
              labelText: 'Phone Number',
            )
            : DetailRow(
              label: 'Phone Number',
              value: widget.portfolio?.personalInfo.phoneNumber ?? 'loading...',
            ),
        widget.isEdit
            ? TextFormContainer(
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
                FilteringTextInputFormatter.allow(RegExp(r'^\+91[0-9]*$')),
              ],
              user: widget.user,
              controller: widget.whatsappController,
              labelText: 'WhatsApp Number',
            )
            : DetailRow(
              label: 'WhatsApp Number',
              value:
                  widget.portfolio?.personalInfo.whatsappNumber ?? 'loading...',
            ),
        widget.isEdit
            ? SizedBox()
            : DetailRowCopy(
              label: 'Portfolio Link',
              value: 'https://docs.google.com',
              icon: Icons.copy,
            ),
        widget.isEdit ? SizedBox() : Gap(CustomPadding.padding.v),
        widget.isEdit
            ? SizedBox()
            : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingLarge.v,
              ),
              child: Row(
                children: [
                  Text(
                    'QR Code',
                    style: context.inter50014.copyWith(fontSize: 14.fSize),
                  ),
                  Spacer(),
                  GradientText(
                    'Download',
                    gradient: CustomColors.borderGradient,
                    style: context.inter50014.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: CustomColors.greenDark,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
