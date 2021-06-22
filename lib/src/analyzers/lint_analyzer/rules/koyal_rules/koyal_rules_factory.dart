import '../models/rule.dart';
import 'koyal_newline_before_return.dart';
import 'koyal_text_rule.dart';

final rules = <String, Rule Function(Map<String, Object>)>{
  KoyalTextRule.ruleId: (config) => KoyalTextRule(config: config),
  NewlineBeforeReturnRule.ruleId: (config) => NewlineBeforeReturnRule(config),
};
