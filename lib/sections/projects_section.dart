import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/portfolio_models.dart';
import '../widgets/animated_header.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> 
    with TickerProviderStateMixin {
  late AnimationController _filterController;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _filterController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioData>(
      builder: (context, portfolioData, child) {
        final projects = portfolioData.projects;
        
        if (projects == null || projects.isEmpty) return const SizedBox.shrink();

        return Container(
          key: projectsKey,
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
              
              const SizedBox(height: 60),
              
              // Filter chips
              _buildFilterChips(),
              
              const SizedBox(height: 60),
              
              // Projects Grid
              _buildProjectsGrid(projects),
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
          'PROJECTS',
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

  Widget _buildFilterChips() {
    final filters = ['All', 'Featured', 'Web', 'Mobile', 'Full Stack'];
    
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((filter) {
        final isSelected = filter == _selectedFilter;
        
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
              _filterController.forward().then((_) {
                _filterController.reverse();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.purple.withOpacity(0.3),
                      ],
                    )
                  : null,
                border: Border.all(
                  color: isSelected
                    ? Colors.white.withOpacity(0.4)
                    : Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                    ? Colors.white.withOpacity(0.95)
                    : Colors.white.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ).animate().scale(
            duration: 200.ms,
            curve: Curves.easeOutBack,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectsGrid(List<Project> projects) {
    final filteredProjects = _getFilteredProjects(projects);
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200 ? 3 :
                              constraints.maxWidth > 768 ? 2 : 1;
        final childAspectRatio = constraints.maxWidth > 768 ? 1.2 : 1.0;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: filteredProjects.length,
          itemBuilder: (context, index) {
            final project = filteredProjects[index];
            return _buildProjectCard(project, index);
          },
        );
      },
    );
  }

  List<Project> _getFilteredProjects(List<Project> projects) {
    switch (_selectedFilter) {
      case 'Featured':
        return projects.where((p) => p.featured).toList();
      case 'Web':
        return projects.where((p) => 
          p.technologies.any((tech) => 
            ['React', 'Vue.js', 'Angular', 'HTML/CSS'].contains(tech)
          )
        ).toList();
      case 'Mobile':
        return projects.where((p) => 
          p.technologies.any((tech) => 
            ['Flutter', 'React Native', 'Swift', 'Kotlin'].contains(tech)
          )
        ).toList();
      case 'Full Stack':
        return projects.where((p) => 
          p.technologies.any((tech) => 
            ['Node.js', 'Express.js', 'Django', 'Flask'].contains(tech)
          )
        ).toList();
      default:
        return projects;
    }
  }

  Widget _buildProjectCard(Project project, int index) {
    final delay = (index * 100).ms;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 400,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image/Placeholder
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.withOpacity(0.2),
                      Colors.purple.withOpacity(0.2),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Placeholder icon
                    Center(
                      child: Icon(
                        Icons.code,
                        size: 48,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    
                    // Featured badge
                    if (project.featured)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.amber.withOpacity(0.8),
                                Colors.orange.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            'FEATURED',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Project Info
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      project.title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Description
                    Expanded(
                      child: Text(
                        project.description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Technologies
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: project.technologies.take(3).map((tech) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      )).toList(),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            'View Live',
                            Icons.launch,
                            () => _launchUrl(project.liveUrl),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            'Code',
                            Icons.code,
                            () => _launchUrl(project.githubUrl),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          duration: 2000.ms,
          delay: delay + 1000.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.02, 1.02),
        )
        .then()
        .shimmer(
          duration: 2000.ms,
          delay: delay + 2000.ms,
        ),
    ).animate().slideY(
      duration: 600.ms,
      delay: delay,
      begin: 0.3,
      curve: Curves.easeOutCubic,
    ).fadeIn(delay: delay);
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(width: 4),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
