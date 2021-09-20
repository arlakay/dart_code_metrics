import '../models/rule.dart';

import 'koyal_text/koyal_text.dart';
import 'no_native_buttons/no_native_buttons.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config),
  NoNativeButtonsRule.ruleId: (config) => NoNativeButtonsRule(config),
};
