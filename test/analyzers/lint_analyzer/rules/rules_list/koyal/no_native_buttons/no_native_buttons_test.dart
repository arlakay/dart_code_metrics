@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/rules/koyal_rules/no_native_buttons/no_native_buttons.dart';
import 'package:test/test.dart';

import '../../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'koyal/no_native_buttons/examples/example.dart';

void main() {
  group('NoNativeButtons', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = NoNativeButtonsRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'no-native-buttons',
        severity: Severity.error,
      );
    });

    test('reports about found issues with the default config', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = NoNativeButtonsRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [4, 5, 6, 7, 8],
        startColumns: [5, 5, 5, 5, 12],
        startOffsets: [101, 160, 217, 272, 334],
        endOffsets: [154, 211, 266, 321, 387],
        locationTexts: [
          '''
ElevatedButton(key: Key('testKey'), onPressed: () {})''',
          '''
RaisedButton(key: Key('testKey'), onPressed: () {})''',
          '''
FlatButton(key: Key('testKey'), onPressed: () {})''',
          '''
TextButton(key: Key('testKey'), onPressed: () {})''',
          '''
OutlinedButton(key: Key('testKey'), onPressed: () {})''',
        ],
        messages: [
          'Primary/Secondary/TertiaryButton widget has be used instead of native button.',
          'Primary/Secondary/TertiaryButton widget has be used instead of native button.',
          'Primary/Secondary/TertiaryButton widget has be used instead of native button.',
          'Primary/Secondary/TertiaryButton widget has be used instead of native button.',
          'Primary/Secondary/TertiaryButton widget has be used instead of native button.',
        ],
        replacements: [
          "PrimaryButton(key: Key('testKey'), onPressed: () {},)",
          "PrimaryButton(key: Key('testKey'), onPressed: () {},)",
          "PrimaryButton(key: Key('testKey'), onPressed: () {},)",
          "PrimaryButton(key: Key('testKey'), onPressed: () {},)",
          "PrimaryButton(key: Key('testKey'), onPressed: () {},)",
        ],
      );
    });
  });
}
