import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

/// Model for social media links
class SocialLinkModel {
  final String name;
  final String url;
  final IconData icon;
  final Color? color;
  final bool isPrimary;

  const SocialLinkModel({
    required this.name,
    required this.url,
    required this.icon,
    this.color,
    this.isPrimary = false,
  });
}

/// Predefined social links
class SocialLinks {
  SocialLinks._();

  static const List<SocialLinkModel> all = [
    SocialLinkModel(
      name: 'GitHub',
      url: 'https://github.com/alperenderici',
      icon: FontAwesomeIcons.github,
      isPrimary: true,
    ),
    SocialLinkModel(
      name: 'LinkedIn',
      url: 'https://linkedin.com/in/ali-alperen-derici-38870114a',
      icon: FontAwesomeIcons.linkedin,
      color: Color(0xFF0077B5),
      isPrimary: true,
    ),
    SocialLinkModel(
      name: 'Upwork',
      url: 'https://www.upwork.com/freelancers/~01066de01bf9c1790f',
      icon: FontAwesomeIcons.upwork,
      color: Color(0xFF6FDA44),
    ),
    SocialLinkModel(
      name: 'Medium',
      url: 'https://medium.com/@alperenderici',
      icon: FontAwesomeIcons.medium,
    ),
    SocialLinkModel(
      name: 'X (Twitter)',
      url: 'https://twitter.com/grandealperen',
      icon: FontAwesomeIcons.xTwitter,
    ),
    SocialLinkModel(
      name: 'Letterboxd',
      url: 'https://letterboxd.com/alperenderici',
      icon: FontAwesomeIcons.film,
      color: Color(0xFF00D735),
    ),
    SocialLinkModel(
      name: 'HackerRank',
      url: 'https://www.hackerrank.com/alperenderici',
      icon: FontAwesomeIcons.hackerrank,
      color: Color(0xFF2EC866),
    ),
    SocialLinkModel(
      name: 'Instagram',
      url: 'https://instagram.com/aalperenderici',
      icon: FontAwesomeIcons.instagram,
      color: Color(0xFFE4405F),
    ),
    SocialLinkModel(
      name: 'YouTube',
      url: 'https://www.youtube.com/channel/UCLbG2_G2k7ei0oOqX_1b_MQ',
      icon: FontAwesomeIcons.youtube,
      color: Color(0xFFFF0000),
    ),
    SocialLinkModel(
      name: 'Goodreads',
      url: 'https://www.goodreads.com/user/show/150602298-alperen-derici',
      icon: FontAwesomeIcons.bookOpen,
      color: Color(0xFF372213),
    ),
    SocialLinkModel(
      name: 'Untappd',
      url: 'https://untappd.com/user/alperenderici',
      icon: FontAwesomeIcons.beerMugEmpty,
      color: Color(0xFFFFCC00),
    ),
    SocialLinkModel(
      name: 'Spotify',
      url:
          'https://open.spotify.com/user/alperenderi%CC%87ci%CC%87?si=a6b5d16347cf469d',
      icon: FontAwesomeIcons.spotify,
      color: Color(0xFF1DB954),
    ),
  ];

  static List<SocialLinkModel> get primary =>
      all.where((link) => link.isPrimary).toList();
}
