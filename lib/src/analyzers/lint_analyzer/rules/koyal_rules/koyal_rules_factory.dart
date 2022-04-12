import '../models/rule.dart';
import 'koyal_text/koyal_text.dart';
import 'no_cross_package_exports/no_cross_package_exports.dart';
import 'no_native_buttons/no_native_buttons.dart';
import 'no_native_icons/no_native_icons_rule.dart';
import 'no_native_input_elements/no_native_input_elements_rule.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config),
  NoNativeButtonsRule.ruleId: (config) => NoNativeButtonsRule(config),
  NoCrossPackageExportsRule.ruleId: (config) => NoCrossPackageExportsRule(config),
  NoNativeIconsRule.ruleId: (config) => NoNativeIconsRule(config),
  NoNativeInputElementsRule.ruleId: (config) => NoNativeInputElementsRule(config),
};
