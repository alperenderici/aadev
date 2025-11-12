/// Model for certificates
class CertificateModel {
  final String imagePath;
  final String titleEn;
  final String titleTr;

  const CertificateModel({
    required this.imagePath,
    required this.titleEn,
    required this.titleTr,
  });

  /// Get title based on language code
  String getTitle(String languageCode) {
    return languageCode == 'tr' ? titleTr : titleEn;
  }

  /// Extract date from filename (format: day.month.year.extension)
  DateTime? get date {
    try {
      // Extract filename from path
      final filename = imagePath.split('/').last;
      // Remove extension
      final nameWithoutExt = filename.split('.').take(3).join('.');
      // Parse date parts
      final parts = nameWithoutExt.split('.');
      if (parts.length >= 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Return null if parsing fails
    }
    return null;
  }
}

/// Predefined certificates with titles
class Certificates {
  Certificates._();

  static const List<CertificateModel> _certificates = [
    CertificateModel(
      imagePath: 'assets/certificates/02.04.2025.png',
      titleEn:
          'Certificate Regarding the Implementation of Occupational Health and Safety Services',
      titleTr:
          'İş Sağlığı ve Güvenliği Hizmetlerinin Uygulanmasına İlişkin Sertifika',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/01.11.2024.png',
      titleEn: 'Teknogirişim Akademisi Certificate of Participation',
      titleTr: 'Teknogirişim Akademisi Katılım Sertifikası',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/25.01.2023.png',
      titleEn: 'techcareer.net Flutter Bootcamp',
      titleTr: 'techcareer.net Flutter Bootcamp',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.08.2022.png',
      titleEn: 'Basic Occupational Health and Safety Training',
      titleTr: 'Temel İş Sağlığı ve Güvenliği Eğitimi',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/28.10.2021.png',
      titleEn: 'Security Training: KnowBe4, NTT Data, Security Incidents',
      titleTr: 'Güvenlik Eğitimi: KnowBe4, NTT Data, Güvenlik Olayları',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.12.2021.png',
      titleEn: 'Flutter Camp Achievement Certificate',
      titleTr: 'Flutter Kampı Başarım Sertifikası',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.12.2021(2).png',
      titleEn: 'Flutter Camp Participation Certificate',
      titleTr: 'Flutter Kampı Katılım Sertifikası',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/25.10.2020.png',
      titleEn: 'Introduction to Python Programming Certification',
      titleTr: 'Python Programlamaya Giriş Sertifikası',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/10.12.2019.png',
      titleEn: 'The Fundamentals of Digital Marketing',
      titleTr: 'Dijital Pazarlamanın Temelleri',
    ),
  ];

  /// Get all certificates sorted by date (newest first)
  static List<CertificateModel> get all {
    final sorted = List<CertificateModel>.from(_certificates);
    sorted.sort((a, b) {
      final dateA = a.date;
      final dateB = b.date;

      // If both have dates, compare them (newest first)
      if (dateA != null && dateB != null) {
        return dateB.compareTo(dateA);
      }

      // If only one has a date, prioritize it
      if (dateA != null) return -1;
      if (dateB != null) return 1;

      // If neither has a date, maintain original order
      return 0;
    });
    return sorted;
  }
}
