// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Remember me`
  String get rememberme {
    return Intl.message('Remember me', name: 'rememberme', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotpassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get usernameoremail {
    return Intl.message(
      'Username or Email',
      name: 'usernameoremail',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message('Sign in', name: 'signin', desc: '', args: []);
  }

  /// `Sign in with QR`
  String get signinqr {
    return Intl.message(
      'Sign in with QR',
      name: 'signinqr',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Dial`
  String get dial {
    return Intl.message('Dial', name: 'dial', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Select your preferred language`
  String get selectLanguage {
    return Intl.message(
      'Select your preferred language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Register as New Vendor`
  String get registerAsNewVendor {
    return Intl.message(
      'Register as New Vendor',
      name: 'registerAsNewVendor',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Welcome to Safety Zone`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to Safety Zone',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your trusted partner for security and safety solutions`
  String get welcomeSubtitle {
    return Intl.message(
      'Your trusted partner for security and safety solutions',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Professional Services`
  String get professionalTitle {
    return Intl.message(
      'Professional Services',
      name: 'professionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Access professional security services anytime, anywhere`
  String get professionalSubtitle {
    return Intl.message(
      'Access professional security services anytime, anywhere',
      name: 'professionalSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Easy Management`
  String get easyTitle {
    return Intl.message(
      'Easy Management',
      name: 'easyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage your security needs with our intuitive interface`
  String get easySubtitle {
    return Intl.message(
      'Manage your security needs with our intuitive interface',
      name: 'easySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Vendor Registration`
  String get vendorRegistrationHeadline {
    return Intl.message(
      'Vendor Registration',
      name: 'vendorRegistrationHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in your company details to register as a vendor`
  String get vendorRegistrationSubheadline {
    return Intl.message(
      'Please fill in your company details to register as a vendor',
      name: 'vendorRegistrationSubheadline',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyNameLabel {
    return Intl.message(
      'Company Name',
      name: 'companyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the official name of your company as it appears in legal documents`
  String get companyNameHint {
    return Intl.message(
      'Enter the official name of your company as it appears in legal documents',
      name: 'companyNameHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Modern Trade Solutions Co.`
  String get companyNamePlaceholder {
    return Intl.message(
      'e.g. Modern Trade Solutions Co.',
      name: 'companyNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Company name is required`
  String get companyNameRequired {
    return Intl.message(
      'Company name is required',
      name: 'companyNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration No.`
  String get crNumberLabel {
    return Intl.message(
      'Commercial Registration No.',
      name: 'crNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Provide the Commercial Registration (CR) Number issued by your country's regulatory authority`
  String get crNumberHint {
    return Intl.message(
      'Provide the Commercial Registration (CR) Number issued by your country\'s regulatory authority',
      name: 'crNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your CR number`
  String get crNumberPlaceholder {
    return Intl.message(
      'Enter your CR number',
      name: 'crNumberPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration number is required`
  String get crNumberRequired {
    return Intl.message(
      'Commercial Registration number is required',
      name: 'crNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Enter a valid business email address where we can reach you`
  String get emailHint {
    return Intl.message(
      'Enter a valid business email address where we can reach you',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. info@yourcompany.com`
  String get emailPlaceholder {
    return Intl.message(
      'e.g. info@yourcompany.com',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get emailInvalid {
    return Intl.message(
      'Please enter a valid email address',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneLabel {
    return Intl.message('Phone Number', name: 'phoneLabel', desc: '', args: []);
  }

  /// `Enter an active phone number associated with your business`
  String get phoneHint {
    return Intl.message(
      'Enter an active phone number associated with your business',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Include country code if international`
  String get phonePlaceholder {
    return Intl.message(
      'Include country code if international',
      name: 'phonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Company Activity`
  String get companyActivityLabel {
    return Intl.message(
      'Company Activity',
      name: 'companyActivityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe the type of business you operate or the services/products you offer`
  String get companyActivityHint {
    return Intl.message(
      'Describe the type of business you operate or the services/products you offer',
      name: 'companyActivityHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Wholesale of electronic devices`
  String get companyActivityPlaceholder {
    return Intl.message(
      'e.g. Wholesale of electronic devices',
      name: 'companyActivityPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Company activity description is required`
  String get companyActivityRequired {
    return Intl.message(
      'Company activity description is required',
      name: 'companyActivityRequired',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get locationLabel {
    return Intl.message('Location', name: 'locationLabel', desc: '', args: []);
  }

  /// `Type your full address or drop a pin on the map to indicate where your company is located`
  String get locationHint {
    return Intl.message(
      'Type your full address or drop a pin on the map to indicate where your company is located',
      name: 'locationHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your company address`
  String get locationPlaceholder {
    return Intl.message(
      'Enter your company address',
      name: 'locationPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Location is required`
  String get locationRequired {
    return Intl.message(
      'Location is required',
      name: 'locationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select Location on Map`
  String get selectLocationOnMap {
    return Intl.message(
      'Select Location on Map',
      name: 'selectLocationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Pin on Map`
  String get pinOnMap {
    return Intl.message('Pin on Map', name: 'pinOnMap', desc: '', args: []);
  }

  /// `I confirm the information entered is accurate and up to date`
  String get confirmInformation {
    return Intl.message(
      'I confirm the information entered is accurate and up to date',
      name: 'confirmInformation',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the`
  String get iAgreeToThe {
    return Intl.message(
      'I agree to the',
      name: 'iAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `By registering as a vendor:\n\n• You agree to provide accurate business details.\n• You confirm that your company is legally registered.\n• You agree not to misuse the platform or engage in fraudulent activities.\n• Your data will be used for verification and communication purposes only.\n• You accept that the platform may contact you regarding vendor-related matters.`
  String get termsAndConditionsText {
    return Intl.message(
      'By registering as a vendor:\n\n• You agree to provide accurate business details.\n• You confirm that your company is legally registered.\n• You agree not to misuse the platform or engage in fraudulent activities.\n• Your data will be used for verification and communication purposes only.\n• You accept that the platform may contact you regarding vendor-related matters.',
      name: 'termsAndConditionsText',
      desc: '',
      args: [],
    );
  }

  /// `Submit Registration`
  String get submitRegistration {
    return Intl.message(
      'Submit Registration',
      name: 'submitRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm that the information is accurate`
  String get pleaseConfirmInformation {
    return Intl.message(
      'Please confirm that the information is accurate',
      name: 'pleaseConfirmInformation',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to the terms and conditions`
  String get pleaseAgreeToTerms {
    return Intl.message(
      'Please agree to the terms and conditions',
      name: 'pleaseAgreeToTerms',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp Number`
  String get whatsappNumberLabel {
    return Intl.message(
      'WhatsApp Number',
      name: 'whatsappNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter WhatsApp number`
  String get whatsappNumberPlaceholder {
    return Intl.message(
      'Enter WhatsApp number',
      name: 'whatsappNumberPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp number is required`
  String get whatsappNumberRequired {
    return Intl.message(
      'WhatsApp number is required',
      name: 'whatsappNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration Expiry Date`
  String get crExpiryDateLabel {
    return Intl.message(
      'Commercial Registration Expiry Date',
      name: 'crExpiryDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Civil Defense Permit Expiry Date`
  String get civilDefenseExpiryDateLabel {
    return Intl.message(
      'Civil Defense Permit Expiry Date',
      name: 'civilDefenseExpiryDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Upload`
  String get uploadDocument {
    return Intl.message('Upload', name: 'uploadDocument', desc: '', args: []);
  }

  /// `Uploaded`
  String get documentUploaded {
    return Intl.message(
      'Uploaded',
      name: 'documentUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration expiry date is required`
  String get crExpiryDateRequired {
    return Intl.message(
      'Commercial Registration expiry date is required',
      name: 'crExpiryDateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration document is required`
  String get crDocumentRequired {
    return Intl.message(
      'Commercial Registration document is required',
      name: 'crDocumentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Civil Defense permit expiry date is required`
  String get civilDefenseExpiryDateRequired {
    return Intl.message(
      'Civil Defense permit expiry date is required',
      name: 'civilDefenseExpiryDateRequired',
      desc: '',
      args: [],
    );
  }

  /// `Civil Defense permit document is required`
  String get civilDefenseDocumentRequired {
    return Intl.message(
      'Civil Defense permit document is required',
      name: 'civilDefenseDocumentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Name`
  String get bankAccountNameLabel {
    return Intl.message(
      'Bank Account Name',
      name: 'bankAccountNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter bank account name`
  String get bankAccountNamePlaceholder {
    return Intl.message(
      'Enter bank account name',
      name: 'bankAccountNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Bank account name is required`
  String get bankAccountNameRequired {
    return Intl.message(
      'Bank account name is required',
      name: 'bankAccountNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account Number`
  String get bankAccountNumberLabel {
    return Intl.message(
      'Bank Account Number',
      name: 'bankAccountNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter bank account number`
  String get bankAccountNumberPlaceholder {
    return Intl.message(
      'Enter bank account number',
      name: 'bankAccountNumberPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Bank account number is required`
  String get bankAccountNumberRequired {
    return Intl.message(
      'Bank account number is required',
      name: 'bankAccountNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Your Company registration has been successfully completed.`
  String get registrationSuccessTitle {
    return Intl.message(
      'Your Company registration has been successfully completed.',
      name: 'registrationSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can log in and complete your information so you can receive customer requests.`
  String get registrationSuccessMessage {
    return Intl.message(
      'You can log in and complete your information so you can receive customer requests.',
      name: 'registrationSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Complete My Information`
  String get completeInformation {
    return Intl.message(
      'Complete My Information',
      name: 'completeInformation',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Add installation fees`
  String get addInstallationFees {
    return Intl.message(
      'Add installation fees',
      name: 'addInstallationFees',
      desc: '',
      args: [],
    );
  }

  /// `Enter Safety System Fees`
  String get enterSafetySystemFees {
    return Intl.message(
      'Enter Safety System Fees',
      name: 'enterSafetySystemFees',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the specific fees for each system to accurately calculate the service cost.`
  String get feeDescriptionText {
    return Intl.message(
      'Please enter the specific fees for each system to accurately calculate the service cost.',
      name: 'feeDescriptionText',
      desc: '',
      args: [],
    );
  }

  /// `Add employees`
  String get addEmployees {
    return Intl.message(
      'Add employees',
      name: 'addEmployees',
      desc: '',
      args: [],
    );
  }

  /// `Receive Requests`
  String get receiveRequests {
    return Intl.message(
      'Receive Requests',
      name: 'receiveRequests',
      desc: '',
      args: [],
    );
  }

  /// `You cannot receive requests until they are completed.`
  String get cannotReceiveRequestsMessage {
    return Intl.message(
      'You cannot receive requests until they are completed.',
      name: 'cannotReceiveRequestsMessage',
      desc: '',
      args: [],
    );
  }

  /// `You `
  String get youCannot {
    return Intl.message('You ', name: 'youCannot', desc: '', args: []);
  }

  /// `cannot receive requests`
  String get receiveRequestsHighlight {
    return Intl.message(
      'cannot receive requests',
      name: 'receiveRequestsHighlight',
      desc: '',
      args: [],
    );
  }

  /// ` until they are completed.`
  String get untilCompleted {
    return Intl.message(
      ' until they are completed.',
      name: 'untilCompleted',
      desc: '',
      args: [],
    );
  }

  /// `New registration as a service provider`
  String get newProviderRegistration {
    return Intl.message(
      'New registration as a service provider',
      name: 'newProviderRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message('Continue', name: 'continues', desc: '', args: []);
  }

  /// `Back to Home`
  String get backToHome {
    return Intl.message('Back to Home', name: 'backToHome', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `New registration as a`
  String get newRegistrationAs {
    return Intl.message(
      'New registration as a',
      name: 'newRegistrationAs',
      desc: '',
      args: [],
    );
  }

  /// `service provider`
  String get serviceProvider {
    return Intl.message(
      'service provider',
      name: 'serviceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message('Error', name: 'errorTitle', desc: '', args: []);
  }

  /// `Route not found!`
  String get routeNotFound {
    return Intl.message(
      'Route not found!',
      name: 'routeNotFound',
      desc: '',
      args: [],
    );
  }

  /// `{value}%`
  String progressPercentage(Object value) {
    return Intl.message(
      '$value%',
      name: 'progressPercentage',
      desc: '',
      args: [value],
    );
  }

  /// `Early Warning System Fees`
  String get earlyWarningSystemFees {
    return Intl.message(
      'Early Warning System Fees',
      name: 'earlyWarningSystemFees',
      desc: '',
      args: [],
    );
  }

  /// `Fire Suppression System Fees`
  String get fireSuppressionSystemFees {
    return Intl.message(
      'Fire Suppression System Fees',
      name: 'fireSuppressionSystemFees',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a scanned copy of the document`
  String get uploadDocumentHint {
    return Intl.message(
      'Please upload a scanned copy of the document',
      name: 'uploadDocumentHint',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get changeDocument {
    return Intl.message('Change', name: 'changeDocument', desc: '', args: []);
  }

  /// `Document Preview`
  String get documentPreview {
    return Intl.message(
      'Document Preview',
      name: 'documentPreview',
      desc: '',
      args: [],
    );
  }

  /// `Failed to select image. Please try again.`
  String get imagePickError {
    return Intl.message(
      'Failed to select image. Please try again.',
      name: 'imagePickError',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Password length must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number and one special character.`
  String get passwordLengthRequirement {
    return Intl.message(
      'Password length must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number and one special character.',
      name: 'passwordLengthRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one lowercase letter`
  String get lowercaseRequirement {
    return Intl.message(
      'At least one lowercase letter',
      name: 'lowercaseRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one uppercase letter`
  String get uppercaseRequirement {
    return Intl.message(
      'At least one uppercase letter',
      name: 'uppercaseRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one digit`
  String get digitRequirement {
    return Intl.message(
      'At least one digit',
      name: 'digitRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one special character (!@#$%^&*_=+-)`
  String get specialCharacterRequirement {
    return Intl.message(
      'At least one special character (!@#\$%^&*_=+-)',
      name: 'specialCharacterRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the new password and confirm password do not match.`
  String get sorryTheNewPasswordAndConfirmPasswordDoNotMatch {
    return Intl.message(
      'Sorry, the new password and confirm password do not match.',
      name: 'sorryTheNewPasswordAndConfirmPasswordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `The new password must be different from the previous password`
  String get theNewPasswordMustBeDifferentFromThePreviousPassword {
    return Intl.message(
      'The new password must be different from the previous password',
      name: 'theNewPasswordMustBeDifferentFromThePreviousPassword',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `No internet connection found. Check your connection and try again.`
  String get noInternetConnectionFoundCheckYourConnection {
    return Intl.message(
      'No internet connection found. Check your connection and try again.',
      name: 'noInternetConnectionFoundCheckYourConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Opps!!`
  String get opps {
    return Intl.message('Opps!!', name: 'opps', desc: '', args: []);
  }

  /// `Location permission denied. Please enable location permission in settings to use this feature.`
  String get locationPermissionDenied {
    return Intl.message(
      'Location permission denied. Please enable location permission in settings to use this feature.',
      name: 'locationPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Location permission permanently denied. Please enable location permission in settings to use this feature.`
  String get locationPermissionPermanentlyDenied {
    return Intl.message(
      'Location permission permanently denied. Please enable location permission in settings to use this feature.',
      name: 'locationPermissionPermanentlyDenied',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get current location. Please try again.`
  String get locationError {
    return Intl.message(
      'Failed to get current location. Please try again.',
      name: 'locationError',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select location`
  String get tapToSelectLocation {
    return Intl.message(
      'Tap to select location',
      name: 'tapToSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Locate Me`
  String get locateMe {
    return Intl.message('Locate Me', name: 'locateMe', desc: '', args: []);
  }

  /// `Confirm Location`
  String get confirmLocation {
    return Intl.message(
      'Confirm Location',
      name: 'confirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Selected Location`
  String get selectedLocation {
    return Intl.message(
      'Selected Location',
      name: 'selectedLocation',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message('Login', name: 'loginTitle', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login below`
  String get loginBelow {
    return Intl.message('Login below', name: 'loginBelow', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Selected Country`
  String get selectedCountry {
    return Intl.message(
      'Selected Country',
      name: 'selectedCountry',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudiArabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Egypt`
  String get egypt {
    return Intl.message('Egypt', name: 'egypt', desc: '', args: []);
  }

  /// `UAE`
  String get uae {
    return Intl.message('UAE', name: 'uae', desc: '', args: []);
  }

  /// `WhatsApp Number`
  String get whatsappNumber {
    return Intl.message(
      'WhatsApp Number',
      name: 'whatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter WhatsApp Number`
  String get enterWhatsappNumber {
    return Intl.message(
      'Enter WhatsApp Number',
      name: 'enterWhatsappNumber',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCode {
    return Intl.message('Verify Code', name: 'verifyCode', desc: '', args: []);
  }

  /// `Enter the verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter the verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to`
  String get codeSentTo {
    return Intl.message('Code sent to', name: 'codeSentTo', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Resend code in`
  String get resendCodeIn {
    return Intl.message(
      'Resend code in',
      name: 'resendCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `OTP resent successfully`
  String get otpResent {
    return Intl.message(
      'OTP resent successfully',
      name: 'otpResent',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification successful`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Select from gallery`
  String get selectFromGallery {
    return Intl.message(
      'Select from gallery',
      name: 'selectFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get takePhoto {
    return Intl.message('Take photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Bad response. Please check your connection and try again.`
  String get badResponse {
    return Intl.message(
      'Bad response. Please check your connection and try again.',
      name: 'badResponse',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Bank account name must be alphabetical`
  String get bankAccountNameAlphabetical {
    return Intl.message(
      'Bank account name must be alphabetical',
      name: 'bankAccountNameAlphabetical',
      desc: '',
      args: [],
    );
  }

  /// `Location selected successfully`
  String get locationSelected {
    return Intl.message(
      'Location selected successfully',
      name: 'locationSelected',
      desc: '',
      args: [],
    );
  }

  /// `Location services disabled. Please enable location services in settings to use this feature.`
  String get locationServicesDisabled {
    return Intl.message(
      'Location services disabled. Please enable location services in settings to use this feature.',
      name: 'locationServicesDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Upload media from gallery`
  String get uploadMediaGallery {
    return Intl.message(
      'Upload media from gallery',
      name: 'uploadMediaGallery',
      desc: '',
      args: [],
    );
  }

  /// `Upload media`
  String get uploadMedia {
    return Intl.message(
      'Upload media',
      name: 'uploadMedia',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `You should have camera permission to use this feature.`
  String get youShouldHaveCameraPermission {
    return Intl.message(
      'You should have camera permission to use this feature.',
      name: 'youShouldHaveCameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Please enter specific fees for each system to accurately calculate the service cost.`
  String get pleaseEnterSpecificFees {
    return Intl.message(
      'Please enter specific fees for each system to accurately calculate the service cost.',
      name: 'pleaseEnterSpecificFees',
      desc: '',
      args: [],
    );
  }

  /// `Installation fees saved successfully.`
  String get installationFeeSaved {
    return Intl.message(
      'Installation fees saved successfully.',
      name: 'installationFeeSaved',
      desc: '',
      args: [],
    );
  }

  /// `Control Panel`
  String get controlPanel {
    return Intl.message(
      'Control Panel',
      name: 'controlPanel',
      desc: '',
      args: [],
    );
  }

  /// `Fire Detector`
  String get fireDetector {
    return Intl.message(
      'Fire Detector',
      name: 'fireDetector',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Bell`
  String get alarmBell {
    return Intl.message('Alarm Bell', name: 'alarmBell', desc: '', args: []);
  }

  /// `Emergency Lighting`
  String get emergencyLighting {
    return Intl.message(
      'Emergency Lighting',
      name: 'emergencyLighting',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Exit`
  String get emergencyExit {
    return Intl.message(
      'Emergency Exit',
      name: 'emergencyExit',
      desc: '',
      args: [],
    );
  }

  /// `Fire Pumps`
  String get firePumps {
    return Intl.message('Fire Pumps', name: 'firePumps', desc: '', args: []);
  }

  /// `Automatic Sprinklers`
  String get automaticSprinklers {
    return Intl.message(
      'Automatic Sprinklers',
      name: 'automaticSprinklers',
      desc: '',
      args: [],
    );
  }

  /// `Fire Cabinets`
  String get fireCabinets {
    return Intl.message(
      'Fire Cabinets',
      name: 'fireCabinets',
      desc: '',
      args: [],
    );
  }

  /// `Fire Extinguisher Maintenance`
  String get fireExtinguisherMaintenance {
    return Intl.message(
      'Fire Extinguisher Maintenance',
      name: 'fireExtinguisherMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Glass Breaker`
  String get glassBreaker {
    return Intl.message(
      'Glass Breaker',
      name: 'glassBreaker',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get ofs {
    return Intl.message('of', name: 'ofs', desc: '', args: []);
  }

  /// `Please enter a valid price.`
  String get enterValidPrice {
    return Intl.message(
      'Please enter a valid price.',
      name: 'enterValidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Installation fee saved successfully.`
  String get installationFeeSavedSuccessfully {
    return Intl.message(
      'Installation fee saved successfully.',
      name: 'installationFeeSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Installation fee based on type.`
  String get installationFeeBasedOnType {
    return Intl.message(
      'Installation fee based on type.',
      name: 'installationFeeBasedOnType',
      desc: '',
      args: [],
    );
  }

  /// `Enter installation cost`
  String get enterInstallationCost {
    return Intl.message(
      'Enter installation cost',
      name: 'enterInstallationCost',
      desc: '',
      args: [],
    );
  }

  /// `No items found`
  String get noItemsFound {
    return Intl.message(
      'No items found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Addressed installation fee`
  String get addressedInstallationFee {
    return Intl.message(
      'Addressed installation fee',
      name: 'addressedInstallationFee',
      desc: '',
      args: [],
    );
  }

  /// `Standard installation fee`
  String get standardInstallationFee {
    return Intl.message(
      'Standard installation fee',
      name: 'standardInstallationFee',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Installation Fees`
  String get installationFees {
    return Intl.message(
      'Installation Fees',
      name: 'installationFees',
      desc: '',
      args: [],
    );
  }

  /// `Enter installation prices`
  String get enterInstallationPrices {
    return Intl.message(
      'Enter installation prices',
      name: 'enterInstallationPrices',
      desc: '',
      args: [],
    );
  }

  /// `Installation materials price`
  String get installationMaterialsPrice {
    return Intl.message(
      'Installation materials price',
      name: 'installationMaterialsPrice',
      desc: '',
      args: [],
    );
  }

  /// `No components selected`
  String get noComponentsSelected {
    return Intl.message(
      'No components selected',
      name: 'noComponentsSelected',
      desc: '',
      args: [],
    );
  }

  /// `Component details`
  String get componentDetails {
    return Intl.message(
      'Component details',
      name: 'componentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select components`
  String get selectComponents {
    return Intl.message(
      'Select components',
      name: 'selectComponents',
      desc: '',
      args: [],
    );
  }

  /// `Enter amount`
  String get enterAmount {
    return Intl.message(
      'Enter amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Fee amount`
  String get feeAmount {
    return Intl.message('Fee amount', name: 'feeAmount', desc: '', args: []);
  }

  /// `Enter component fee`
  String get enterComponentFee {
    return Intl.message(
      'Enter component fee',
      name: 'enterComponentFee',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Optional notes`
  String get optionalNotes {
    return Intl.message(
      'Optional notes',
      name: 'optionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Search about your location`
  String get searchAboutYourLocation {
    return Intl.message(
      'Search about your location',
      name: 'searchAboutYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Cost of normal system`
  String get costOfNormalSystem {
    return Intl.message(
      'Cost of normal system',
      name: 'costOfNormalSystem',
      desc: '',
      args: [],
    );
  }

  /// `Cost of monitored system`
  String get costOfMonitoredSystem {
    return Intl.message(
      'Cost of monitored system',
      name: 'costOfMonitoredSystem',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message('Saturday', name: 'saturday', desc: '', args: []);
  }

  /// `Sunday`
  String get sunday {
    return Intl.message('Sunday', name: 'sunday', desc: '', args: []);
  }

  /// `Monday`
  String get monday {
    return Intl.message('Monday', name: 'monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get thursday {
    return Intl.message('Thursday', name: 'thursday', desc: '', args: []);
  }

  /// `Friday`
  String get friday {
    return Intl.message('Friday', name: 'friday', desc: '', args: []);
  }

  /// `If the employee fails to provide the requirements for the job, the contract will be terminated.`
  String
  get ifTheEmployeeFailsToProvideTheRequirementsForTheJobTheContractWillBeTerminated {
    return Intl.message(
      'If the employee fails to provide the requirements for the job, the contract will be terminated.',
      name:
          'ifTheEmployeeFailsToProvideTheRequirementsForTheJobTheContractWillBeTerminated',
      desc: '',
      args: [],
    );
  }

  /// `You should provide an exit plan before 30 days.`
  String get youShouldProvideAnExitPlanBefore30Days {
    return Intl.message(
      'You should provide an exit plan before 30 days.',
      name: 'youShouldProvideAnExitPlanBefore30Days',
      desc: '',
      args: [],
    );
  }

  /// `The employee should keep their data secure and not share any sensitive information.`
  String
  get theEmployeeShouldKeepTheirDataSecureAndNotShareAnySensitiveInformation {
    return Intl.message(
      'The employee should keep their data secure and not share any sensitive information.',
      name:
          'theEmployeeShouldKeepTheirDataSecureAndNotShareAnySensitiveInformation',
      desc: '',
      args: [],
    );
  }

  /// `Responsible Contractor`
  String get responsibleContractors {
    return Intl.message(
      'Responsible Contractor',
      name: 'responsibleContractors',
      desc: '',
      args: [],
    );
  }

  /// `Responsible Employee`
  String get responsibleEmployee {
    return Intl.message(
      'Responsible Employee',
      name: 'responsibleEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Contract Signature`
  String get contractSignature {
    return Intl.message(
      'Contract Signature',
      name: 'contractSignature',
      desc: '',
      args: [],
    );
  }

  /// `Contract Terms`
  String get contractTerms {
    return Intl.message(
      'Contract Terms',
      name: 'contractTerms',
      desc: '',
      args: [],
    );
  }

  /// `Enter responsible employee and contract signature`
  String get enterResponsibleEmployeeAndContractSignature {
    return Intl.message(
      'Enter responsible employee and contract signature',
      name: 'enterResponsibleEmployeeAndContractSignature',
      desc: '',
      args: [],
    );
  }

  /// `Add other term`
  String get addOtherTerm {
    return Intl.message(
      'Add other term',
      name: 'addOtherTerm',
      desc: '',
      args: [],
    );
  }

  /// `Select days and working hours`
  String get selectDaysAndWorkingHours {
    return Intl.message(
      'Select days and working hours',
      name: 'selectDaysAndWorkingHours',
      desc: '',
      args: [],
    );
  }

  /// `Conditions of the contract`
  String get conditionsOfTheContract {
    return Intl.message(
      'Conditions of the contract',
      name: 'conditionsOfTheContract',
      desc: '',
      args: [],
    );
  }

  /// `Create Employee Profile`
  String get createEmployeeProfile {
    return Intl.message(
      'Create Employee Profile',
      name: 'createEmployeeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Start adding a new employee by completing the required details`
  String get startAddingNewEmployeeByCompletingTheRequiredDetails {
    return Intl.message(
      'Start adding a new employee by completing the required details',
      name: 'startAddingNewEmployeeByCompletingTheRequiredDetails',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basicInformation {
    return Intl.message(
      'Basic Information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Assign Job Role`
  String get assignJobRole {
    return Intl.message(
      'Assign Job Role',
      name: 'assignJobRole',
      desc: '',
      args: [],
    );
  }

  /// `Review & Confirm`
  String get reviewAndConfirm {
    return Intl.message(
      'Review & Confirm',
      name: 'reviewAndConfirm',
      desc: '',
      args: [],
    );
  }

  /// `First Safety`
  String get firstSafety {
    return Intl.message(
      'First Safety',
      name: 'firstSafety',
      desc: '',
      args: [],
    );
  }

  /// `Site Management`
  String get siteManagement {
    return Intl.message(
      'Site Management',
      name: 'siteManagement',
      desc: '',
      args: [],
    );
  }

  /// `First Aid`
  String get firstAid {
    return Intl.message('First Aid', name: 'firstAid', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Maintenance`
  String get maintenance {
    return Intl.message('Maintenance', name: 'maintenance', desc: '', args: []);
  }

  /// `Training`
  String get training {
    return Intl.message('Training', name: 'training', desc: '', args: []);
  }

  /// `Functional Title`
  String get functionalTitle {
    return Intl.message(
      'Functional Title',
      name: 'functionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `e.g, Site Manager`
  String get egSiteManager {
    return Intl.message(
      'e.g, Site Manager',
      name: 'egSiteManager',
      desc: '',
      args: [],
    );
  }

  /// `Select Tasks`
  String get selectTasks {
    return Intl.message(
      'Select Tasks',
      name: 'selectTasks',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Add Another Employee`
  String get addAnotherEmployee {
    return Intl.message(
      'Add Another Employee',
      name: 'addAnotherEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Jop Title`
  String get jopTitle {
    return Intl.message('Jop Title', name: 'jopTitle', desc: '', args: []);
  }

  /// `Invalid phone number`
  String get inValidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'inValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a clear photo of the employee. JPG, PNG, max 2MB.`
  String get pleaseUploadAClearPhotoOfTheEmployeeASJPGPNGMax2MB {
    return Intl.message(
      'Please upload a clear photo of the employee. JPG, PNG, max 2MB.',
      name: 'pleaseUploadAClearPhotoOfTheEmployeeASJPGPNGMax2MB',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Saving`
  String get saving {
    return Intl.message('Saving', name: 'saving', desc: '', args: []);
  }

  /// `Save Employee`
  String get saveEmployee {
    return Intl.message(
      'Save Employee',
      name: 'saveEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Employee saved successfully`
  String get employeeSavedSuccessfully {
    return Intl.message(
      'Employee saved successfully',
      name: 'employeeSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Auto-advancing in 2 seconds...`
  String get autoAdvancingIn2Seconds {
    return Intl.message(
      'Auto-advancing in 2 seconds...',
      name: 'autoAdvancingIn2Seconds',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Failed to save, please try again`
  String get failedToSave {
    return Intl.message(
      'Failed to save, please try again',
      name: 'failedToSave',
      desc: '',
      args: [],
    );
  }

  /// `Select Employee`
  String get selectEmployee {
    return Intl.message(
      'Select Employee',
      name: 'selectEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Enter Term`
  String get enterTerm {
    return Intl.message('Enter Term', name: 'enterTerm', desc: '', args: []);
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Select Working Hours`
  String get selectWorkingHours {
    return Intl.message(
      'Select Working Hours',
      name: 'selectWorkingHours',
      desc: '',
      args: [],
    );
  }

  /// `No employees found`
  String get noEmployeesFound {
    return Intl.message(
      'No employees found',
      name: 'noEmployeesFound',
      desc: '',
      args: [],
    );
  }

  /// `Start adding employees`
  String get startAddingEmployee {
    return Intl.message(
      'Start adding employees',
      name: 'startAddingEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Enter your notes`
  String get enterYourNotes {
    return Intl.message(
      'Enter your notes',
      name: 'enterYourNotes',
      desc: '',
      args: [],
    );
  }

  /// `Functional Title (Role)`
  String get functionalTitleRole {
    return Intl.message(
      'Functional Title (Role)',
      name: 'functionalTitleRole',
      desc: '',
      args: [],
    );
  }

  /// `e.g, Site Manager`
  String get functionalTitleHint {
    return Intl.message(
      'e.g, Site Manager',
      name: 'functionalTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Task Selection`
  String get tasksSelection {
    return Intl.message(
      'Task Selection',
      name: 'tasksSelection',
      desc: '',
      args: [],
    );
  }

  /// `Enter your notes here ...`
  String get notesHint {
    return Intl.message(
      'Enter your notes here ...',
      name: 'notesHint',
      desc: '',
      args: [],
    );
  }

  /// `System Administrator`
  String get systemAdministrator {
    return Intl.message(
      'System Administrator',
      name: 'systemAdministrator',
      desc: '',
      args: [],
    );
  }

  /// `Contract Signing`
  String get contractSigning {
    return Intl.message(
      'Contract Signing',
      name: 'contractSigning',
      desc: '',
      args: [],
    );
  }

  /// `Quotation Submission`
  String get quotationSubmission {
    return Intl.message(
      'Quotation Submission',
      name: 'quotationSubmission',
      desc: '',
      args: [],
    );
  }

  /// `Report Writing`
  String get reportWriting {
    return Intl.message(
      'Report Writing',
      name: 'reportWriting',
      desc: '',
      args: [],
    );
  }

  /// `Enter Full Name`
  String get enterFullName {
    return Intl.message(
      'Enter Full Name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Jop Title`
  String get enterJopTitle {
    return Intl.message(
      'Enter Jop Title',
      name: 'enterJopTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a clear personal photo of yourself for employee registration purposes. JPG, PNG, max 2MB`
  String
  get pleaseUploadAClearPersonalPhotoOfYourselfForEmployeeRegistrationPurposesJPGPNGMax2MB {
    return Intl.message(
      'Please upload a clear personal photo of yourself for employee registration purposes. JPG, PNG, max 2MB',
      name:
          'pleaseUploadAClearPersonalPhotoOfYourselfForEmployeeRegistrationPurposesJPGPNGMax2MB',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter Phone Number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Your information has been sent for review`
  String get yourInformationHasBeenSentForReview {
    return Intl.message(
      'Your information has been sent for review',
      name: 'yourInformationHasBeenSentForReview',
      desc: '',
      args: [],
    );
  }

  /// `You will receive an email after accepting or declining your details in case of any errors`
  String
  get youWillReceiveAnEmailAfterAcceptingOrDecliningYourDetailsInCaseOfAnyErrors {
    return Intl.message(
      'You will receive an email after accepting or declining your details in case of any errors',
      name:
          'youWillReceiveAnEmailAfterAcceptingOrDecliningYourDetailsInCaseOfAnyErrors',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `Maintainance`
  String get maintainance {
    return Intl.message(
      'Maintainance',
      name: 'maintainance',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Contracts List`
  String get contractList {
    return Intl.message(
      'Contracts List',
      name: 'contractList',
      desc: '',
      args: [],
    );
  }

  /// `Prices Need Escalation`
  String get pricesNeedEscalation {
    return Intl.message(
      'Prices Need Escalation',
      name: 'pricesNeedEscalation',
      desc: '',
      args: [],
    );
  }

  /// `Installation Tasks`
  String get installationTasks {
    return Intl.message(
      'Installation Tasks',
      name: 'installationTasks',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get employees {
    return Intl.message('Employees', name: 'employees', desc: '', args: []);
  }

  /// `Messages`
  String get messages {
    return Intl.message('Messages', name: 'messages', desc: '', args: []);
  }

  /// `Reports`
  String get reports {
    return Intl.message('Reports', name: 'reports', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `System Manager`
  String get systemManager {
    return Intl.message(
      'System Manager',
      name: 'systemManager',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Your Requests Service`
  String get requestServiceTitle {
    return Intl.message(
      'Your Requests Service',
      name: 'requestServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage and track all service requests easily from customer partners.`
  String get requestServiceSubtitle {
    return Intl.message(
      'Manage and track all service requests easily from customer partners.',
      name: 'requestServiceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter what you want to search for...`
  String get searchHint {
    return Intl.message(
      'Enter what you want to search for...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Pending Approval`
  String get pendingApproval {
    return Intl.message(
      'Pending Approval',
      name: 'pendingApproval',
      desc: '',
      args: [],
    );
  }

  /// `Send Price Offer`
  String get sendPriceOffer {
    return Intl.message(
      'Send Price Offer',
      name: 'sendPriceOffer',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Recently`
  String get recently {
    return Intl.message('Recently', name: 'recently', desc: '', args: []);
  }

  /// `Information completed successfully`
  String get informationCompletedSuccessfully {
    return Intl.message(
      'Information completed successfully',
      name: 'informationCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Fawry Service`
  String get fawryService {
    return Intl.message(
      'Fawry Service',
      name: 'fawryService',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Track your daily tasks and stay updated with reports and notifications in one place.`
  String get dailyTasksSubtitle {
    return Intl.message(
      'Track your daily tasks and stay updated with reports and notifications in one place.',
      name: 'dailyTasksSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New Requests`
  String get newRequests {
    return Intl.message(
      'New Requests',
      name: 'newRequests',
      desc: '',
      args: [],
    );
  }

  /// `Reports need maintenance`
  String get maintenanceReports {
    return Intl.message(
      'Reports need maintenance',
      name: 'maintenanceReports',
      desc: '',
      args: [],
    );
  }

  /// `Pending Requests`
  String get pendingRequests {
    return Intl.message(
      'Pending Requests',
      name: 'pendingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Price Offers Awaiting Approval`
  String get priceOffers {
    return Intl.message(
      'Price Offers Awaiting Approval',
      name: 'priceOffers',
      desc: '',
      args: [],
    );
  }

  /// `Today’s Scheduled Tasks`
  String get todayTasks {
    return Intl.message(
      'Today’s Scheduled Tasks',
      name: 'todayTasks',
      desc: '',
      args: [],
    );
  }

  /// `Activity Type`
  String get activityType {
    return Intl.message(
      'Activity Type',
      name: 'activityType',
      desc: '',
      args: [],
    );
  }

  /// `Location on the Map`
  String get locationOnMap {
    return Intl.message(
      'Location on the Map',
      name: 'locationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Open Map`
  String get openMap {
    return Intl.message('Open Map', name: 'openMap', desc: '', args: []);
  }

  /// `Site Info`
  String get siteInfo {
    return Intl.message('Site Info', name: 'siteInfo', desc: '', args: []);
  }

  /// `Quantities Table`
  String get quantitiesTable {
    return Intl.message(
      'Quantities Table',
      name: 'quantitiesTable',
      desc: '',
      args: [],
    );
  }

  /// `System Type`
  String get systemType {
    return Intl.message('System Type', name: 'systemType', desc: '', args: []);
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Alarm Items:`
  String get alarmItems {
    return Intl.message('Alarm Items:', name: 'alarmItems', desc: '', args: []);
  }

  /// `Backup Lighting`
  String get backupLighting {
    return Intl.message(
      'Backup Lighting',
      name: 'backupLighting',
      desc: '',
      args: [],
    );
  }

  /// `Extinguishing Items:`
  String get extinguishingItems {
    return Intl.message(
      'Extinguishing Items:',
      name: 'extinguishingItems',
      desc: '',
      args: [],
    );
  }

  /// `Auto Sprinkler`
  String get autoSprinkler {
    return Intl.message(
      'Auto Sprinkler',
      name: 'autoSprinkler',
      desc: '',
      args: [],
    );
  }

  /// `Fire Box`
  String get fireBox {
    return Intl.message('Fire Box', name: 'fireBox', desc: '', args: []);
  }

  /// `Fire Extinguishers:`
  String get fireExtinguishers {
    return Intl.message(
      'Fire Extinguishers:',
      name: 'fireExtinguishers',
      desc: '',
      args: [],
    );
  }

  /// `Fire Extinguisher 6kg Powder`
  String get extinguisher6KgPowder {
    return Intl.message(
      'Fire Extinguisher 6kg Powder',
      name: 'extinguisher6KgPowder',
      desc: '',
      args: [],
    );
  }

  /// `Fire Extinguisher 12kg Powder`
  String get extinguisher12KgPowder {
    return Intl.message(
      'Fire Extinguisher 12kg Powder',
      name: 'extinguisher12KgPowder',
      desc: '',
      args: [],
    );
  }

  /// `CO2 Fire Extinguisher`
  String get extinguisherCO2 {
    return Intl.message(
      'CO2 Fire Extinguisher',
      name: 'extinguisherCO2',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditionsTitle {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type of Activity`
  String get typeOfActivity {
    return Intl.message(
      'Type of Activity',
      name: 'typeOfActivity',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Authorized Signature (Client)`
  String get authorizedSignature {
    return Intl.message(
      'Authorized Signature (Client)',
      name: 'authorizedSignature',
      desc: '',
      args: [],
    );
  }

  /// `Technician Responsible for Installing the Equipment`
  String get technicianResponsibleForInstallingTheEquipment {
    return Intl.message(
      'Technician Responsible for Installing the Equipment',
      name: 'technicianResponsibleForInstallingTheEquipment',
      desc: '',
      args: [],
    );
  }

  /// `Submit a Price Offer for Instant Permit Issuance`
  String get submitAPriceOfferForInstantPermitIssuance {
    return Intl.message(
      'Submit a Price Offer for Instant Permit Issuance',
      name: 'submitAPriceOfferForInstantPermitIssuance',
      desc: '',
      args: [],
    );
  }

  /// `Instant Permit Issuance Fee`
  String get instantPermitIssuanceFee {
    return Intl.message(
      'Instant Permit Issuance Fee',
      name: 'instantPermitIssuanceFee',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Stay informed about current site visits, assigned technicians, maintenance tasks, and pending reports to ensure smooth service execution`
  String get stayInformed {
    return Intl.message(
      'Stay informed about current site visits, assigned technicians, maintenance tasks, and pending reports to ensure smooth service execution',
      name: 'stayInformed',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance In Progress`
  String get maintenanceInProgress {
    return Intl.message(
      'Maintenance In Progress',
      name: 'maintenanceInProgress',
      desc: '',
      args: [],
    );
  }

  /// `View more information (Urgent request)`
  String get viewMoreInfo {
    return Intl.message(
      'View more information (Urgent request)',
      name: 'viewMoreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Visit Date`
  String get visitDate {
    return Intl.message('Visit Date', name: 'visitDate', desc: '', args: []);
  }

  /// `Upload Instant License Document`
  String get uploadLicenseDoc {
    return Intl.message(
      'Upload Instant License Document',
      name: 'uploadLicenseDoc',
      desc: '',
      args: [],
    );
  }

  /// `Instant License`
  String get instantLicense {
    return Intl.message(
      'Instant License',
      name: 'instantLicense',
      desc: '',
      args: [],
    );
  }

  /// `Engineering Report`
  String get engineeringReport {
    return Intl.message(
      'Engineering Report',
      name: 'engineeringReport',
      desc: '',
      args: [],
    );
  }

  /// `Go to Location`
  String get goToLocation {
    return Intl.message(
      'Go to Location',
      name: 'goToLocation',
      desc: '',
      args: [],
    );
  }

  /// `Generate Report`
  String get generateReport {
    return Intl.message(
      'Generate Report',
      name: 'generateReport',
      desc: '',
      args: [],
    );
  }

  /// `Receive Fire Extinguishers`
  String get receiveExtinguishers {
    return Intl.message(
      'Receive Fire Extinguishers',
      name: 'receiveExtinguishers',
      desc: '',
      args: [],
    );
  }

  /// `Submit Quotation`
  String get submitQuotation {
    return Intl.message(
      'Submit Quotation',
      name: 'submitQuotation',
      desc: '',
      args: [],
    );
  }

  /// `Deliver Fire Extinguishers`
  String get deliverExtinguishers {
    return Intl.message(
      'Deliver Fire Extinguishers',
      name: 'deliverExtinguishers',
      desc: '',
      args: [],
    );
  }

  /// `View more information (Same list for receiving the request but ends with contract)`
  String get maintainanceTitle {
    return Intl.message(
      'View more information (Same list for receiving the request but ends with contract)',
      name: 'maintainanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `View more information (but without contract)`
  String get fireTitle {
    return Intl.message(
      'View more information (but without contract)',
      name: 'fireTitle',
      desc: '',
      args: [],
    );
  }

  /// `Working In Progress`
  String get workingInProgress {
    return Intl.message(
      'Working In Progress',
      name: 'workingInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Instant License for Company`
  String get instantLicenseForCompany {
    return Intl.message(
      'Instant License for Company',
      name: 'instantLicenseForCompany',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Storage permission is required to proceed`
  String get storagePermissionIsRequiredToProceed {
    return Intl.message(
      'Storage permission is required to proceed',
      name: 'storagePermissionIsRequiredToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Image upload error`
  String get imageUploadError {
    return Intl.message(
      'Image upload error',
      name: 'imageUploadError',
      desc: '',
      args: [],
    );
  }

  /// `No requests found`
  String get noRequestsFound {
    return Intl.message(
      'No requests found',
      name: 'noRequestsFound',
      desc: '',
      args: [],
    );
  }

  /// `Some Thing Error`
  String get someThingError {
    return Intl.message(
      'Some Thing Error',
      name: 'someThingError',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Summary`
  String get wallet_summary {
    return Intl.message(
      'Wallet Summary',
      name: 'wallet_summary',
      desc: '',
      args: [],
    );
  }

  /// `Current Wallet Amount`
  String get current_wallet_amount {
    return Intl.message(
      'Current Wallet Amount',
      name: 'current_wallet_amount',
      desc: '',
      args: [],
    );
  }

  /// `Your rights (One of our safety team members)`
  String get your_rights {
    return Intl.message(
      'Your rights (One of our safety team members)',
      name: 'your_rights',
      desc: '',
      args: [],
    );
  }

  /// `Submit Invoice`
  String get submit_invoice {
    return Intl.message(
      'Submit Invoice',
      name: 'submit_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Amounts Received`
  String get amount_received {
    return Intl.message(
      'Amounts Received',
      name: 'amount_received',
      desc: '',
      args: [],
    );
  }

  /// `Print Report`
  String get print_report {
    return Intl.message(
      'Print Report',
      name: 'print_report',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get order_status {
    return Intl.message(
      'Order Status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Invoice Date`
  String get invoice_date {
    return Intl.message(
      'Invoice Date',
      name: 'invoice_date',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Transferred`
  String get transferred {
    return Intl.message('Transferred', name: 'transferred', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Hold Amount`
  String get holdAmount {
    return Intl.message('Hold Amount', name: 'holdAmount', desc: '', args: []);
  }

  /// `Order Date`
  String get orderDate {
    return Intl.message('Order Date', name: 'orderDate', desc: '', args: []);
  }

  /// `Order Price`
  String get orderPrice {
    return Intl.message('Order Price', name: 'orderPrice', desc: '', args: []);
  }

  /// `Price Closed`
  String get priceClosed {
    return Intl.message(
      'Price Closed',
      name: 'priceClosed',
      desc: '',
      args: [],
    );
  }

  /// `Until the maintenance visits are completed`
  String get untilTheMaintenanceVisitsAreCompleted {
    return Intl.message(
      'Until the maintenance visits are completed',
      name: 'untilTheMaintenanceVisitsAreCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Submit Invoice`
  String get submitInvoice {
    return Intl.message(
      'Submit Invoice',
      name: 'submitInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Amount`
  String get invoiceAmount {
    return Intl.message(
      'Invoice Amount',
      name: 'invoiceAmount',
      desc: '',
      args: [],
    );
  }

  /// `Tax (15% of the invoice)`
  String get taxLabel {
    return Intl.message(
      'Tax (15% of the invoice)',
      name: 'taxLabel',
      desc: '',
      args: [],
    );
  }

  /// `Upload Invoice`
  String get uploadInvoice {
    return Intl.message(
      'Upload Invoice',
      name: 'uploadInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Requests without an official invoice from the service provider will not be accepted. The invoice must include the ID number and logo.`
  String get invoiceNote {
    return Intl.message(
      'Requests without an official invoice from the service provider will not be accepted. The invoice must include the ID number and logo.',
      name: 'invoiceNote',
      desc: '',
      args: [],
    );
  }

  /// `Pending Amount`
  String get currentBalance {
    return Intl.message(
      'Pending Amount',
      name: 'currentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Other Transaction Value`
  String get otherTransactionValue {
    return Intl.message(
      'Other Transaction Value',
      name: 'otherTransactionValue',
      desc: '',
      args: [],
    );
  }

  /// `Contracts List`
  String get contractsList {
    return Intl.message(
      'Contracts List',
      name: 'contractsList',
      desc: '',
      args: [],
    );
  }

  /// `Location on the map`
  String get mapLocation {
    return Intl.message(
      'Location on the map',
      name: 'mapLocation',
      desc: '',
      args: [],
    );
  }

  /// `View Map`
  String get viewMap {
    return Intl.message('View Map', name: 'viewMap', desc: '', args: []);
  }

  /// `Print Report`
  String get printReport {
    return Intl.message(
      'Print Report',
      name: 'printReport',
      desc: '',
      args: [],
    );
  }

  /// `Renew Contract`
  String get renewContract {
    return Intl.message(
      'Renew Contract',
      name: 'renewContract',
      desc: '',
      args: [],
    );
  }

  /// `Choose reason for non-renewal`
  String get chooseNonRenewalReason {
    return Intl.message(
      'Choose reason for non-renewal',
      name: 'chooseNonRenewalReason',
      desc: '',
      args: [],
    );
  }

  /// `Print Contract`
  String get printContract {
    return Intl.message(
      'Print Contract',
      name: 'printContract',
      desc: '',
      args: [],
    );
  }

  /// `Quantity Pay`
  String get quantityPay {
    return Intl.message(
      'Quantity Pay',
      name: 'quantityPay',
      desc: '',
      args: [],
    );
  }

  /// `Number of Visits`
  String get numberOfVisits {
    return Intl.message(
      'Number of Visits',
      name: 'numberOfVisits',
      desc: '',
      args: [],
    );
  }

  /// `Contract Time`
  String get contractTime {
    return Intl.message(
      'Contract Time',
      name: 'contractTime',
      desc: '',
      args: [],
    );
  }

  /// `Visits`
  String get visits {
    return Intl.message('Visits', name: 'visits', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Visit Value`
  String get visitValue {
    return Intl.message('Visit Value', name: 'visitValue', desc: '', args: []);
  }

  /// `Emergency Visit Fee`
  String get emergencyVisitFee {
    return Intl.message(
      'Emergency Visit Fee',
      name: 'emergencyVisitFee',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance Price`
  String get maintenancePrice {
    return Intl.message(
      'Maintenance Price',
      name: 'maintenancePrice',
      desc: '',
      args: [],
    );
  }

  /// `The maintenance cost will be determined after receipt and service completion`
  String
  get theMaintenanceCostWillBeDeterminedAfterReceiptAndServiceCompletion {
    return Intl.message(
      'The maintenance cost will be determined after receipt and service completion',
      name:
          'theMaintenanceCostWillBeDeterminedAfterReceiptAndServiceCompletion',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled Jobs`
  String get scheduledJobs {
    return Intl.message(
      'Scheduled Jobs',
      name: 'scheduledJobs',
      desc: '',
      args: [],
    );
  }

  /// `Stay on top of your service tasks with clear schedules, assigned technicians, and real-time status updates`
  String
  get stayOnTopOfYourServiceTasksWithClearSchedulesAssignedTechniciansAndRealTimeStatusUpdates {
    return Intl.message(
      'Stay on top of your service tasks with clear schedules, assigned technicians, and real-time status updates',
      name:
          'stayOnTopOfYourServiceTasksWithClearSchedulesAssignedTechniciansAndRealTimeStatusUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Table`
  String get table {
    return Intl.message('Table', name: 'table', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Order Type`
  String get orderType {
    return Intl.message('Order Type', name: 'orderType', desc: '', args: []);
  }

  /// `Maintenance Contracts`
  String get maintenanceContracts {
    return Intl.message(
      'Maintenance Contracts',
      name: 'maintenanceContracts',
      desc: '',
      args: [],
    );
  }

  /// `Edit Price Offer`
  String get editPriceOffer {
    return Intl.message(
      'Edit Price Offer',
      name: 'editPriceOffer',
      desc: '',
      args: [],
    );
  }

  /// `Fire Extinguisher`
  String get fireExtinguisher {
    return Intl.message(
      'Fire Extinguisher',
      name: 'fireExtinguisher',
      desc: '',
      args: [],
    );
  }

  /// `Printer`
  String get printer {
    return Intl.message('Printer', name: 'printer', desc: '', args: []);
  }

  /// `Stay informed with all critical alerts and actions that require your attention`
  String
  get stayInformedWithAllCriticalAlertsAndActionsThatRequireYourAttention {
    return Intl.message(
      'Stay informed with all critical alerts and actions that require your attention',
      name:
          'stayInformedWithAllCriticalAlertsAndActionsThatRequireYourAttention',
      desc: '',
      args: [],
    );
  }

  /// `Unread`
  String get unRead {
    return Intl.message('Unread', name: 'unRead', desc: '', args: []);
  }

  /// `Mentioned in it`
  String get mentionedInIt {
    return Intl.message(
      'Mentioned in it',
      name: 'mentionedInIt',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
