// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Counter';

  @override
  String customers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Customers',
      one: 'Customer',
      zero: 'Customer',
    );
    return '$_temp0';
  }

  @override
  String get visits => 'Visits';

  @override
  String activities(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Activities',
      one: 'Activity',
      zero: 'Activity',
    );
    return '$_temp0';
  }

  @override
  String get recordAVisit => 'Record a visit';

  @override
  String get recordVisitSuccess => 'Visit recorded successfully';

  @override
  String get generalError => 'Unknown error occurred';

  @override
  String get location => 'Address';

  @override
  String get notes => 'Notes';

  @override
  String get visitDate => 'Vist date';

  @override
  String get activitiesDone => 'Activities Done';

  @override
  String get required_ => 'This field is required';
}
