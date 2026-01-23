// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personal _$PersonalFromJson(Map<String, dynamic> json) => Personal(
      name: json['name'] as String,
      title: json['title'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      location: json['location'] as String,
      website: json['website'] as String,
      linkedin: json['linkedin'] as String,
      github: json['github'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$PersonalToJson(Personal instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'email': instance.email,
      'phone': instance.phone,
      'location': instance.location,
      'website': instance.website,
      'linkedin': instance.linkedin,
      'github': instance.github,
      'bio': instance.bio,
    };

Button _$ButtonFromJson(Map<String, dynamic> json) => Button(
      text: json['text'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
      'text': instance.text,
      'link': instance.link,
    };

Hero _$HeroFromJson(Map<String, dynamic> json) => Hero(
      greeting: json['greeting'] as String,
      description: json['description'] as String,
      primaryButton:
          Button.fromJson(json['primaryButton'] as Map<String, dynamic>),
      secondaryButton:
          Button.fromJson(json['secondaryButton'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HeroToJson(Hero instance) => <String, dynamic>{
      'greeting': instance.greeting,
      'description': instance.description,
      'primaryButton': instance.primaryButton,
      'secondaryButton': instance.secondaryButton,
    };

About _$AboutFromJson(Map<String, dynamic> json) => About(
      description: (json['description'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'description': instance.description,
      'skills': instance.skills,
    };

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      id: (json['id'] as num).toInt(),
      company: json['company'] as String,
      position: json['position'] as String,
      duration: json['duration'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'position': instance.position,
      'duration': instance.duration,
      'location': instance.location,
      'description': instance.description,
      'achievements': instance.achievements,
      'technologies': instance.technologies,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: (json['technologies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      githubUrl: json['githubUrl'] as String,
      liveUrl: json['liveUrl'] as String,
      image: json['image'] as String,
      featured: json['featured'] as bool,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'technologies': instance.technologies,
      'githubUrl': instance.githubUrl,
      'liveUrl': instance.liveUrl,
      'image': instance.image,
      'featured': instance.featured,
    };

SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) => SocialLink(
      platform: json['platform'] as String,
      url: json['url'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$SocialLinkToJson(SocialLink instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'url': instance.url,
      'icon': instance.icon,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      title: json['title'] as String,
      description: json['description'] as String,
      socialLinks: (json['socialLinks'] as List<dynamic>)
          .map((e) => SocialLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'socialLinks': instance.socialLinks,
    };

PortfolioData _$PortfolioDataFromJson(Map<String, dynamic> json) =>
    PortfolioData(
      personal: Personal.fromJson(json['personal'] as Map<String, dynamic>),
      hero: json['hero'] == null
          ? null
          : Hero.fromJson(json['hero'] as Map<String, dynamic>),
      about: json['about'] == null
          ? null
          : About.fromJson(json['about'] as Map<String, dynamic>),
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PortfolioDataToJson(PortfolioData instance) =>
    <String, dynamic>{
      'personal': instance.personal,
      'hero': instance.hero,
      'about': instance.about,
      'experience': instance.experience,
      'projects': instance.projects,
      'contact': instance.contact,
    };
