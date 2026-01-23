import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/portfolio_models.dart';
import '../utils/scroll_controller.dart';

class AnimatedHeader extends StatefulWidget {
  const AnimatedHeader({Key? key}) : super(key: key);

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader> {
  bool _isScrolled = false;
  String _activeSection = 'hero';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollController = Provider.of<AppScrollController>(context, listen: false);
      scrollController.controller.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    final scrollController = Provider.of<AppScrollController>(context, listen: false);
    scrollController.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrollController = Provider.of<AppScrollController>(context, listen: false);
    if (!scrollController.controller.hasClients) return;
    
    final offset = scrollController.controller.offset;
    final wasScrolled = _isScrolled;
    _isScrolled = offset > 50;

    if (wasScrolled != _isScrolled) {
      setState(() {});
    }

    // Update active section based on scroll position
    _updateActiveSection(offset);
  }

  void _updateActiveSection(double offset) {
    // Define sections in order
    final sections = [
      {'id': 'hero', 'key': heroKey},
      {'id': 'about', 'key': aboutKey},
      {'id': 'experience', 'key': experienceKey},
      {'id': 'projects', 'key': projectsKey},
      {'id': 'contact', 'key': contactKey},
    ];

    String newActiveSection = _activeSection;
    double minDistance = double.infinity;

    // Find the section closest to the top of the screen (considering offset)
    // We want the section that is currently occupying the major part of the viewport
    // or the one that just passed the top edge.

    // Better approach: Find the last section whose top position is <= viewport center (or some offset)
    
    // Using simple offset check relative to global positions has issues if content changes size.
    // Instead, get the render object position relative to viewport.

    for (var section in sections) {
      final key = section['key'] as GlobalKey;
      final context = key.currentContext;
      
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          // Check if section is somewhat visible. 
          // We consider a section active if its top is above the middle of the screen
          // but its bottom is also reasonably on screen or it's the last one.
          
          // Let's us a simple threshold: 1/3 of screen height.
          // If a section top is <= screenHeight / 3, it's a candidate.
          // We pick the last candidate that satisfies this (so the bottom-most one that has started).
          
          final double screenHeight = MediaQuery.of(context).size.height;
          final double threshold = screenHeight * 0.4; // Trigger when section is 40% up the screen

          if (position.dy <= threshold) {
            newActiveSection = section['id'] as String;
          }
        }
      }
    }

    if (newActiveSection != _activeSection) {
      if (mounted) {
        setState(() {
          _activeSection = newActiveSection;
        });
      }
    }
  }

  void _scrollToSection(String sectionId) {
    // Map section IDs to keys directly
    final sectionKeys = {
      'hero': heroKey,
      'about': aboutKey,
      'experience': experienceKey,
      'projects': projectsKey,
      'contact': contactKey,
    };

    final key = sectionKeys[sectionId];
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
          alignment: 0.0, // align to top
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final availableSections = DataService.getAvailableSections();
        
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: GlassmorphicContainer(
            width: double.infinity,
            height: 80,
            borderRadius: 0,
            blur: 20,
            alignment: Alignment.center,
            border: _isScrolled ? 1 : 0,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(_isScrolled ? 0.1 : 0.05),
                Colors.white.withOpacity(_isScrolled ? 0.05 : 0.02),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(_isScrolled ? 0.2 : 0.1),
                Colors.white.withOpacity(_isScrolled ? 0.1 : 0.05),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo/Name
                    _buildLogo(portfolioData.personal.name),
                    
                    const Expanded(child: SizedBox()),
                    
                    // Navigation Items
                    ...availableSections.map((section) => 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildNavItem(section, _activeSection == section),
                      ),
                    ).toList(),
                    
                    const Expanded(child: SizedBox()),
                    
                    // CTA Button
                    _buildCTAButton(),
                  ],
                ),
              ),
            ),
          ).animate().slideY(
            duration: 600.ms,
            begin: -1,
            curve: Curves.easeOutCubic,
          ).fadeIn(),
        );
      },
    );
  }

  Widget _buildLogo(String name) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection('hero'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.2),
                Colors.purple.withOpacity(0.2),
              ],
            ),
          ),
          child: Text(
            name.split(' ')[0],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    ).animate().scale(
      duration: 300.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildNavItem(String section, bool isActive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection(section),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive 
              ? Colors.white.withOpacity(0.15)
              : Colors.transparent,
            border: isActive
              ? Border.all(color: Colors.white.withOpacity(0.3))
              : null,
          ),
          child: Text(
            section.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive 
                ? Colors.white.withOpacity(0.95)
                : Colors.white.withOpacity(0.7),
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    ).animate(target: isActive ? 1 : 0).scaleXY(
      duration: 200.ms,
      begin: 1.0,
      end: 1.05,
    );
  }

  Widget _buildCTAButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection('contact'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'GET IN TOUCH',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    ).animate().scale(
      duration: 300.ms,
      delay: 200.ms,
      curve: Curves.easeOutBack,
    ).then().shimmer(
      duration: 2000.ms,
      delay: 2000.ms,
    );
  }
}

// Global keys for sections
final GlobalKey heroKey = GlobalKey();
final GlobalKey aboutKey = GlobalKey();
final GlobalKey experienceKey = GlobalKey();
final GlobalKey projectsKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();
