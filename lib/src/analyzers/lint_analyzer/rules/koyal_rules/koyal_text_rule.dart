import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../lint_analyzer.dart';
import '../../../../utils/node_utils.dart';
import '../../models/internal_resolved_unit_result.dart';
import '../models/rule.dart';
import '../models/rule_documentation.dart';
import '../rule_utils.dart';

class KoyalTextRule extends Rule {
  static const String ruleId = 'koyal-text';

  static const _failure = 'KoyalText should be used instead of Text.';

  KoyalTextRule({Map<String, Object> config = const {}})
      : super(
          id: ruleId,
          documentation: const RuleDocumentation(
            name: 'KoyalText',
            brief: 'Checks that there is no constructor of native Text.',
          ),
          severity: readSeverity(config, Severity.style),
          excludes: readExcludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final _visitor = _Visitor();

    source.unit.visitChildren(_visitor);

    return _visitor.constructorNames
        .map(
          (constructorName) => createIssue(
            rule: this,
            location: nodeLocation(
              node: constructorName,
              source: source,
            ),
            message: _failure,
            replacement: const Replacement(
              comment: 'VR Test replacement comment',
              replacement: 'VR Test replacement content',
            ),
          ),
        )
        .toList(growable: false);
  }
}

class _Visitor extends RecursiveAstVisitor<void> {
  final _constructorNames = <MethodInvocation>[];

  Iterable<MethodInvocation> get constructorNames => _constructorNames;

  @override
  void visitMethodInvocation(MethodInvocation constructorName) {
    super.visitMethodInvocation(constructorName);
    if (constructorName.methodName.name == 'Text') {
      _constructorNames.add(constructorName);
    }
  }
}
