import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/portfolio_models.dart';
import '../widgets/animated_header.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> 
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _skillController;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _skillController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final about = portfolioData.about;
        
        if (about == null) return const SizedBox.shrink();

        return Container(
          key: aboutKey,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F172A),
                const Color(0xFF1E293B).withOpacity(0.8),
              ],
            ),
        ),
          child: Column(
            children: [
              // Section Header
              _buildSectionHeader(),
              
              const SizedBox(height: 80),
              
              // Content Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 768) {
                    // Desktop layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Content
                        Expanded(
                          flex: 3,
                          child: _buildAboutContent(about),
                        ),
                        const SizedBox(width: 60),
                        // Skills
                        Expanded(
                          flex: 2,
                          child: _buildSkillsSection(about.skills),
                        ),
                      ],
                    );
                  } else {
                    // Mobile layout
                    return Column(
                      children: [
                        _buildAboutContent(about),
                        const SizedBox(height: 60),
                        _buildSkillsSection(about.skills),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'ABOUT ME',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 2,
          ),
        ).animate().slideY(
          duration: 600.ms,
          begin: -0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(),
        
        const SizedBox(height: 16),
        
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.purple.withOpacity(0.8),
              ],
            ),
          ),
        ).animate().scaleX(
          duration: 800.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
    );
  }

  Widget _buildAboutContent(About about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description paragraphs
        ...about.description.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          
          return Padding(
            padding: EdgeInsets.only(bottom: index < about.description.length - 1 ? 24 : 0),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.8),
                height: 1.8,
              ),
            ),
          ).animate().slideX(
            duration: 600.ms,
            delay: (index * 100).ms,
            begin: -0.3,
            curve: Curves.easeOutCubic,
          ).fadeIn(delay: (index * 100).ms);
        }).toList(),
        
        const SizedBox(height: 40),
        
        // Stats cards
        _buildStatsCards(),
      ],
    );
  }

  Widget _buildStatsCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 768 
          ? (constraints.maxWidth - 40) / 3 
          : constraints.maxWidth;
        
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildStatCard('5+', 'Years Experience', Icons.work),
            _buildStatCard('50+', 'Projects Completed', Icons.code),
            _buildStatCard('15+', 'Happy Clients', Icons.people),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GlassmorphicContainer(
        width: double.infinity,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white.withOpacity(0.7),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          duration: 2000.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.02, 1.02),
        )
        .then()
        .shimmer(
          duration: 2000.ms,
          delay: 1000.ms,
        ),
    );
  }

  Widget _buildSkillsSection(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SKILLS',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 2,
          ),
        ).animate().slideY(
          duration: 600.ms,
          begin: -0.3,
          curve: Curves.easeOutCubic,
        ).fadeIn(),
        
        const SizedBox(height: 24),
        
        // Skills grid
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            
            return _buildSkillChip(skill, index);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          skill,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 0.5,
          ),
        ),
      ).animate().scale(
        duration: 300.ms,
        delay: (index * 50).ms,
        curve: Curves.easeOutBack,
      ).fadeIn(delay: (index * 50).ms),
    );
  }
}
