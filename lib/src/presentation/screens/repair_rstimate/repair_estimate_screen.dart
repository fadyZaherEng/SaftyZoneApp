import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/permission_service_handler.dart';
import 'package:safety_zone/src/core/utils/show_action_dialog_widget.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/src/presentation/blocs/upload_doc/upload_doc_bloc.dart';
import 'package:safety_zone/src/presentation/screens/miantainance_offer/maintainance_offer_sreen.dart';
import 'package:safety_zone/src/presentation/widgets/custom_button_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';

class RepairEstimateScreen extends BaseStatefulWidget {
  final bool repairComplete;
  final Map<String, double> changeQuantity;
  final String maintenanceOffer;
  final String scheduleJob;
  final String consumerRequest;
  final String responsibleEmployee;
  final String maintainanceReportId;

  const RepairEstimateScreen({
    super.key,
    required this.repairComplete,
    required this.changeQuantity,
    required this.maintenanceOffer,
    required this.scheduleJob,
    required this.consumerRequest,
    required this.responsibleEmployee,
    required this.maintainanceReportId,
  });

  @override
  _RepairEstimateScreenState baseCreateState() => _RepairEstimateScreenState();
}

class _RepairEstimateScreenState extends BaseState<RepairEstimateScreen> {
  List<String> itemsSectionIcon = [];
  double emergencyExitValue = 0.0;
  bool needsParts = true;
  TextEditingController priceController = TextEditingController(text: "2000");
  List<String> itemsFirstSectionIcon = [];
  List<String> itemsSecondSectionIcon = [];
  List<String> items = [];
  List<String> itemsTitle = [];
  bool isYes = true;

  String? imageFile;
  String? finalPath;
  String? fileSize;

  UploadDocBloc get uploadDocBloc => BlocProvider.of<UploadDocBloc>(context);

  @override
  void initState() {
    itemsFirstSectionIcon = [
      ImagePaths.controlPanel,
      ImagePaths.smokeDetector,
      ImagePaths.alarmBell,
      ImagePaths.breakGlass,
      ImagePaths.lighting,
    ];
    itemsSecondSectionIcon = [
      ImagePaths.fireHydrant,
      ImagePaths.irrigation,
      ImagePaths.fireBox,
    ];
    items = [...itemsFirstSectionIcon, ...itemsSecondSectionIcon];
    super.initState();
    itemsSectionIcon = [
      ImagePaths.controlPanel,
      ImagePaths.smokeDetector,
      ImagePaths.alarmBell,
      ImagePaths.breakGlass,
      ImagePaths.lighting,
      ImagePaths.fireHydrant,
      ImagePaths.irrigation,
      ImagePaths.fireBox,
    ];
    emergencyExitValue = widget.changeQuantity['Emergency Exit'] ?? 0.0;
    widget.changeQuantity.removeWhere(
      (key, value) => key == 'Emergency Exit' || value == 0.0,
    );
  }

  String getSystemType(String item) {
    switch (item) {
      case 'Emergency Lighting':
        return S.of(context).emergency_lights;
      case 'glass breaker':
        return S.of(context).glass_breaker;
      case 'control panel':
        return S.of(context).control_panel;
      case 'alarm bell':
        return S.of(context).alarm_bell;
      case 'fire detector':
        return S.of(context).fireDetector;
      case 'Fire pumps':
        return S.of(context).fire_pumps;
      case 'Automatic Sprinklers':
        return S.of(context).autoSprinkler;
      case 'Fire Cabinets':
        return S.of(context).fireBoxes;
      default:
        return S.of(context).fireBoxes;
    }
  }

