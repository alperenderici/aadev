/// Model for certificates
class CertificateModel {
  final String imagePath;
  final String title;

  const CertificateModel({
    required this.imagePath,
    required this.title,
  });
}

/// Predefined certificates with titles
class Certificates {
  Certificates._();

  static const List<CertificateModel> all = [
    CertificateModel(
      imagePath: 'assets/certificates/02.04.2025.png',
      title: 'Flutter Development Certificate',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/01.11.2024.jpg',
      title: 'Mobile App Development',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/25.01.2023.png',
      title: 'Advanced Dart Programming',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.08.2022.png',
      title: 'Firebase Integration',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/29.10.2021(2).png',
      title: 'UI/UX Design Principles',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/29.10.2021.png',
      title: 'State Management',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/28.10.2021.png',
      title: 'Clean Architecture',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.12.2021(2).png',
      title: 'Testing & Quality Assurance',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/19.12.2021.png',
      title: 'CI/CD & DevOps',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/25.10.2020.png',
      title: 'Software Engineering',
    ),
    CertificateModel(
      imagePath: 'assets/certificates/10.12.2019.png',
      title: 'Programming Fundamentals',
    ),
  ];
}

