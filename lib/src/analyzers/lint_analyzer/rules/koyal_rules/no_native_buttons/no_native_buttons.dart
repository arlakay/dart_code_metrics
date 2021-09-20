import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../../lint_analyzer.dart';
import '../../../../../utils/node_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/rule.dart';
import '../../models/rule_documentation.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoNativeButtonsRule extends Rule {
  static const String ruleId = 'no-native-buttons';

  static const _failure =
      'Primary/Secondary/TertiaryButton widget has be used instead of native button.';

  NoNativeButtonsRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          documentation: const RuleDocumentation(
            name: 'No Native Buttons',
            brief: 'No native flutter button widgets are allowed.',
          ),
          severity: readSeverity(config, Severity.error),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final _visitor = _Visitor();

    source.unit.visitChildren(_visitor);

    return _visitor._expressions
        .map((statement) => createIssue(
              rule: this,
              location: nodeLocation(node: statement, source: source),
              replacement: koyalTextReplacement(statement),
              message: _failure,
            ))
        .toList(growable: false);
  }
}

Replacement koyalTextReplacement(InstanceCreationExpression textExpression) {
  const replacementComment =
      'Use Primary/Secondary/TertiaryButton with Horizontal or Vertical layout.';
  final args = textExpression.argumentList.arguments;
  Expression? keyExp;
  Expression? onPressedExp;

  for (final expression in args) {
    if (expression is NamedExpression) {
      switch (expression.name.label.name) {
        case 'key':
          keyExp = expression.expression;
          break;
        case 'onPressed':
          onPressedExp = expression.expression;
          break;
      }
    }
  }

  var replacementText = 'PrimaryButton(';
  if (keyExp != null) {
    replacementText += 'key: ${keyExp.toSource()}';
  }
  if (onPressedExp != null) {
    replacementText += ', onPressed: ${onPressedExp.toSource()}';
  }
  replacementText += ',)';

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