  Map<String, bool> generateFilteredItems() {
    return widget.changeQuantity.map((key, value) {
      final isEmergencyLighting = key == 'Emergency Lighting';
      final shouldShow = (!isEmergencyLighting && value > 0.0) ||
          (isEmergencyLighting && (value > 0.0 || emergencyExitValue > 0.0));

      return MapEntry(key, shouldShow);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    itemsTitle = [
      S.of(context).control_panel,
      S.of(context).fire_detector,
      S.of(context).alarm_bell,
      S.of(context).glass_breaker,
      S.of(context).emergency_lights,
      S.of(context).fire_pumps,
      S.of(context).warning_labels,
      S.of(context).fire_boxes,
    ];
  }

  @override
  Widget baseBuild(BuildContext context) {
    final t = S.of(context);
    return BlocConsumer<UploadDocBloc, UploadDocState>(
      listener: (context, state) {
        if (state is UploadDocSuccessState) {
          hideLoading();
          imageFile = state.url;
          finalPath = state.url;
          showSnackBar(
            context: context,
            message: state.url,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        } else if (state is UploadDocErrorState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        } else if (state is UploadDocDeleteSuccessState) {
          hideLoading();
          imageFile = null;
          showSnackBar(
            context: context,
            message: S.of(context).deletedSuccessfully,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
        } else if (state is UploadDocDeleteErrorState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.warning,
            icon: ImagePaths.error,
          );
        } else if (state is UploadDocApiSuccessState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: S.of(context).uploadDocumentSuccess,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorSchemes.primary,
            title: Text(t.system_repair_price),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.system_repair_price_title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  t.repair_description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  color: ColorSchemes.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSectionTitle(t.need_spare_parts),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                activeColor: ColorSchemes.primary,
                                title: Text(
                                  t.yes,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: needsParts == true
                                        ? ColorSchemes.primary
                                        : ColorSchemes.gray,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right, // جعل النص يمين
                                ),
                                value: true,
                                groupValue: needsParts,
                                onChanged: (val) {
                                  setState(() {
                                    needsParts = val!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                activeColor: ColorSchemes.primary,
                                title: Text(
                                  t.no,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: needsParts == false
                                        ? ColorSchemes.primary
                                        : ColorSchemes.gray,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right, // جعل النص يمين
                                ),
                                value: false,
                                groupValue: needsParts,
                                onChanged: (val) {
                                  setState(() {
                                    needsParts = val!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        if (needsParts) ...[
                          _buildInputField(
                            label: t.part_price,
                            path: "",
                            isReadOnly: false,
                            value: 2000,
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              _pickPDFFile();
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 1,
                                color: ColorSchemes.white,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                t.upload_invoice,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorSchemes.primary,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              SvgPicture.asset(
                                                ImagePaths.addProgress,
                                                height: 20.h,
                                                width: 20.w,
                                                color: ColorSchemes.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (widget.changeQuantity.isNotEmpty)
                  systemSection(
                    icon: ImagePaths.riskManagement,
                    items: generateFilteredItems(),
                  ),
                if (widget.changeQuantity.isEmpty) systemSectionNotChange(),
                const SizedBox(height: 20),
                if (widget.repairComplete) _buildPriceSection(),
                const SizedBox(height: 48),
                _buildNextButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required String label,
    required int value,
    required String path,
    required bool isReadOnly,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              SvgPicture.asset(
                path,
                height: 16.h,
                width: 16.w,
                color: ColorSchemes.black,
              ),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 34.h,
            child: TextFormField(
              controller: priceController,
              readOnly: isReadOnly,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
              onChanged: (value) {
                setState(() {
                  priceController.text = value;
                });
              },
              decoration: InputDecoration(
                fillColor: ColorSchemes.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Transform.rotate(
            angle: -pi / 2,
            child: SvgPicture.asset(
              ImagePaths.priceTag,
              width: 18,
              height: 18,
              color: ColorSchemes.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget systemSectionNotChange() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorSchemes.border.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (e) => Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            items[e.key],
                            width: 20,
                            height: 20,
                            color: widget.repairComplete
                                ? ColorSchemes.secondary
                                : ColorSchemes.gray,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            itemsTitle[e.key],
                            style: TextStyle(
                              fontSize: widget.repairComplete ? 16 : 14,
                              color: widget.repairComplete
                                  ? ColorSchemes.black
                                  : ColorSchemes.gray,
                            ),
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        ImagePaths.arrowLeft,
                        width: 24,
                        height: 24,
                        color: const Color(0xFF7B0000),
                      ),
                      leading: Icon(
                        widget.repairComplete ? Icons.check_box : Icons.warning,
                        color: widget.repairComplete
                            ? ColorSchemes.primary
                            : ColorSchemes.border,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
        ],
      ),
    );
  }

  Widget systemSection({
    required String icon,
    required Map<String, bool> items,
  }) {
    bool showSecondHeader = true;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...items.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            List<Widget> widgets = [];

            widgets.add(
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    SvgPicture.asset(
                      index < itemsSectionIcon.length
                          ? itemsSectionIcon[index]
                          : ImagePaths.error, // fallback icon
                      width: 20,
                      height: 20,
                      color: ColorSchemes.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(getSystemType(item.key),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                // trailing: SvgPicture.asset(
                //   ImagePaths.arrowLeft,
                //   width: 24,
                //   height: 24,
                //   color: const Color(0xFF7B0000),
                // ),
                leading: Icon(
                  !item.value ? Icons.check_box : Icons.warning,
                  color: !item.value
                      ? const Color(0xFF7B0000)
                      : ColorSchemes.border,
                ),
              ),
            );

            widgets.add(const Divider());

            return Column(children: widgets);
          }),
        ],
      ),
    );
  }

  final double materialCost = 1000;
  final double repairCost = 2000;
  final double installCost = 3000;
  final double tax = 500;

  _buildPriceSection() {
    double total = materialCost + repairCost + installCost + tax;

    final t = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: -pi / 2,
              child: SvgPicture.asset(
                ImagePaths.priceTag,
                width: 18,
                height: 18,
                color: ColorSchemes.secondary,
              ),
            ),
            SizedBox(width: 8),
            Text(t.total_after_report,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        _buildRow(t.materials_cost, materialCost),
        _buildRow(t.repair_cost, repairCost),
        _buildRow(t.installation_cost, installCost),
        _buildRow(t.tax, tax),
        Divider(),
        _buildRow(
          t.total,
          total,
          color: ColorSchemes.secondary,
          isBold: true,
          valueColor: ColorSchemes.primary,
        ),
        SizedBox(height: 16),
        CustomButtonWidget(
          text: t.confirm,
          backgroundColor: ColorSchemes.primary,
          textColor: ColorSchemes.white,
          onTap: () {},
        )
      ],
    );
  }

  Widget _buildRow(
    String label,
    double value, {
    Color? color,
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          Text(
            "${value.toInt()} ر.س",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _buildNextButton() {
    return CustomButtonWidget(
      text: S.of(context).next,
      backgroundColor: ColorSchemes.primary,
      textColor: ColorSchemes.white,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MaintainanceOfferScreen(
              consumerRequest: widget.consumerRequest,
              responsibleEmployee: widget.responsibleEmployee,
              maintenanceOffer: widget.maintenanceOffer,
              scheduleJob: widget.scheduleJob,
              maintainanceReportId: widget.maintainanceReportId,
              billURL: finalPath ?? "",
              itemSupplyPrice: priceController.text,
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickPDFFile() async {
    showLoading();
    if (await PermissionServiceHandler().handleServicePermission(
        setting: PermissionServiceHandler.getStorageFilesPermission(
      androidDeviceInfo:
          Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
    ))) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        final String filePath = result.files.single.path!;
        XFile imageFile = XFile(filePath);
        //ToDO: Save File
        fileSize = "${(await getFileSize(imageFile)).toStringAsFixed(2)} mb";
        // ToDO: Upload File in Server
        uploadDocBloc.add(UploadDocumentEvent(docPath: imageFile.path));
      }
    } else {
      hideLoading();
      _dialogMessage(
        icon: ImagePaths.warning,
        message: S.of(context).storagePermissionIsRequiredToProceed,
        primaryAction: () async {
          Navigator.pop(context);
          openAppSettings().then((value) async {});
        },
      );
    }
  }

  void _dialogMessage({
    required String message,
    required String icon,
    required Function() primaryAction,
    Function()? secondaryAction,
  }) {
    showActionDialogWidget(
      context: context,
      text: message,
      icon: icon,
      primaryText: S.of(context).ok,
      secondaryText: S.of(context).cancel,
      primaryAction: primaryAction,
      secondaryAction: () => secondaryAction ?? Navigator.pop(context),
    );
  }

  Future<double> getFileSize(XFile? imageFile) async {
    if (imageFile != null) {
      File file = File(imageFile.path);
      return await file.length() / 1024;
    }
    return 0;
  }
}
