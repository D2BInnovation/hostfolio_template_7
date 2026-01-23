import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/portfolio_models.dart';
import '../utils/scroll_controller.dart';
import '../widgets/animated_widgets.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> 
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final hero = portfolioData.hero;
        final personal = portfolioData.personal;
        
        if (hero == null) return const SizedBox.shrink();

        return Container(
          key: widget.key, // Use the key passed from parent
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0F172A),
                const Color(0xFF1E293B),
                const Color(0xFF334155),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background particles
              _buildBackgroundParticles(),
              
              // Main content
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top: 100, // Add top padding to avoid header overlap
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      // Greeting
                      Text(
                        hero.greeting,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 2,
                        ),
                      ).animate().slideX(
                        duration: 600.ms,
                        begin: -0.5,
                        curve: Curves.easeOutCubic,
                      ).fadeIn(),
                      
                      const SizedBox(height: 16),
                      
                      // Name
                      Text(
                        personal.name,
                        style: GoogleFonts.inter(
                          fontSize: constraints.maxWidth > 768 ? 72 : 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -2,
                          height: 1.1,
                        ),
                      ).animate().slideX(
                        duration: 800.ms,
                        begin: -0.5,
                        curve: Curves.easeOutCubic,
                      ).fadeIn(delay: 200.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Title
                      Text(
                        personal.title,
                        style: GoogleFonts.inter(
                          fontSize: constraints.maxWidth > 768 ? 28 : 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 1,
                        ),
                      ).animate().slideX(
                        duration: 1000.ms,
                        begin: -0.5,
                        curve: Curves.easeOutCubic,
                      ).fadeIn(delay: 400.ms),
                      
                      const SizedBox(height: 32),
                      
                      // Description
                      SizedBox(
                        width: constraints.maxWidth > 768 ? 600 : double.infinity,
                        child: Text(
                          hero.description,
                          style: GoogleFonts.inter(
                            fontSize: constraints.maxWidth > 768 ? 18 : 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.6,
                          ),
                        ),
                      ).animate().slideY(
                        duration: 600.ms,
                        begin: 0.5,
                        curve: Curves.easeOutCubic,
                      ).fadeIn(delay: 600.ms),
                      
                      const SizedBox(height: 48),
                      
                      // Buttons
                      constraints.maxWidth > 768
                        ? Row(
                            children: [
                              _buildPrimaryButton(hero.primaryButton),
                              const SizedBox(width: 20),
                              _buildSecondaryButton(hero.secondaryButton),
                            ],
                          )
                        : Column(
                            children: [
                              _buildPrimaryButton(hero.primaryButton),
                              const SizedBox(height: 16),
                              _buildSecondaryButton(hero.secondaryButton),
                            ],
                          ).animate().slideY(
                        duration: 600.ms,
                        begin: 0.5,
                        curve: Curves.easeOutCubic,
                      ).fadeIn(delay: 800.ms),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Floating elements
              _buildFloatingElements(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundParticles() {
    return Positioned.fill(
      child: Stack(
        children: List.generate(20, (index) {
          final random = index * 137.5; // Golden angle
          return AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              final offset = (index % 2 == 0 ? 1 : -1) * 
                           _floatingController.value * 20;
              return Positioned(
                top: 100 + (index * 50) % (MediaQuery.of(context).size.height - 200),
                left: 50 + (index * 100) % (MediaQuery.of(context).size.width - 100),
                child: Transform.translate(
                  offset: Offset(0, offset),
                  child: Container(
                    width: 4 + (index % 4) * 2,
                    height: 4 + (index % 4) * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1 + (index % 3) * 0.1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildPrimaryButton(Button button) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleNavigation(button.link),
        child: Container(
          width: 180,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
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
          child: Center(
            child: Text(
              button.text,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),
    ).animate().scale(
      duration: 200.ms,
      curve: Curves.easeOutBack,
    ).then().shimmer(
      duration: 2000.ms,
      delay: 1000.ms,
    );
  }

  Widget _buildSecondaryButton(Button button) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleNavigation(button.link),
        child: Container(
          width: 180,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              button.text,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
      .animate().scale(
        duration: 300.ms,
        begin: Offset(1.0, 1.0),
        end: Offset(1.05, 1.05),
      );
  }

  Widget _buildFloatingElements() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Floating card 1
          AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              return Positioned(
                top: 100,
                right: 100,
                child: Transform.translate(
                  offset: Offset(0, _floatingController.value * 15),
                  child: GlassmorphicContainer(
                    width: 120,
                    height: 120,
                    borderRadius: 20,
                    blur: 10,
                    alignment: Alignment.center,
                    border: 1,
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    child: Icon(
                      Icons.code,
                      size: 40,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Floating card 2
          AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              return Positioned(
                bottom: 150,
                left: 80,
                child: Transform.translate(
                  offset: Offset(0, -_floatingController.value * 10),
                  child: GlassmorphicContainer(
                    width: 100,
                    height: 100,
                    borderRadius: 20,
                    blur: 10,
                    alignment: Alignment.center,
                    border: 1,
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    child: Icon(
                      Icons.design_services,
                      size: 35,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleNavigation(String link) {
    if (link.startsWith('#')) {
      final sectionId = link.substring(1);
      final scrollController = Provider.of<AppScrollController>(context, listen: false);
      
      // Calculate target offset based on section
      double targetOffset = 0;
      final screenHeight = MediaQuery.of(context).size.height;
      
      switch (sectionId) {
        case 'about':
          targetOffset = screenHeight * 0.9;
          break;
        case 'experience':
          targetOffset = screenHeight * 1.9;
          break;
        case 'projects':
          targetOffset = screenHeight * 2.9;
          break;
        case 'contact':
          targetOffset = screenHeight * 3.9;
          break;
      }
      
      scrollController.scrollTo(targetOffset);
    }
  }
}
