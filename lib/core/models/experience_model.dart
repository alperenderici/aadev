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
    final end = isCurrent ? DateTime.now() : (endDate ?? DateTime.now());
    final months = (end.year - startDate!.year) * 12 + end.month - startDate!.month;
    final years = months ~/ 12;
    final remainingMonths = months % 12;

    if (years > 0 && remainingMonths > 0) {
      return '$years yr${years > 1 ? 's' : ''} $remainingMonths mo${remainingMonths > 1 ? 's' : ''}';
    } else if (years > 0) {
      return '$years yr${years > 1 ? 's' : ''}';
    } else {
      return '$remainingMonths mo${remainingMonths > 1 ? 's' : ''}';
    }
  }
}

