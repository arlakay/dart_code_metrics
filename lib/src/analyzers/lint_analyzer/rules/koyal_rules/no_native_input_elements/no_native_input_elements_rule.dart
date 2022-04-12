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

class NoNativeInputElementsRule extends FlutterRule {
  static const String ruleId = 'no-native-input-elements';

  static const _failure = 'Input widget from koyal_ui library has be used instead of native input element.';

  NoNativeInputElementsRule([Map<String, Object> config = const {}])
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

// ignore: long-method
Replacement koyalTextReplacement(InstanceCreationExpression textExpression) {
  const replacementComment = 'Please use input widget from koyal_ui library instead of native input element';
  final args = textExpression.argumentList.arguments;
  Expression? keyExp;
  Expression? valueExp;
  Expression? minExp;
  Expression? maxExp;
  Expression? onChangedExp;
  Expression? keyboardTypeExp;
  Expression? onTapExp;
  final widgetType = textExpression.staticType?.getDisplayString(withNullability: false);

  for (final expression in args) {
    if (expression is NamedExpression) {
      switch (expression.name.label.name) {
        case 'key':
          keyExp = expression.expression;
          break;
        case 'value':
          valueExp = expression.expression;
          break;
        case 'min':
          minExp = expression.expression;
          break;
        case 'max':
          maxExp = expression.expression;
          break;
        case 'keyboardType':
          keyboardTypeExp = expression.expression;
          break;
        case 'onTap':
          onTapExp = expression.expression;
          break;
        case 'onChanged':
          onChangedExp = expression.expression;
          break;
      }
    }
  }

  var replacementText = '';
  if (widgetType == 'Checkbox') {
    replacementText = 'KoyalCheckbox(';
    if (keyExp != null) {
      replacementText += 'key: ${keyExp.toSource()}, ';
    }
    if (valueExp != null) {
      replacementText += 'value: ${valueExp.toSource()}, ';
    }
    if (onChangedExp != null) {
      replacementText += 'onChanged: ${onChangedExp.toSource()}';
    }
    replacementText += ',)';
  } else if (widgetType == 'Slider') {
    replacementText = 'KoyalSlider(';
    if (keyExp != null) {
      replacementText += 'key: ${keyExp.toSource()}, ';
    }
    if (valueExp != null) {
      replacementText += 'value: ${valueExp.toSource()}, ';
    }
    if (minExp != null) {
      replacementText += 'min: ${minExp.toSource()}, ';
    }
    if (maxExp != null) {
      replacementText += 'max: ${maxExp.toSource()}, ';
    }
    if (onChangedExp != null) {
      replacementText += 'onChanged: ${onChangedExp.toSource()}';
    }
    replacementText += ',)';
  } else if (widgetType == 'TextFormField') {
    replacementText = 'InputText(';
    if (keyExp != null) {
      replacementText += 'key: ${keyExp.toSource()}, ';
    }
    if (keyboardTypeExp != null) {
      replacementText += 'keyboardType: ${keyboardTypeExp.toSource()}, ';
    }
    if (onTapExp != null) {
      replacementText += 'onTap: ${onTapExp.toSource()}, ';
    }
    if (onChangedExp != null) {
      replacementText += 'onChanged: ${onChangedExp.toSource()}';
    }
    replacementText += ',)';
  } else {
    replacementText = 'TODO(Input Widget from Koyal UI)';
  }

  return Replacement(
    comment: replacementComment,
    replacement: replacementText,
  );
}
