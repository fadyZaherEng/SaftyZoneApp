import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatif_mobile/config/theme/color_schemes.dart';
import 'package:hatif_mobile/core/resources/image_paths.dart';
import 'package:hatif_mobile/core/utils/show_snack_bar.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import '../models/installation_fee_model.dart';
import '../services/installation_fee_service.dart';

class InstallationFeesItemPage extends StatefulWidget {
  final SystemComponent component;
  final List<Map<String, dynamic>> items;
  final bool isLoading;
  final VoidCallback onNext;
  final bool isLastPage;

  const InstallationFeesItemPage({
    super.key,
    required this.component,
    required this.items,
    required this.isLoading,
    required this.onNext,
    required this.isLastPage,
  });

  @override
  State<InstallationFeesItemPage> createState() =>
      _InstallationFeesItemPageState();
}

class _InstallationFeesItemPageState extends State<InstallationFeesItemPage> {
  final Map<String, List<TextEditingController>> _priceControllers = {};
  final Map<String, bool> _isExpanded = {};
  final Map<String, bool> _isSelected = {};
  final Map<String, bool> _isSaving = {}; // Track saving state per item
  final InstallationFeeService _installationFeeService =
      InstallationFeeService();

  @override
  void initState() {
    super.initState();
    _initializeControllers();

    // If there are no items, auto-advance after a short delay
    if (widget.items.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          widget.onNext();
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controllers in _priceControllers.values) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _initializeControllers() {
    for (var item in widget.items) {
      final id = (item['id'] ?? item['_id'])?.toString() ?? '';
      if (id.isEmpty) continue;
      _priceControllers[id] = [TextEditingController()];
      _isExpanded[id] = false;
      _isSelected[id] = false;
      _isSaving[id] = false;
    }
  }

  Future<void> _saveItemInstallationFee(Map<String, dynamic> item) async {
    final id = (item['id'] ?? item['_id'])?.toString() ?? '';
    if (id.isEmpty) return;
    final controllers = _priceControllers[id];
    if (controllers == null || controllers.isEmpty) return;

    final priceText = controllers[0].text.trim();
    if (priceText.isEmpty) {
      showSnackBar(
        context: context,
        message: S.of(context).enterValidPrice,
        color: Colors.red,
        icon: ImagePaths.error,
      );
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      showSnackBar(
        context: context,
        message: S.of(context).enterValidPrice,
        color: Colors.red,
        icon: ImagePaths.error,
      );

      return;
    }

    setState(() {
      _isSaving[id] = true;
    });

    try {
      final result =
          await _installationFeeService.saveItemInstallationFeeDirect(
        itemId: id,
        price: [price],
        isComplete: true,
      );
      debugPrint('Saving installation fee result: $result');
      if (result['success'] == true) {
        setState(() {
          _isSelected[id] = true;
          _isExpanded[id] = false;
        });
        showSnackBar(
          context: context,
          message: S.of(context).installationFeeSavedSuccessfully,
          color: ColorSchemes.success,
          icon: ImagePaths.success,
        );
      } else {
        showSnackBar(
          context: context,
          message: result['message'] ?? 'Failed to save installation fee',
          color: Colors.red,
          icon: ImagePaths.error,
        );
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Error: ${e.toString()}',
        color: Colors.red,
        icon: ImagePaths.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving[id] = false;
        });
      }
    }
  }

  bool _hasValidPrices() {
    // If there are no items, allow proceeding to next page
    if (widget.items.isEmpty) {
      return true;
    }

    // Check if at least one item is selected
    bool hasSelected = _isSelected.values.any((selected) => selected);
    return hasSelected;
  }

  void _toggleExpanded(String? itemId) {
    if (itemId == null || itemId.isEmpty) return;
    setState(() {
      _isExpanded[itemId] = !(_isExpanded[itemId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with instructions (removed icon as requested)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).enterInstallationCost,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  S.of(context).installationFeeBasedOnType,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Content area
            Expanded(
              child: widget.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF8B0000),
                      ),
                    )
                  : widget.items.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 48.sp,
                                color: const Color(0xFF888888),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                S.of(context).noItemsFound,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF888888),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                S.of(context).autoAdvancingIn2Seconds,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF8B0000),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              const CircularProgressIndicator(
                                color: Color(0xFF8B0000),
                                strokeWidth: 2,
                              ),
                            ],
                          ),
                        )
                      : _buildItemsList(),
            ),

            // Next Button
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: _hasValidPrices() ? widget.onNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasValidPrices()
                      ? const Color(0xFF8B0000)
                      : const Color(0xFFCCCCCC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  widget.items.isEmpty
                      ? S.of(context).next
                      : widget.isLastPage
                          ? S.of(context).finish
                          : S.of(context).next,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final id = (item['id'] ?? item['_id'])?.toString() ?? '';
        final isSelected = _isSelected[id] ?? false;
        final isExpanded = _isExpanded[id] ?? false;
        final controllers = _priceControllers[id] ?? [];

        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              // Main item row with checkbox
              InkWell(
                onTap: () => _toggleExpanded(id),
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      // Checkbox - show saved state but allow interaction
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(
                                    0xFF4CAF50) // Green for saved items
                                : Colors.transparent,
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: const Color(0xFFCCCCCC),
                                    width: 2,
                                  ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16.w,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 16.w),

                      // Item name
                      Expanded(
                        child: Text(
                          (item['itemName'] ?? '') +
                              ((item['subCategory'] != null &&
                                      (item['subCategory'] as String)
                                          .isNotEmpty)
                                  ? ' (${item['subCategory']})'
                                  : ''),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF222222),
                          ),
                        ),
                      ),

                      // Dropdown arrow
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFF8B0000),
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),
              ),

              // Expandable content
              if (isExpanded) ...[
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Conditional display based on alarmType
                      if (item['alarmType'] == "loop") ...[
                        // Show only Addressed Installation Fee for loop type
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/price-down.svg',
                              width: 24.w,
                              height: 24.w,
                              color: const Color(0xFF8B0000),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).addressedInstallationFee,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF8B0000),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextField(
                                    controller: controllers.isNotEmpty
                                        ? controllers[
                                            0] // Use first controller for addressed fee when alarmType is loop
                                        : null,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      hintText: 'ex. 50 R.S',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xFFCCCCCC),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFE0E0E0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF8B0000)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 12.h),
                                    ),
                                    onChanged: (value) {
                                      setState(() {}); // Refresh button state
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        // Show only Standard Installation Fee for other types
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/price-down.svg',
                              width: 24.w,
                              height: 24.w,
                              color: const Color(0xFF2196F3),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).standardInstallationFee,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF2196F3),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextField(
                                    controller: controllers.isNotEmpty
                                        ? controllers[
                                            0] // Use first controller for standard fee when alarmType is not loop
                                        : null,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      hintText: 'ex. 30 R.S',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xFFCCCCCC),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFE0E0E0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2196F3)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 12.h),
                                    ),
                                    onChanged: (value) {
                                      setState(() {}); // Refresh button state
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      SizedBox(height: 16.h),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Clear prices
                              if (controllers.isNotEmpty) {
                                controllers[0].clear();
                              }
                              setState(() {});
                            },
                            child: Text(
                              S.of(context).edit,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          ElevatedButton(
                            onPressed: _isSaving[id] == true
                                ? null // Disable button while saving
                                : () => _saveItemInstallationFee(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isSelected[id] == true
                                  ? const Color(0xFF4CAF50) // Green when saved
                                  : const Color(0xFF8B0000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 8.h),
                            ),
                            child: _isSaving[id] == true
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _isSelected[id] == true
                                        ? S
                                            .of(context)
                                            .update // Show "Update" for saved items
                                        : S.of(context).save,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
