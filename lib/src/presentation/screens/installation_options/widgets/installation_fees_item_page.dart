import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safety_zone/src/config/theme/color_schemes.dart';
import 'package:safety_zone/src/core/base/widget/base_stateful_widget.dart';
import 'package:safety_zone/src/core/resources/image_paths.dart';
import 'package:safety_zone/src/core/utils/show_snack_bar.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/data/sources/remote/safty_zone/home/request/request_bulk.dart';
import 'package:safety_zone/src/di/data_layer_injector.dart';
import 'package:safety_zone/src/domain/usecase/get_language_use_case.dart';
import 'package:safety_zone/src/presentation/blocs/home/home_bloc.dart';
import '../models/installation_fee_model.dart';
import '../services/installation_fee_service.dart';

class InstallationFeesApi {
  final Dio _dio;

  InstallationFeesApi(this._dio);

  /// Get installation fees for items
  Future<List<Map<String, dynamic>>> getInstallationFees({
    required String supCategory,
  }) async {
    try {
      final response = await _dio.get(
        '/api/provider/installation-fees/$supCategory',
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as List;
        return data.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to fetch installation fees');
      }
    } catch (e) {
      throw Exception('Error fetching installation fees: $e');
    }
  }

  Future<Map<String, dynamic>> updateInstallationFees({
    required List<Map<String, dynamic>> updates,
  }) async {
    try {
      final response = await _dio.put(
        '/api/provider/installation-fees/update-prices',
        data: {"updates": updates},
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update installation fees');
      }
    } catch (e) {
      throw Exception('Error updating installation fees: $e');
    }
  }
}

class InstallationFeesItemPage extends BaseStatefulWidget {
  final SystemComponent component;
  final List<Map<String, dynamic>> items;
  final bool isLoading;
  final VoidCallback onNext;
  final bool isLastPage;
  final String systemComponentCode;
  final bool isUpdateMode;

  const InstallationFeesItemPage({
    super.key,
    required this.component,
    required this.items,
    required this.isLoading,
    required this.onNext,
    required this.isLastPage,
    required this.systemComponentCode,
    this.isUpdateMode = false,
  });

  @override
  BaseState<InstallationFeesItemPage> baseCreateState() =>
      _InstallationFeesItemPageState();
}

