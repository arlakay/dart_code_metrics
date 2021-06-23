import '../models/rule.dart';

import 'koyal_text/koyal_text.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config),
};
