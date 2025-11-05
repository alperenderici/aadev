/// Model for work experience/projects
class ExperienceModel {
  final String id;
  final String titleKey; // Localization key
  final String descriptionKey; // Localization key
  final String? companyName;
  final String? companyLogo;
  final String? screenshot;
  final List<String> technologies;
  final String? liveUrl;
  final String? githubUrl;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrent;

  const ExperienceModel({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    this.companyName,
    this.companyLogo,
    this.screenshot,
    required this.technologies,
    this.liveUrl,
    this.githubUrl,
    this.startDate,
    this.endDate,
    this.isCurrent = false,
  });

  String get duration {
    if (startDate == null) return '';

    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final startMonth = monthNames[startDate!.month - 1];
    final startYear = startDate!.year;

    if (isCurrent) {
      return '$startMonth $startYear - Present';
    }

    if (endDate == null) return '$startMonth $startYear';

    final endMonth = monthNames[endDate!.month - 1];
    final endYear = endDate!.year;

    return '$startMonth $startYear - $endMonth $endYear';
  }
}
