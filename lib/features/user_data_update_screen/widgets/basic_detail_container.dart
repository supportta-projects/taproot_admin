import 'package:flutter/material.dart';
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
  final PortfolioDataModel? portfolio;

  final dynamic user;
  final bool isEdit;
  const BasicDetailContainer({
    super.key,
    required this.user,
    this.isEdit = false,
    this.portfolio,
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
              user: widget.user,
              initialValue: widget.portfolio!.name,
              labelText: 'Full Name',
            )
            : DetailRow(
              label: 'Full Name',
              value: widget.portfolio?.name ?? 'loading...',
            ),

        widget.isEdit
            ? TextFormContainer(
              readonly: true,
              user: widget.user,
              initialValue: widget.portfolio!.email,
              labelText: 'Email',
            )
            : DetailRow(
              label: 'Email',
              value: widget.portfolio?.email ?? 'loading...',
            ),
        widget.isEdit
            ? TextFormContainer(
              user: widget.user,
              initialValue: widget.portfolio!.phoneNumber,
              labelText: 'Phone Number',
            )
            : DetailRow(
              label: 'Phone Number',
              value: widget.portfolio?.phoneNumber ?? 'loading...',
            ),
        widget.isEdit
            ? TextFormContainer(
              user: widget.user,
              initialValue: widget.portfolio!.whatsappNumber,
              labelText: 'WhatsApp Number',
            )
            : DetailRow(
              label: 'WhatsApp Number',
              value: widget.portfolio?.whatsappNumber ?? 'loading...',
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
