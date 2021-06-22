@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/rules/rules_factory.dart';
import 'package:test/test.dart';

void main() {
  test('getRulesById returns only required rules', () {
    expect(getRulesById({}), isEmpty);
    expect(
      getRulesById({
        'provide-correct-intl-args': <String, Object>{},
        'no-empty-block': <String, Object>{},
        'binary-expression-operand-order': <String, Object>{},
        'no-magic-number': <String, Object>{},
        'double-literal-format': <String, Object>{},
        'avoid-preserve-whitespace-false': <String, Object>{},
        'no-equal-arguments': <String, Object>{},
        'member-ordering': <String, Object>{},
        'prefer-conditional-expressions': <String, Object>{},
        'unknown-rule': <String, Object>{},
        'no-object-declaration': <String, Object>{},
        'component-annotation-arguments-ordering': <String, Object>{},
        'no-equal-then-else': <String, Object>{},
        'prefer-intl-name': <String, Object>{},
        'newline-before-return': <String, Object>{},
        'no-boolean-literal-compare': <String, Object>{},
        'prefer-on-push-cd-strategy': <String, Object>{},
        'prefer-trailing-comma': <String, Object>{},
        'avoid-late-keyword': <String, Object>{},
        'member-ordering-extended': <String, Object>{},
        'avoid-non-null-assertion': <String, Object>{},
        'avoid-unused-parameters': <String, Object>{},
        'avoid-returning-widgets': <String, Object>{},
        'avoid-unnecessary-setstate': <String, Object>{},
        'always-remove-listener': <String, Object>{},
        'avoid-wrapping-in-padding': <String, Object>{},
        'prefer-extracting-callbacks': <String, Object>{},
        'koyal-text': <String, Object>{},
      }).map((rule) => rule.id),
      equals([
        'always-remove-listener',
        'avoid-late-keyword',
        'avoid-non-null-assertion',
        'avoid-preserve-whitespace-false',
        'avoid-returning-widgets',
        'avoid-unnecessary-setstate',
        'avoid-unused-parameters',
        'avoid-wrapping-in-padding',
        'binary-expression-operand-order',
        'component-annotation-arguments-ordering',
        'double-literal-format',
        'member-ordering',
        'member-ordering-extended',
        'newline-before-return',
        'no-boolean-literal-compare',
        'no-empty-block',
        'no-equal-arguments',
        'no-equal-then-else',
        'no-magic-number',
        'no-object-declaration',
        'prefer-conditional-expressions',
        'prefer-extracting-callbacks',
        'prefer-intl-name',
        'prefer-on-push-cd-strategy',
        'prefer-trailing-comma',
        'provide-correct-intl-args',
        'koyal-text'
      ]),
    );
  });
}