class _InstallationFeesItemPageState
    extends BaseState<InstallationFeesItemPage> {
  final Map<String, List<TextEditingController>> _priceControllers = {};
  final Map<String, bool> _isExpanded = {};
  final Map<String, bool> _isSelected = {};
  final Map<String, bool> _isSaving = {};
  final InstallationFeeService _installationFeeService =
      InstallationFeeService();

  HomeBloc get _homeBloc => BlocProvider.of<HomeBloc>(context);
  final api = InstallationFeesApi(injector<Dio>());

  List<Map<String, dynamic>> fees = [];

  void loadFees() async {
    try {
      fees = await api.getInstallationFees(
        supCategory: widget.component.code,
      );
      print("Installation Fees: $fees");
    } catch (e) {
      print("Error: $e");
    }
    setState(() {});
  }

  @override
  void initState() {
    loadFees();
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
  void didUpdateWidget(covariant InstallationFeesItemPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      loadFees();
    }
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is InstallationFeeBulkLoadingState) {
          showLoading();
        } else if (state is InstallationFeeBulkSuccessState) {
          setState(() {
            _isSelected.forEach((key, _) {
              _isSelected[key] = true;
            });
            _isExpanded.forEach((key, _) {
              _isExpanded[key] = false;
            });
          });
          showSnackBar(
            context: context,
            message: S.of(context).allInstallationFeesSavedSuccessfully,
            color: ColorSchemes.success,
            icon: ImagePaths.success,
          );
          hideLoading();
          widget.onNext();
        } else if (state is InstallationFeeBulkErrorState) {
          hideLoading();
          showSnackBar(
            context: context,
            message: state.message,
            color: Colors.red,
            icon: ImagePaths.error,
          );
        } else if (state is InstallationFeeTempState) {
          // Update local state based on temporary fees
          setState(() {
            state.fees.forEach((id, price) {
              final controllers = _priceControllers[id];
              if (controllers != null && controllers.isNotEmpty) {
                controllers[0].text = price.toString();
                _isSelected[id] = true;
              }
            });
          });
        }
      },
      builder: (context, state) {
        if (fees.isEmpty) {
          return const Center(
              child: SpinKitDoubleBounce(color: Color(0xFF8B0000)));
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    onPressed: _hasValidPrices()
                        ? () => widget.isUpdateMode
                            ? _updateAllInstallationFees()
                            : _saveAllInstallationFees()
                        : null,
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
      },
    );
  }

  @override
  void dispose() {
    for (var controllers in _priceControllers.values) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _initializeControllers() {
    Map<String, String> savedFees = {};
    if (_homeBloc.state is InstallationFeeTempState) {
      savedFees = (_homeBloc.state as InstallationFeeTempState).fees;
    }

    for (var item in widget.items) {
      final id = (item['id'] ?? item['_id'])?.toString() ?? '';
      if (id.isEmpty) continue;

      if (!_priceControllers.containsKey(id)) {
        final controller = TextEditingController();
        if (savedFees.containsKey(id)) {
          controller.text = savedFees[id] ?? '';
        }
        _priceControllers[id] = [controller];
        _isExpanded[id] = false;
        _isSelected[id] = savedFees.containsKey(id);
        _isSaving[id] = false;
      }
    }
    setState(() {});
  }

  Future<void> _saveItemInController(Map<String, dynamic> item) async {
    final id = (item['id'] ?? item['_id'])?.toString() ?? '';
    if (id.isEmpty) {
      debugPrint('No controllers found for item: $id');
      _isSelected[id] = false;
      _isSaving[id] = false;
      _priceControllers[id] = [TextEditingController()];
      setState(() {});
      return;
    }
    final controllers = _priceControllers[id];
    if (controllers == null || controllers.isEmpty) {
      debugPrint('No controllers found for item: $id');
      _isSelected[id] = false;
      _isSaving[id] = false;
      _priceControllers[id] = [TextEditingController()];
      setState(() {});
      return;
    }

    final priceText = controllers[0].text.trim();
    if (priceText.isEmpty) {
      debugPrint('No controllers found for item: $id');
      _isSelected[id] = false;
      _isSaving[id] = false;
      _priceControllers[id] = [TextEditingController()];
      setState(() {});
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

    setState(() {
      _isSelected[id] = true;
    });
  }

  Future<void> _saveAllInstallationFees() async {
    final List<InstallationFees> feesList = [];
    debugPrint('Saving all installation fees...');

    _priceControllers.forEach((id, controllers) {
      if (controllers.isNotEmpty) {
        debugPrint('Saving installation fee for item: $id');
        final priceText = controllers[0].text.trim();
        final price = double.tryParse(priceText);
        if (price != null && price > 0) {
          feesList.add(InstallationFees(item: id, price: price.toInt()));
        }
      }
    });

    if (feesList.isEmpty) {
      showSnackBar(
        context: context,
        message: S.of(context).enterValidPriceForAllItems,
        color: Colors.red,
        icon: ImagePaths.error,
      );
      return;
    }

    debugPrint('Saving installation fees: $feesList');
    try {
      final requestBulk = RequestBulk(installationFees: feesList);

      _homeBloc.add(InstallationFeeBulkEvent(request: requestBulk));
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Error: ${e.toString()}',
        color: Colors.red,
        icon: ImagePaths.error,
      );
    }
  }

  Future<void> _updateAllInstallationFees() async {
    final List<Map<String, dynamic>> updates = [];

    for (final fee in fees) {
      final outerId = fee['_id']?.toString() ?? ''; // الـ id الخارجي
      final innerId = fee['item']?['_id']?.toString() ?? '';

      // هات الكنترولر بالـ innerId
      final controllers = _priceControllers[innerId];
      if (controllers != null && controllers.isNotEmpty) {
        final priceText = controllers[0].text.trim();
        final newPrice = double.tryParse(priceText);

        if (newPrice != null && newPrice > 0) {
          final oldPrice = (fee['price'] ?? 0).toDouble();

          // الشرط هنا بيشيك على الاتنين (السعر + الـ id)
          if (newPrice != oldPrice &&
              fee['item']?['_id']?.toString() == innerId) {
            updates.add({"_id": outerId, "price": newPrice.toInt()});
          }
        }
      }
    }

    if (updates.isEmpty) {
      // showSnackBar(
      //   context: context,
      //   message: "No changes detected",
      //   color: Colors.orange,
      //   icon: ImagePaths.warning,
      // );
      // return;
      widget.onNext(); // move to next page
      return;
    }

    try {
      showLoading();
      final result = await api.updateInstallationFees(updates: updates);
      hideLoading();

      if (result["success"] == true) {
        showSnackBar(
          context: context,
          message: result["message"] ?? "Updated successfully",
          color: ColorSchemes.success,
          icon: ImagePaths.success,
        );
        widget.onNext(); // move to next page
      } else {
        showSnackBar(
          context: context,
          message: result["message"] ?? "Failed to update",
          color: Colors.red,
          icon: ImagePaths.error,
        );
      }
    } catch (e) {
      hideLoading();
      showSnackBar(
        context: context,
        message: 'Error: $e',
        color: Colors.red,
        icon: ImagePaths.error,
      );
    }
  }

  bool _hasValidPrices() {
    // لو مفيش عناصر، نسمح يكمل عادي
    if (widget.items.isEmpty) {
      return true;
    }

    // لازم كل العناصر يكون لها سعر صحيح ومتخزن
    for (var id in _priceControllers.keys) {
      final controllers = _priceControllers[id];
      if (controllers == null || controllers.isEmpty) return false;

      final priceText = controllers[0].text.trim();
      final price = double.tryParse(priceText);
      if (price == null || price <= 0) return false;
    }
    return true;
  }

  void _toggleExpanded(String? itemId) {
    if (itemId == null || itemId.isEmpty) return;
    setState(() {
      _isExpanded[itemId] = !(_isExpanded[itemId] ?? false);
    });
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
        //TODO: Update price from fees if available
        // ✅ Update price from API fees if available
        print("lengthhhhhhhhhhhhhhhhhhhhhhhhhhhh ${fees.length}");
        final feeData = fees.cast<Map<String, dynamic>>().firstWhere(
              (fee) =>
                  fee['item'] != null &&
                  (fee['item']['_id']?.toString() ?? '') == id,
              orElse: () => <String, dynamic>{},
            );
        if (feeData.isNotEmpty && controllers.isNotEmpty) {
          final feePrice = (feeData['price'] ?? 0).toString();
          if (feePrice.isNotEmpty &&
              feePrice != '0' &&
              controllers[0].text.isEmpty) {
            controllers[0].text = feePrice;
            _isSelected[id] = true;
          }
        }
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => _toggleExpanded(id),
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50)
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
                          (GetLanguageUseCase(injector())() == 'en'
                              ? item['itemName']['en']
                              : item['itemName']['ar']),
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
                                      if (value.isEmpty) return;
                                      setState(() {});
                                      _saveItemInController(item);

                                      final id = (item['id'] ?? item['_id'])
                                              ?.toString() ??
                                          '';
                                      if (value.isNotEmpty) {
                                        _homeBloc.add(
                                            SaveTemporaryInstallationFeeEvent(
                                          id: id,
                                          price: value, // نخزن String مش double
                                        ));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
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
                                        ? controllers[0]
                                        : null,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
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
                                      if (value.isEmpty) return;
                                      setState(() {}); // Refresh button state
                                      _saveItemInController(item);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 16.h),
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
