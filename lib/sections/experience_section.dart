import 'package:flutter/material.dart';
import 'dart:ui' as imageUrl;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/portfolio_models.dart';
import '../widgets/animated_header.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> 
    with TickerProviderStateMixin {
  late AnimationController _timelineController;
  late AnimationController _cardController;

  @override
  void initState() {
    super.initState();
    _timelineController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _timelineController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final experience = portfolioData.experience;
        
        if (experience == null || experience.isEmpty) return const SizedBox.shrink();

        return Container(
          key: experienceKey,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1E293B).withOpacity(0.8),
                const Color(0xFF0F172A),
              ],
            ),
          ),
          child: Column(
            children: [
              // Section Header
              _buildSectionHeader(),
              
              const SizedBox(height: 80),
              
              // Timeline
              _buildTimeline(experience),
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
          'EXPERIENCE',
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

  Widget _buildTimeline(List<Experience> experiences) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 768;
        
        return Stack(
          children: [
            // Timeline line
            if (isDesktop)
              Positioned(
                left: constraints.maxWidth / 2 - 1,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.purple.withOpacity(0.3),
                      ],
                    ),
                  ),
                ).animate().scaleY(
                  duration: 1500.ms,
                  curve: Curves.easeOutCubic,
                ),
              ),
            
            // Experience cards
            Column(
              children: experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                final isLeft = index % 2 == 0;
                
                return _buildExperienceCard(exp, index, isLeft, isDesktop, experiences);
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExperienceCard(Experience exp, int index, bool isLeft, bool isDesktop, List<Experience> experiences) {
    final delay = (index * 200).ms;
    
    if (isDesktop) {
      // Desktop layout with alternating sides
      return Padding(
        padding: EdgeInsets.only(bottom: index < experiences.length - 1 ? 80 : 0), // Increased spacing
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to top
          children: [
            if (isLeft) ...[
              Expanded(
                child: _buildCard(exp, index, delay, isLeft),
              ),
              const SizedBox(width: 60),
              _buildTimelineDot(index),
              const SizedBox(width: 60),
              const Expanded(child: SizedBox()),
            ] else ...[
              const Expanded(child: SizedBox()),
              const SizedBox(width: 60),
              _buildTimelineDot(index),
              const SizedBox(width: 60),
              Expanded(
                child: _buildCard(exp, index, delay, isLeft),
              ),
            ],
          ],
        ),
      );
    } else {
      // Mobile layout - stacked
      return Padding(
        padding: EdgeInsets.only(bottom: index < experiences.length - 1 ? 40 : 0),
        child: _buildCard(exp, index, delay, true),
      );
    }
  }

  Widget _buildTimelineDot(int index) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.purple.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    ).animate().scale(
      duration: 400.ms,
      delay: (index * 200).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildCard(Experience exp, int index, Duration delay, bool isLeft) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: imageUrl.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.02),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Allow column to size itself
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.position,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp.company,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                          exp.duration,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white.withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        exp.location,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Description
                  Text(
                    exp.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Achievements
                  if (exp.achievements.isNotEmpty) ...[
                    Text(
                      'Key Achievements:',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...exp.achievements.map((achievement) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.8),
                                  Colors.purple.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              achievement,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.7),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 20),
                  ],
                  
                  // Technologies
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: exp.technologies.map((tech) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tech,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().slideX(
      duration: 600.ms,
      delay: delay,
      begin: isLeft ? -0.3 : 0.3,
      curve: Curves.easeOutCubic,
    ).fadeIn(delay: delay);
  }
}
