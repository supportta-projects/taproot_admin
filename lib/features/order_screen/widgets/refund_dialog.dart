import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/order_screen/data/order_service.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';
import 'package:taproot_admin/widgets/snakbar_helper.dart';

class RefundDialog extends StatefulWidget {
  final double totalAmount;
  final String orderId;

  const RefundDialog({
    super.key,
    required this.totalAmount,
    required this.orderId,
  });

  @override
  State<RefundDialog> createState() => _RefundDialogState();
}

class _RefundDialogState extends State<RefundDialog> {
  final TextEditingController percentageController = TextEditingController();
  String selectedRefundType = 'partial';
  double calculatedAmount = 0.0;
  double remainingAmount = 0.0;
  // Future<void> orderRefund() async {
  //   final response = await OrderService.cancelOrder(
  //     orderId: widget.orderId,
  //     refundPercentage: int.parse(percentageController.text),
  //   );
  // }
  Future<void> orderRefund() async {
    try {
      final response = await OrderService.cancelOrder(
        orderId: widget.orderId,
        refundPercentage: int.parse(percentageController.text),
      );

      if (response.status == true) {
        SnackbarHelper.showSuccess(context, 'Order cancelled successfully');
        Navigator.of(context).pop();
        // widget.onRefresh?.call();
      }
    } catch (e) {
      SnackbarHelper.showError(context, '$e');
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    remainingAmount = widget.totalAmount;
  }

  @override
  void dispose() {
    percentageController.dispose();
    super.dispose();
  }

  void _updateRefundCalculations(String value) {
    setState(() {
      if (value.isNotEmpty) {
        double percentage = double.tryParse(value) ?? 0;
        if (percentage > 100) {
          percentageController.text = '100';
          percentage = 100;
          percentageController.selection = TextSelection.fromPosition(
            TextPosition(offset: percentageController.text.length),
          );
        }
        calculatedAmount = (widget.totalAmount * percentage) / 100;
        remainingAmount = widget.totalAmount - calculatedAmount;
      } else {
        calculatedAmount = 0;
        remainingAmount = widget.totalAmount;
      }
    });
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Gap(CustomPadding.paddingLarge.v),
        Text('Cancel Order & Initiate Refund', style: context.inter60022),
        Gap(CustomPadding.paddingLarge.v),
        Divider(thickness: 1, color: CustomColors.textColor),
        Gap(CustomPadding.paddingLarge.v),
        Row(
          children: [
            Text(
              'You are about to cancel this order. Please choose a refund method below.',
            ),
          ],
        ),
        Gap(CustomPadding.paddingLarge.v),
      ],
    );
  }

  Widget _buildFullRefundOption() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio<String>(
          value: 'full',
          groupValue: selectedRefundType,
          onChanged: (value) => setState(() => selectedRefundType = value!),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Refund Full Amount'),
            Gap(CustomPadding.paddingLarge.v),
            Text(
              widget.totalAmount.toString(),
              style: context.inter50014.copyWith(color: CustomColors.hintGrey),
            ),
            Gap(CustomPadding.paddingXL.v),
          ],
        ),
      ],
    );
  }

  Widget _buildPartialRefundOption() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio<String>(
          value: 'partial',
          groupValue: selectedRefundType,
          onChanged: (value) => setState(() => selectedRefundType = value!),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Refund Partial Amount'),
            Gap(CustomPadding.paddingLarge.v),
            Row(
              children: [
                Container(
                  width: 50.v,
                  height: 30.v,
                  decoration: BoxDecoration(
                    color: CustomColors.greylight,
                    borderRadius: BorderRadius.circular(4.v),
                  ),
                  child: TextFormField(
                    controller: percentageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8.v,
                        vertical: 4.v,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: _updateRefundCalculations,
                  ),
                ),
                Text(' % of total amount'),
              ],
            ),
            Text('₹${remainingAmount.toStringAsFixed(2)}'),
            // Gap(CustomPadding.paddingLarge.v),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              ' Refund to be sent: ₹${selectedRefundType == 'full' ? widget.totalAmount.toStringAsFixed(2) : remainingAmount.toStringAsFixed(2)}',
            ),
          ],
        ),
        Gap(CustomPadding.paddingXXL.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MiniLoadingButton(
              needRow: false,
              useGradient: true,
              text: 'Submit Refund',
              onPressed: () {
                orderRefund();
                // Handle refund submission
              },
            ),
            Gap(CustomPadding.paddingXL.v),
            MiniGradientBorderButton(
              text: 'Cancel',
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(
                colors: CustomColors.borderGradient.colors,
              ),
            ),
          ],
        ),
        Gap(CustomPadding.paddingXL.v),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingXL.v),
        decoration: BoxDecoration(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(CustomPadding.paddingLarge.v),
        ),
        width: 700.h,
        height: 400.h,
        child: Column(
          children: [
            _buildHeader(),
            Row(
              children: [
                _buildFullRefundOption(),
                SizedBox(width: 40.v),
                _buildPartialRefundOption(),
              ],
            ),

            Spacer(),

            _buildFooter(),
          ],
        ),
      ),
    );
  }
}
