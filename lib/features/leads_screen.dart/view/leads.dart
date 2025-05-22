import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taproot_admin/constants/constants.dart';
import 'package:taproot_admin/features/Expense_screen/widgets/expense_description_container.dart';
import 'package:taproot_admin/features/leads_screen.dart/data/leads_model.dart';
import 'package:taproot_admin/features/leads_screen.dart/data/leads_service.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
import 'package:taproot_admin/services/size_utils.dart';

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
              : SizedBox(
                height: SizeUtils.height * 0.75,
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    columnSpacing: 260,
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
                    source: _LeadsDataSource(_leads),
                    rowsPerPage: 5,
                  ),
                ),
              ),
    );
  }
}

class _LeadsDataSource extends DataTableSource {
  final List<Lead> leads;

  _LeadsDataSource(this.leads);

  @override
  DataRow? getRow(int index) {
    if (index >= leads.length) return null;
    final lead = leads[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            lead.name[0].toUpperCase() + lead.name.substring(1),
            style: TextStyle(
              color: CustomColors.greenDark,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        DataCell(Text(lead.number)),
        DataCell(Text(lead.email)),
        DataCell(
          ExpenseDescriptionContainer(
            children: [
              Text(
                lead.description,
                style: TextStyle(color: CustomColors.hintGrey),
              ),
            ],
          ),
        ),
        DataCell(SvgPicture.asset(Assets.svg.whatsapp)),
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
