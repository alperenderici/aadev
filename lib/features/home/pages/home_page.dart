import 'package:flutter/material.dart';
import 'package:aad/features/home/widgets/hero_section.dart';
import 'package:aad/features/home/widgets/about_section.dart';
import 'package:aad/features/home/widgets/upwork_service_section.dart';
import 'package:aad/features/home/widgets/experience_section.dart';
import 'package:aad/features/home/widgets/events_section.dart';
import 'package:aad/features/home/widgets/certificates_section.dart';
import 'package:aad/features/home/widgets/social_links_section.dart';
import 'package:aad/features/home/widgets/cv_download_section.dart';
import 'package:aad/features/home/widgets/contact_section.dart';
import 'package:aad/shared/widgets/app_navigation_bar.dart';
import 'package:aad/shared/widgets/app_footer.dart';

/// Home page widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'events': GlobalKey(),
    'certificates': GlobalKey(),
    'social': GlobalKey(),
    'cv': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavigationBar(onNavigate: _scrollToSection),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: _sectionKeys['home'],
                    child: HeroSection(
                      onContactPressed: () => _scrollToSection('contact'),
                      onCVPressed: () => _scrollToSection('cv'),
                    ),
                  ),

                  // About Section
                  Container(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),

                  // Upwork Service Section
                  const UpworkServiceSection(),

                  // Experience Section
                  Container(
                    key: _sectionKeys['experience'],
                    child: const ExperienceSection(),
                  ),

                  // Events Section
                  Container(
                    key: _sectionKeys['events'],
                    child: const EventsSection(),
                  ),

                  // Certificates Section
                  Container(
                    key: _sectionKeys['certificates'],
                    child: const CertificatesSection(),
                  ),

                  // Social Links Section
                  Container(
                    key: _sectionKeys['social'],
                    child: const SocialLinksSection(),
                  ),

                  // CV Download Section
                  Container(
                    key: _sectionKeys['cv'],
                    child: const CVDownloadSection(),
                  ),

                  // Contact Section
                  Container(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),

                  // Footer
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
