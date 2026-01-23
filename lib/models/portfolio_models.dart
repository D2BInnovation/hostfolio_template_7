import 'package:json_annotation/json_annotation.dart';

part 'portfolio_models.g.dart';

@JsonSerializable()
class Personal {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String website;
  final String linkedin;
  final String github;
  final String bio;

  Personal({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.website,
    required this.linkedin,
    required this.github,
    required this.bio,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => _$PersonalFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalToJson(this);
}

@JsonSerializable()
class Button {
  final String text;
  final String link;

  Button({
    required this.text,
    required this.link,
  });

  factory Button.fromJson(Map<String, dynamic> json) => _$ButtonFromJson(json);
  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}

@JsonSerializable()
class Hero {
  final String greeting;
  final String description;
  final Button primaryButton;
  final Button secondaryButton;

  Hero({
    required this.greeting,
    required this.description,
    required this.primaryButton,
    required this.secondaryButton,
  });

  factory Hero.fromJson(Map<String, dynamic> json) => _$HeroFromJson(json);
  Map<String, dynamic> toJson() => _$HeroToJson(this);
}

@JsonSerializable()
class About {
  final List<String> description;
  final List<String> skills;

  About({
    required this.description,
    required this.skills,
  });

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);
  Map<String, dynamic> toJson() => _$AboutToJson(this);
}

@JsonSerializable()
class Experience {
  final int id;
  final String company;
  final String position;
  final String duration;
  final String location;
  final String description;
  final List<String> achievements;
  final List<String> technologies;

  Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.description,
    required this.achievements,
    required this.technologies,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Project {
  final int id;
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;
  final String image;
  final bool featured;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    required this.liveUrl,
    required this.image,
    required this.featured,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class SocialLink {
  final String platform;
  final String url;
  final String icon;

  SocialLink({
    required this.platform,
    required this.url,
    required this.icon,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => _$SocialLinkFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);
}

@JsonSerializable()
class Contact {
  final String title;
  final String description;
  final List<SocialLink> socialLinks;

  Contact({
    required this.title,
    required this.description,
    required this.socialLinks,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable()
class PortfolioData {
  final Personal personal;
  final Hero? hero;
  final About? about;
  final List<Experience>? experience;
  final List<Project>? projects;
  final Contact? contact;

  PortfolioData({
    required this.personal,
    this.hero,
    this.about,
    this.experience,
    this.projects,
    this.contact,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) => _$PortfolioDataFromJson(json);
  Map<String, dynamic> toJson() => _$PortfolioDataToJson(this);
}
