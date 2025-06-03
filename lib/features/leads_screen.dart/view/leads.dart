import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taproot_admin/constants/constants.dart';
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
  final int _rowsPerPage = 5;
  int _currentPage = 1;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _fetchLeads();
  }

  Future<void> _fetchLeads() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await LeadsService.getLeads(
        page: _currentPage,
        limit: _rowsPerPage,
      );
      setState(() {
        _leads = response?.results ?? [];
        _total = response?.totalCount ?? 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load leads: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _handlePageChange(int firstRowIndex) {
    final page = (firstRowIndex ~/ _rowsPerPage) + 1;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
      _fetchLeads();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchLeads),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchLeads,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: EdgeInsets.all(CustomPadding.paddingLarge.v),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: .87 * SizeUtils.width,

                    child: PaginatedDataTable(
                      showFirstLastButtons: true,
                      arrowHeadColor: CustomColors.borderGradient.colors.first,
                      dataRowMaxHeight: 120,
                      rowsPerPage: _rowsPerPage,
                      availableRowsPerPage: const [5],
                      onRowsPerPageChanged: null,
                      initialFirstRowIndex: (_currentPage - 1) * _rowsPerPage,
                      onPageChanged: _handlePageChange,
                      columns: const [
                        DataColumn(label: Text('Full Name')),
                        DataColumn(label: Text('Phone Number')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('WhatsApp')),
                      ],
                      source: _LeadsDataSource(
                        leads: _leads,
                        context: context,
                        totalRowCount: _total,
                        currentPage: _currentPage,
                        rowsPerPage: _rowsPerPage,
                      ),
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
  final int totalRowCount;
  final int currentPage;
  final int rowsPerPage;

  _LeadsDataSource({
    required this.leads,
    required this.context,
    required this.totalRowCount,
    required this.currentPage,
    required this.rowsPerPage,
  });

  @override
  DataRow? getRow(int index) {
    final localIndex = index % rowsPerPage; // key fix
    if (localIndex >= leads.length) return null;
    final lead = leads[localIndex];

    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(lead.name[0].toUpperCase() + lead.name.substring(1)),
          ),
        ),
        DataCell(Center(child: Text(lead.number))),
        DataCell(Center(child: Text(lead.email))),
        DataCell(
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (BuildContext context) => AlertDialog(
                      title: const Text("Lead Description"),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 700,
                          maxHeight: 300,
                        ),
                        child: Scrollbar(
                          thickness: 2,
                          radius: const Radius.circular(4),
                          child: SingleChildScrollView(
                            child: Text(
                              lead.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.hintGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
              );
            },
            child: Center(
              child: const Text("View", style: TextStyle(color: Colors.blue)),
            ),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () async {
              final phoneNumber = lead.number.replaceAll(RegExp(r'[^\d+]'), '');
              final uri = Uri.parse('https://wa.me/$phoneNumber');
              try {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  SnackbarHelper.showError(context, 'Could not open WhatsApp');
                }
              } catch (e) {
                SnackbarHelper.showError(context, 'Error: ${e.toString()}');
              }
            },
            child: Center(
              child: SvgPicture.asset(Assets.svg.whatsapp, height: 50),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRowCount;

  @override
  int get selectedRowCount => 0;
}
