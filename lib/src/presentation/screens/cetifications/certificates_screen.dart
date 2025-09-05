import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/data/sources/remote/api_key.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/l10n.dart';
import '../../../core/utils/enums.dart';

class CertificateInstallationView extends StatefulWidget {
  const CertificateInstallationView({super.key});

  @override
  State<CertificateInstallationView> createState() =>
      _CertificateInstallationViewState();
}

class _CertificateInstallationViewState
    extends State<CertificateInstallationView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CertificateInstallationCubit>().loadCertificates();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CertificateInstallationCubit>().loadMoreCertificates();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.certificatesTitle,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorSchemes.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorSchemes.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<CertificateInstallationCubit,
          CertificateInstallationState>(
        builder: (context, state) {
          if (state is CertificateInstallationLoading &&
              (state is! CertificateInstallationLoaded)) {
            return const Center(
                child: SpinKitDoubleBounce(color: ColorSchemes.primary));
          }

          if (state is CertificateInstallationError) {
            return Center(child: Text(l10n.errorMessage(state.message)));
          }

          if (state is CertificateInstallationLoaded) {
            if (state.data.isEmpty) {
              return Center(child: Text(l10n.noCertificates));
            }

            return RefreshIndicator(
              onRefresh: () => context
                  .read<CertificateInstallationCubit>()
                  .refreshCertificates(),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.data.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.data.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: ColorSchemes.primary,
                        ),
                      ),
                    );
                  }

                  final installation = state.data[index];
                  return _buildConsumerCard(installation, l10n);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildConsumerCard(CertificateInstallation installation, S l10n) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      elevation: 2,
      // color: ColorSchemes.white,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        title: Text(
          l10n.consumer(installation.consumer.name),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: installation.branches.map((branch) {
          return _buildBranchCard(branch, l10n);
        }).toList(),
      ),
    );
  }

  Widget _buildBranchCard(Branch branch, S l10n) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: ColorSchemes.white, width: 2),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ColorSchemes.white, width: 2),
        ),
        title: Text(
          l10n.branch(branch.name),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(l10n.address(branch.address)),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: ColorSchemes.secondary),
            title: Text(l10n.responsible(branch.responseEmployee.fullName)),
          ),
          const Divider(),
          ...branch.certificates.map((cert) {
            return ListTile(
              leading:
                  const Icon(Icons.picture_as_pdf, color: ColorSchemes.primary),
              title: Text(l10n.requestNumber(cert.scheduleJob.requestNumber)),
              subtitle:
                  Text(S.of(context).type + _getTitle(cert.scheduleJob.type)),
              trailing: Text(
                DateTime.fromMillisecondsSinceEpoch(cert.createdAt)
                    .toLocal()
                    .toString()
                    .split(" ")
                    .first,
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                _openCertificate(cert.file ?? "", l10n);
              },
            );
          }),
        ],
      ),
    );
  }

  String _getTitle(String requestType) {
    if (RequestType.FireExtinguisher.name == requestType) {
      return S.of(context).fireSystems;
    } else if (RequestType.MaintenanceContract.name == requestType) {
      return S.of(context).maintenanceContracts;
    } else {
      return S.of(context).instantLicense;
    }
  }

  /// فتح ملف الشهادة
  Future<void> _openCertificate(String fileUrl, S l10n) async {
    if (fileUrl.isEmpty) {
      _showSnackBar(l10n.fileUnavailable, Colors.red);
      return;
    }

    try {
      final Uri url = Uri.parse(fileUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar(l10n.openError, Colors.red);
      }
    } catch (e) {
      _showSnackBar("Error: ${e.toString()}", Colors.red);
    }
  }

  /// SnackBar helper
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

//
// --- States & Cubit ---
//
abstract class CertificateInstallationState {}

class CertificateInstallationInitial extends CertificateInstallationState {}

class CertificateInstallationLoading extends CertificateInstallationState {}

class CertificateInstallationLoaded extends CertificateInstallationState {
  final List<CertificateInstallation> data;
  final bool hasReachedMax;

  CertificateInstallationLoaded(
      {required this.data, this.hasReachedMax = false});
}

