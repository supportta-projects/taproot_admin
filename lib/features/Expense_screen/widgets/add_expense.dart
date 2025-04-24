import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';
import 'package:taproot_admin/widgets/mini_gradient_border.dart';
import 'package:taproot_admin/widgets/mini_loading_button.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  String? category;
  String expenseName = '';
  String amount = '';
  String date = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Gap(CustomPadding.paddingLarge.v),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MiniGradientBorderButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  gradient: LinearGradient(
                    colors: CustomColors.borderGradient.colors,
                  ),
                ),
                Gap(CustomPadding.paddingLarge.v),
                MiniLoadingButton(
                  needRow: false,

                  text: 'Add',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newExpense = {
                        'category': category ?? '',
                        'name': expenseName,
                        'amount': amount,
                        'date': date,
                        'description': description,
                      };

                      Navigator.pop(context, newExpense);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                    }
                  },
                  useGradient: true,
                  gradientColors: CustomColors.borderGradient.colors,
                ),
                Gap(CustomPadding.paddingXL.v),
              ],
            ),
            Gap(CustomPadding.paddingLarge.v),
            CommonProductContainer(
              title: 'Add Expense',
              children: [
                Gap(CustomPadding.paddingXL.v),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CustomPadding.paddingLarge.v,
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: context.inter40016,
                            border: OutlineInputBorder(),
                          ),
                          items:
                              ['order', 'shop', 'other'].map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                            logInfo('Selected: $value');
                          },
                          validator: (value) {
                            value == null ? 'Please select a category' : null;
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormContainer(
                        initialValue: '',
                        labelText: 'Expense Name',
                        onChanged: (value) {
                          setState(() {
                            expenseName = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Gap(CustomPadding.paddingLarge.v),
                Row(
                  children: [
                    Expanded(
                      child: TextFormContainer(
                        initialValue: '₹',
                        labelText: 'Amount',
                        onChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                        validator: (value) {
                          value == null || value.isEmpty
                              ? 'Please enter Amount'
                              : null;
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormContainer(
                        isDatePicker: true,

                        initialValue: 'Select Date',
                        labelText: 'Date',
                        onChanged: (value) {
                          setState(() {
                            date = value;
                          });
                        },
                        validator: (value) {
                          value == null || value.isEmpty
                              ? 'Please enter name'
                              : null;
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Gap(CustomPadding.paddingLarge.v),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormContainer(
                        maxline: 6,
                        initialValue: '',
                        labelText: 'Description',
                        onChanged: (value) {
                          description = value;
                        },
                        validator: (value) {
                          value == null || value.isEmpty
                              ? 'Please enter name'
                              : null;
                          return null;
                        },
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Gap(CustomPadding.paddingXL.v),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
