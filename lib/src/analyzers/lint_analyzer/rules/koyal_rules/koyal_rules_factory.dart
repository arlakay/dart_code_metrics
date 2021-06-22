import '../models/rule.dart';

import 'koyal_text_rule.dart';
import 'no_empty_block/no_empty_block.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config: config),
  NoEmptyBlockRule.ruleId: (config) => NoEmptyBlockRule(config),
};
