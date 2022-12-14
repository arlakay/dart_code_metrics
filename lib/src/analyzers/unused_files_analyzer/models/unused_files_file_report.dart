import '../../../reporters/models/file_report.dart';

/// Represents the unused files report collected for a file.
class UnusedFilesFileReport implements FileReport {
  /// The path to the target file.
  @override
  final String path;

  /// The path to the target file relative to the package root.
  @override
  final String relativePath;

  const UnusedFilesFileReport({
    required this.path,
    required this.relativePath,
  });
}
