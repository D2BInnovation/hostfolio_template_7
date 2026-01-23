import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/portfolio_models.dart';

class DataService {
  static PortfolioData? _cachedData;

  static Future<PortfolioData> loadPortfolioData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }

    try {
      final String jsonString = await rootBundle.loadString('data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _cachedData = PortfolioData.fromJson(jsonData);
      return _cachedData!;
    } catch (e) {
      throw Exception('Failed to load portfolio data: $e');
    }
  }

  static void clearCache() {
    _cachedData = null;
  }

  static bool hasSection(String sectionKey) {
    if (_cachedData == null) return false;
    
    switch (sectionKey) {
      case 'hero':
        return _cachedData!.hero != null;
      case 'about':
        return _cachedData!.about != null;
      case 'experience':
        return _cachedData!.experience != null && _cachedData!.experience!.isNotEmpty;
      case 'projects':
        return _cachedData!.projects != null && _cachedData!.projects!.isNotEmpty;
      case 'contact':
        return _cachedData!.contact != null;
      default:
        return false;
    }
  }

  static List<String> getAvailableSections() {
    if (_cachedData == null) return [];
    
    List<String> sections = [];
    if (hasSection('hero')) sections.add('hero');
    if (hasSection('about')) sections.add('about');
    if (hasSection('experience')) sections.add('experience');
    if (hasSection('projects')) sections.add('projects');
    if (hasSection('contact')) sections.add('contact');
    
    return sections;
  }
}
