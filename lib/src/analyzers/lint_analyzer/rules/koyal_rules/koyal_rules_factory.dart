import '../models/rule.dart';
import 'koyal_text/koyal_text.dart';
import 'no_cross_package_exports/no_cross_package_exports.dart';
import 'no_native_buttons/no_native_buttons.dart';
import 'no_native_icons/no_native_icons.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config),
  NoNativeButtonsRule.ruleId: (config) => NoNativeButtonsRule(config),
  NoCrossPackageExportsRule.ruleId: (config) => NoCrossPackageExportsRule(config),
  NoNativeIconsRule.ruleId: (config) => NoNativeIconsRule(config),
};
