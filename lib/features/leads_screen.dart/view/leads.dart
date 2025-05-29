import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/Expense_screen/widgets/expense_description_container.dart';
import 'package:taproot_admin/features/leads_screen.dart/data/leads_model.dart';
import 'package:taproot_admin/features/leads_screen.dart/data/leads_service.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/services/size_utils.dart';
import 'package:taproot_admin/widgets/snakbar_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});
  static const path = '/leadsScreen';

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  List<Lead> _leads = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    getLeads();
  }

  Future<void> getLeads() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await LeadsService.getLeads();
      setState(() {
        _leads = response?.results ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load leads: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: getLeads)],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_error!, style: TextStyle(color: Colors.red)),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: getLeads, child: Text('Retry')),
                  ],
                ),
              )
              : Padding(
                padding: EdgeInsets.all(CustomPadding.paddingLarge.v),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: SizeUtils.height * 0.75,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      // columnSpacing: 260,
                      dataRowMaxHeight: 100,
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Full Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: CustomColors.hintGrey),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Phone Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: CustomColors.hintGrey),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Email',
                              style: TextStyle(color: CustomColors.hintGrey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Description',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: CustomColors.hintGrey),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: CustomColors.hintGrey),
                            ),
                          ),
                        ),
                      ],
                      source: _LeadsDataSource(_leads, context),
                      rowsPerPage: 6,
                    ),
                  ),
                ),
              ),
    );
  }
}

class _LeadsDataSource extends DataTableSource {
  final List<Lead> leads;
  final BuildContext context;

  _LeadsDataSource(this.leads, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= leads.length) return null;
    final lead = leads[index];
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              lead.name[0].toUpperCase() + lead.name.substring(1),
              style: TextStyle(
                color: CustomColors.greenDark,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
        DataCell(Center(child: Text(lead.number))),
        DataCell(Center(child: Text(lead.email))),
        DataCell(
          ExpenseDescriptionContainer(
            children: [
              Center(
                child: Text(
                  lead.description,
                  style: TextStyle(color: CustomColors.hintGrey),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          InkWell(
            onTap: () async {
              final phoneNumber = lead.number.replaceAll(RegExp(r'[^\d+]'), '');
              final uri = Uri.parse('https://wa.me/$phoneNumber');

              try {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    //  mode: LaunchMode.externalApplication
                  );
                } else {
                  if (context.mounted) {
                    SnackbarHelper.showError(
                      context,
                      'Could not open WhatsApp',
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  SnackbarHelper.showError(context, 'Error: ${e.toString()}');
                }
              }
            },
            child: SvgPicture.asset(Assets.svg.whatsapp),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => leads.length;

  @override
  int get selectedRowCount => 0;
}
