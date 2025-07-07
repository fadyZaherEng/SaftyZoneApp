import 'package:flutter/material.dart';
import 'package:hatif_mobile/generated/l10n.dart';
import 'package:hatif_mobile/presentation/screens/installation_options/models/installation_fee_model.dart';

class InstallationFeeProvider extends ChangeNotifier {
  // Component selection state
  final Map<String, bool> _selectedComponents = {};
  final Map<String, TextEditingController> _componentFeeControllers = {};
  final Map<String, String> _componentNotes = {};
  SystemType? _currentSystemType;
  bool _isSubmitting = false;

  // Track selected system types and their completion status
  List<SystemType> _selectedSystemTypes = [];
  final Map<SystemType, bool> _systemCompletionStatus = {};

  // Getters
  Map<String, bool> get selectedComponents => _selectedComponents;
  Map<String, TextEditingController> get componentFeeControllers =>
      _componentFeeControllers;
  Map<String, String> get componentNotes => _componentNotes;
  SystemType? get currentSystemType => _currentSystemType;
  bool get isSubmitting => _isSubmitting;
  List<SystemType> get selectedSystemTypes => _selectedSystemTypes;
  Map<SystemType, bool> get systemCompletionStatus => _systemCompletionStatus;

  // System components definition
  final Map<SystemType, List<SystemComponent>> systemComponents = {
    SystemType.earlyWarning: [
      SystemComponent(
          code: 'control panel',
          id: 'controlPanel',
          name: 'controlPanel',
          icon: "control_panel"),
      SystemComponent(
          code: 'fire detector',
          id: 'fireDetector',
          name: 'fireDetector',
          icon: "fire_detector"),
      SystemComponent(
          code: 'alarm bell',
          id: 'alarmBell',
          name: 'alarmBell',
          icon: "alarm_bell"),
      SystemComponent(
          code: 'Emergency Lighting',
          id: 'emergencyLighting',
          name: 'emergencyLighting',
          icon: "lighting"),
      SystemComponent(
          code: 'Emergency Exit',
          id: 'emergencyExit',
          name: 'emergencyExit',
          icon: "emergency_exit"),
    ],
    SystemType.fireSuppression: [
      SystemComponent(
          code: 'Fire pumps',
          id: 'firePumps',
          name: 'firePumps',
          icon: "fire_pump"),
      SystemComponent(
          code: "Automatic Sprinklers",
          id: 'automaticSprinklers',
          name: 'automaticSprinklers',
          icon: "water_sprinkler"),
      SystemComponent(
          code: 'Fire Cabinets',
          id: 'fireCabinets',
          name: 'fireCabinets',
          icon: "fire_cabinet"),
      SystemComponent(
          code: 'Fire extinguisher maintenance',
          id: 'fireExtinguisherMaintenance',
          name: 'fireExtinguisherMaintenance',
          icon: "fire_extinguisher"),
    ],
  };

  // Initialize provider with selected systems
  void initialize(List<SystemType> selectedSystems) {
    _selectedSystemTypes = selectedSystems;

    // Initialize completion status for each system
    for (final systemType in selectedSystems) {
      _systemCompletionStatus[systemType] = false;
      initializeComponentControllers(systemType);
    }

    // Set the first system as current for the detail view
    if (selectedSystems.isNotEmpty) {
      _currentSystemType = selectedSystems.first;
    }
  }

  // Set current system type and initialize its components
  void setCurrentSystemType(SystemType systemType) {
    _currentSystemType = systemType;
    initializeComponentControllers(systemType);
    notifyListeners();
  }

  // Get next system type based on current selection
  SystemType? getNextSystemType() {
    if (_currentSystemType == null || _selectedSystemTypes.isEmpty) return null;

    final currentIndex = _selectedSystemTypes.indexOf(_currentSystemType!);
    if (currentIndex >= 0 && currentIndex < _selectedSystemTypes.length - 1) {
      return _selectedSystemTypes[currentIndex + 1];
    }
    return null;
  }

  // Mark current system as completed
  void markCurrentSystemAsCompleted() {
    if (_currentSystemType != null) {
      _systemCompletionStatus[_currentSystemType!] = true;
      notifyListeners();
    }
  }

  // Check if all systems are completed
  bool areAllSystemsCompleted() {
    return _selectedSystemTypes
        .every((systemType) => _systemCompletionStatus[systemType] == true);
  }

  // Initialize controllers for components of a system type
  void initializeComponentControllers(SystemType systemType) {
    final components = systemComponents[systemType] ?? [];
    for (var component in components) {
      _selectedComponents[component.id] = false;
      _componentFeeControllers[component.id] = TextEditingController();
    }
  }

  // Update component selection
  void updateComponentSelection(String componentId, bool isSelected) {
    _selectedComponents[componentId] = isSelected;
    notifyListeners();
  }

  // Update component fee and notes
  void updateComponentFee(String componentId, String fee, String? notes) {
    _selectedComponents[componentId] = true;
    _componentFeeControllers[componentId]?.text = fee;
    if (notes != null) {
      _componentNotes[componentId] = notes;
    }
    notifyListeners();
  }

  // Check if any components are selected
  bool hasSelectedComponents() {
    return _selectedComponents.values.any((isSelected) => isSelected);
  }

  // Set submission state
  void setSubmitting(bool isSubmitting) {
    _isSubmitting = isSubmitting;
    notifyListeners();
  }

  // Get selected component fees
  Map<String, double> getSelectedComponentFees() {
    final Map<String, double> selectedComponentFees = {};

    _selectedComponents.forEach((componentId, isSelected) {
      if (isSelected) {
        final fee =
            double.tryParse(_componentFeeControllers[componentId]?.text ?? '0');
        if (fee != null) {
          selectedComponentFees[componentId] = fee;
        }
      }
    });

    return selectedComponentFees;
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _componentFeeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Get system name based on type
  String getSystemName(SystemType type) {
    switch (type) {
      case SystemType.earlyWarning:
        return S.current.earlyWarningSystemFees;
      case SystemType.fireSuppression:
        return S.current.fireSuppressionSystemFees;
    }
  }
  String getSystemComponentNameLocalized(String id, BuildContext context) {
    debugPrint('id: $id');
    switch (id) {
      case 'controlPanel':
        return S.of(context).controlPanel;
      case 'fireDetector':
        return S.of(context).fireDetector;
      case 'alarmBell':
        return S.of(context).alarmBell;
      case 'emergencyLighting':
        return S.of(context).emergencyLighting;
      case 'emergencyExit':
        return S.of(context).emergencyExit;
      case 'firePumps':
        return S.of(context).firePumps;
      case 'automaticSprinklers':
        return S.of(context).automaticSprinklers;
      case 'fireCabinets':
        return S.of(context).fireCabinets;
      case 'fireExtinguisherMaintenance':
        return S.of(context).fireExtinguisherMaintenance;
      case 'glassBreaker':
        return S.of(context).glassBreaker;
      default:
        return '';
    }
  }

}
