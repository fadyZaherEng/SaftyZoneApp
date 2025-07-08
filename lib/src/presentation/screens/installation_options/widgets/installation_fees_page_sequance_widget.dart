import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safety_zone/generated/l10n.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/providers/installation_fee_provider.dart';
import 'package:safety_zone/src/presentation/screens/installation_options/widgets/installation_fees_item_page.dart';
import '../models/installation_fee_model.dart';
import '../services/installation_fee_service.dart';

class InstallationFeesPageSequanceWidget extends StatefulWidget {
  final List<SystemComponent> components;
  final String systemName;
  final SystemType systemType;
  final List<SystemType> selectedSystems;

  const InstallationFeesPageSequanceWidget({
    super.key,
    required this.components,
    required this.systemName,
    required this.systemType,
    required this.selectedSystems,
  });

  @override
  State<InstallationFeesPageSequanceWidget> createState() =>
      _InstallationFeesPageSequanceWidgetState();
}

class _InstallationFeesPageSequanceWidgetState
    extends State<InstallationFeesPageSequanceWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  final Map<String, List<Map<String, dynamic>>> _componentItems = {};
  final Map<String, bool> _isLoading = {};
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeComponentData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeComponentData() async {
    final service = InstallationFeeService();

    for (final component in widget.components) {
      _isLoading[component.id] = true;
      try {
        final result = await service.getInstallationFeesBySystemComponent(
            component.code, widget.systemType.name);
        if (result['success']) {
          final items = (result['data'] as List).cast<Map<String, dynamic>>();
          _componentItems[component.id] = items;

          // If no items found, log and mark as empty
          if (items.isEmpty) {
            print(
                'No installation fees found for component: ${component.name} (${component.code})');
          }
        } else {
          _componentItems[component.id] = [];
          print(
              'Failed to fetch installation fees for component: ${component.name} - ${result['message']}');
        }
      } catch (e) {
        _componentItems[component.id] = [];
        print(
            'Exception fetching installation fees for component: ${component.name} - ${e.toString()}');
      }
      _isLoading[component.id] = false;
    }
    if (mounted) {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _goToNextPage() {
    if (_currentPage < widget.components.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _handleSystemCompletion();
    }
  }

  void _handleSystemCompletion() async {
    final currentIndex = widget.selectedSystems.indexOf(widget.systemType);

    if (currentIndex >= 0 && currentIndex < widget.selectedSystems.length - 1) {
      final nextSystemType = widget.selectedSystems[currentIndex + 1];
      final provider = InstallationFeeProvider();
      provider.initialize(widget.selectedSystems);

      if (!mounted) return;

      // Get components for the next system
      final nextComponents = provider.systemComponents[nextSystemType] ?? [];
      final nextSystemName = provider.getSystemName(nextSystemType);

      // Navigate to the next system's page view
      final result = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InstallationFeesPageSequanceWidget(
            components: nextComponents,
            systemName: nextSystemName,
            systemType: nextSystemType,
            selectedSystems: widget.selectedSystems,
          ),
        ),
      );

      // If the next system is also completed, return success
      if (result == true && mounted) {
        Navigator.pop(context, true);
      }
    } else {
      // All systems completed, return to previous screen with success status
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = InstallationFeeProvider();
    if (_isInitializing) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.systemName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF8B0000),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _currentPage < widget.components.length
              ? provider.getSystemComponentNameLocalized(
                  widget.components[_currentPage].id, context)
              : widget.systemName,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goToPreviousPage,
          padding: EdgeInsets.all(12.w),
          constraints: BoxConstraints(minWidth: 44.w, minHeight: 44.w),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(16.w),
            color: Colors.white,
            child: Column(
              children: [
                // Progress bar
                Row(
                  children: List.generate(
                    widget.components.length,
                    (index) => Expanded(
                      child: Container(
                        height: 4.h,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: index <= _currentPage
                              ? const Color(0xFF8B0000)
                              : const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Progress text
                Text(
                  '${_currentPage + 1} ${S.of(context).ofs} ${widget.components.length}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),

          // Page view
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              // Disable scrolling
              itemCount: widget.components.length,
              itemBuilder: (context, index) {
                final component = widget.components[index];
                final items = _componentItems[component.id] ?? [];
                final isLoading = _isLoading[component.id] ?? false;

                return InstallationFeesItemPage(
                  component: component,
                  items: items,
                  isLoading: isLoading,
                  onNext: _goToNextPage,
                  isLastPage: index == widget.components.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
