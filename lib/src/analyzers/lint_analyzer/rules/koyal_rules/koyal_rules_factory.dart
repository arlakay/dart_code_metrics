import '../models/rule.dart';
import 'buttons_layout/buttons_layout.dart';
import 'koyal_scaffold/koyal_scaffold.dart';
import 'koyal_text/koyal_text.dart';
import 'koyal_text_span/koyal_text_span.dart';
import 'no-hcicolors/no_hci_colors_rule.dart';
import 'no_cross_package_exports/no_cross_package_exports.dart';
import 'no_direct_colors/no_direct_colors_rule.dart';
import 'no_direct_padding/no_direct_padding_rule.dart';
import 'no_native_buttons/no_native_buttons.dart';
import 'no_native_icons/no_native_icons_rule.dart';
import 'no_native_input_elements/no_native_input_elements_rule.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalScaffoldRule.ruleId: (config) => KoyalScaffoldRule(config),
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config),
  KoyalTextSpanRule.ruleId: (config) => KoyalTextSpanRule(config),
  NoNativeButtonsRule.ruleId: (config) => NoNativeButtonsRule(config),
  NoCrossPackageExportsRule.ruleId: (config) => NoCrossPackageExportsRule(config),
  NoNativeIconsRule.ruleId: (config) => NoNativeIconsRule(config),
  NoNativeInputElementsRule.ruleId: (config) => NoNativeInputElementsRule(config),
  ButtonsLayoutRule.ruleId: (config) => ButtonsLayoutRule(config),
  NoDirectColorsRule.ruleId: (config) => NoDirectColorsRule(config),
  NoDirectPaddingRule.ruleId: (config) => NoDirectPaddingRule(config),
  NoHciColorsRule.ruleId: (config) => NoHciColorsRule(config),
};
