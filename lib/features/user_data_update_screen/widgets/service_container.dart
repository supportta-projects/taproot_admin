
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taproot_admin/exporter/exporter.dart';
import 'package:taproot_admin/features/user_data_update_screen/data/portfolio_model.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/expand_tile_container.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_card.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/service_edit.dart';
import 'package:taproot_admin/features/user_data_update_screen/widgets/textform_container.dart';
import 'package:taproot_admin/features/users_screen/data/user_data_model.dart';
import 'package:taproot_admin/widgets/common_product_container.dart';

class ServiceContainer extends StatefulWidget {
  final TextEditingController? serviceHeadingController;
  final TextEditingController? serviceDescriptionController;
  final PortfolioDataModel? portfolio;
  final VoidCallback saveButton;
  final bool isEdited;

  const ServiceContainer({
    this.isEdited = false,
    super.key,
    required this.user,
    this.portfolio,
    this.serviceHeadingController,
    this.serviceDescriptionController,
    required this.saveButton,
  });
  final User user;

  @override
  State<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends State<ServiceContainer> {
  int? selectedServiceIndex;
  bool showEdit = false;

  void tapEdit(int index) {
    final services = widget.portfolio?.services ?? [];

    if (index < 0 || index >= services.length) return;

    final selectedService = services[index];

    if (selectedService.heading.isNotEmpty ||
        selectedService.description.isNotEmpty) {
      widget.serviceHeadingController?.text = selectedService.heading;
      widget.serviceDescriptionController?.text = selectedService.description;
    }

    setState(() {
      selectedServiceIndex = index;
      showEdit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final validServices =
        (widget.portfolio?.services ?? [])
            .where(
              (service) =>
                  service.heading.trim().isNotEmpty ||
                  service.description.trim().isNotEmpty,
            )
            .toList();

    return widget.isEdited
        ? ExpandTileContainer(
          title: 'Your Services',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormContainer(
                  initialValue: 'About me',
                  labelText: 'Heading/topic',
                  user: widget.user,
                ),
                Gap(CustomPadding.padding.v),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: CustomPadding.paddingLarge,
                      ),
                      child: Wrap(
                        runAlignment: WrapAlignment.start,
                        alignment: WrapAlignment.start,
                        spacing: 16,
                        runSpacing: 16,
                        children:
                            validServices.asMap().entries.map((entry) {
                              final index = entry.key;
                              final service = entry.value;
                              return GestureDetector(
                                onTap: () => tapEdit(index),
                                child: ServiceCard(
                                  isEdited: widget.isEdited,
                                  title: service.heading,
                                  description: service.description,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    Gap(CustomPadding.paddingXL.v),
                    if (showEdit)
                      ServiceEdit(
                        saveButton: widget.saveButton,
                        widget: widget,
                        service:
                            selectedServiceIndex != null &&
                                    selectedServiceIndex! < validServices.length
                                ? validServices[selectedServiceIndex!]
                                : Service(heading: '', description: ''),
                        serviceHeadingController:
                            widget.serviceHeadingController,
                        serviceDescriptionController:
                            widget.serviceDescriptionController,
                      ),
                    if (validServices.length < 3 && !showEdit)
                      Builder(
                        builder: (context) {
                          widget.serviceHeadingController?.clear();
                          widget.serviceDescriptionController?.clear();
                          return ServiceEdit(
                            saveButton: widget.saveButton,
                            widget: widget,
                            service: Service(heading: '', description: ''),
                            serviceHeadingController:
                                widget.serviceHeadingController,
                            serviceDescriptionController:
                                widget.serviceDescriptionController,
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ],
        )
        : validServices.isEmpty
        ? const SizedBox()
        : Expanded(
          child: CommonProductContainer(
            title: 'Your Services',
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomPadding.paddingXL.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(CustomPadding.paddingLarge.v),
                    Text('My Works', style: context.inter50016),
                    Gap(CustomPadding.paddingLarge.v),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 20,
                      runSpacing: 20,
                      runAlignment: WrapAlignment.start,
                      children:
                          validServices.map((service) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: ServiceCard(
                                title: service.heading,
                                description: service.description,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              Gap(CustomPadding.paddingXL.v),
            ],
          ),
        );
  }
}
