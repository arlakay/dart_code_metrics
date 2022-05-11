import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/replacement.dart';
import '../../../models/severity.dart';
import '../../models/flutter_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class NoDirectPaddingRule extends FlutterRule {
  static const String ruleId = 'no-direct-padding';

  static const _failure = 'KoyalPadding widget has be used instead of native padding.';

  NoDirectPaddingRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
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
  const replacementComment = 'Please use KoyalPadding instead of Padding';
  const paddingType = 'TODO';
  final args = textExpression.argumentList.arguments;
  Expression? keyExp;
  Expression? childExp;

  for (final expression in args) {
    if (expression is NamedExpression) {
      final exp = expression.expression;
      switch (expression.name.label.name) {
        case 'key':
          keyExp = exp;
          break;
        case 'child':
          childExp = exp;
          break;
      }
    }
  }

  var replacementText = 'KoyalPadding.$paddingType(';
  if (keyExp != null) {
    replacementText += 'key: ${keyExp.toSource()}, ';
  }
  if (childExp != null) {
    replacementText += 'child: ${childExp.toSource()}, ';
  }
  replacementText += ')';

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