class CertificateInstallationError extends CertificateInstallationState {
  final String message;

  CertificateInstallationError(this.message);
}

class CertificateInstallationCubit extends Cubit<CertificateInstallationState> {
  final CertificateInstallationApiService apiService;
  final String token;
  int page = 1;
  final int limit = 10;
  bool hasReachedMax = false;
  List<CertificateInstallation> allData = [];

  CertificateInstallationCubit(this.apiService, this.token)
      : super(CertificateInstallationInitial());

  Future<void> loadCertificates() async {
    if (state is CertificateInstallationLoading) return;
    emit(CertificateInstallationLoading());
    try {
      final data = await apiService.fetchCertificates(
        page: 1,
        limit: limit,
        token: token,
      );
      allData = data;
      page = 2;

      // ✅ لو البيانات أقل من limit أو لو مفيش بيانات خلاص
      hasReachedMax = data.isEmpty || data.length < limit;

      emit(CertificateInstallationLoaded(
          data: allData, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(CertificateInstallationError(e.toString()));
    }
  }

  Future<void> loadMoreCertificates() async {
    if (hasReachedMax) return;
    try {
      final data = await apiService.fetchCertificates(
        page: page,
        limit: limit,
        token: token,
      );

      if (data.isEmpty || data.length < limit) {
        hasReachedMax = true;
      } else {
        allData.addAll(data);
        page++;
      }

      emit(CertificateInstallationLoaded(
          data: allData, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(CertificateInstallationError(e.toString()));
    }
  }

  Future<void> refreshCertificates() async {
    page = 1;
    hasReachedMax = false;
    await loadCertificates();
  }
}

//
// --- API Service & Models ---
//
class CertificateInstallationApiService {
  Future<List<CertificateInstallation>> fetchCertificates({
    int page = 1,
    int limit = 10,
    required String token,
  }) async {
    final url = Uri.parse(
        "${APIKeys.baseUrl}/api/provider/certificate-of-equipment-installations?page=$page&limit=$limit");

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final result = body['result'] as List<dynamic>;
      return result.map((e) => CertificateInstallation.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load certificates: ${response.body}");
    }
  }
}

class CertificateInstallation {
  final List<Branch> branches;
  final Consumer consumer;

  CertificateInstallation({required this.branches, required this.consumer});

  factory CertificateInstallation.fromJson(Map<String, dynamic> json) {
    return CertificateInstallation(
      branches: (json['branches'] as List<dynamic>)
          .map((b) => Branch.fromJson(b))
          .toList(),
      consumer: Consumer.fromJson(json['consumer']),
    );
  }
}

class Branch {
  final String id;
  final String name;
  final String address;
  final Employee responseEmployee;
  final List<Certificate> certificates;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.responseEmployee,
    required this.certificates,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      responseEmployee: Employee.fromJson(json['responseEmployee']),
      certificates: (json['certificates'] as List<dynamic>)
          .map((c) => Certificate.fromJson(c))
          .toList(),
    );
  }
}

class Employee {
  final String id;
  final String fullName;

  Employee({required this.id, required this.fullName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(id: json['_id'], fullName: json['fullName']);
  }
}

class Certificate {
  final String file;
  final int createdAt;
  final ScheduleJob scheduleJob;

  Certificate({
    required this.file,
    required this.createdAt,
    required this.scheduleJob,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      file: json['file'],
      createdAt: json['createdAt'],
      scheduleJob: ScheduleJob.fromJson(json['scheduleJob']),
    );
  }
}

class ScheduleJob {
  final String requestNumber;
  final String type;

  ScheduleJob({required this.requestNumber, required this.type});

  factory ScheduleJob.fromJson(Map<String, dynamic> json) {
    return ScheduleJob(
      requestNumber: json['requestNumber'],
      type: json['type'],
    );
  }
}

class Consumer {
  final String id;
  final String name;

  Consumer({required this.id, required this.name});

  factory Consumer.fromJson(Map<String, dynamic> json) {
    return Consumer(id: json['_id'], name: json['name']);
  }
}
