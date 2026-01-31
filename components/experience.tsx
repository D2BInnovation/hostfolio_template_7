'use client';

import { useInView } from '@/hooks/use-in-view';
import { useRef } from 'react';
import { Badge } from '@/components/ui/badge';

interface ExperienceProps {
  data: {
    experience: Array<{
      id: number;
      company: string;
      position: string;
      duration: string;
      location: string;
      description: string;
      achievements: string[];
      technologies: string[];
    }>;
  };
}

export function Experience({ data }: ExperienceProps) {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref);

  return (
    <section className="py-20 px-4 relative overflow-hidden">
      {/* Background */}
      <div className="absolute top-0 left-0 w-96 h-96 bg-accent/10 rounded-full blur-3xl -z-10" />

      <div ref={ref} className="max-w-6xl mx-auto">
        <div className="mb-16">
          <h2
            className={`text-4xl md:text-5xl font-bold text-foreground mb-4 transition-all duration-700 ${
              isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
            }`}
          >
            Experience
          </h2>
          <div className="h-1 w-20 bg-gradient-to-r from-primary to-accent rounded-full" />
        </div>

        {/* Timeline */}
        <div className="space-y-12">
          {data.experience.map((job, index) => (
            <div
              key={job.id}
              className={`relative pl-8 transition-all duration-700 ${
                isInView ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-10'
              }`}
              style={{ transitionDelay: `${index * 150}ms` }}
            >
              {/* Timeline dot */}
              <div className="absolute left-0 top-0 w-4 h-4 bg-primary rounded-full shadow-lg shadow-primary/50 mt-2" />

              {/* Timeline line */}
              {index !== data.experience.length - 1 && (
                <div className="absolute left-2 top-6 w-0.5 h-24 bg-gradient-to-b from-primary/50 to-primary/10" />
              )}

              {/* Content */}
              <div className="bg-card/40 hover:bg-card/60 border border-primary/20 hover:border-primary/50 rounded-lg p-6 backdrop-blur-sm transition-all duration-300 hover:shadow-lg hover:shadow-primary/20">
                <div className="flex flex-col md:flex-row md:items-start md:justify-between mb-3">
                  <div>
                    <h3 className="text-xl font-bold text-foreground">{job.position}</h3>
                    <p className="text-primary font-semibold">{job.company}</p>
                  </div>
                  <span className="text-sm text-muted-foreground mt-2 md:mt-0">
                    {job.duration}
                  </span>
                </div>

                <p className="text-sm text-muted-foreground mb-4">{job.location}</p>
                <p className="text-foreground/80 mb-4">{job.description}</p>

                {/* Achievements */}
                <div className="mb-4">
                  <h4 className="text-sm font-semibold text-foreground mb-2">Key Achievements:</h4>
                  <ul className="text-sm text-foreground/70 space-y-1">
                    {job.achievements.map((achievement, i) => (
                      <li key={i} className="flex items-start">
                        <span className="text-primary mr-2">▸</span>
                        <span>{achievement}</span>
                      </li>
                    ))}
                  </ul>
                </div>

                {/* Tech Stack */}
                <div className="flex flex-wrap gap-2">
                  {job.technologies.map((tech, i) => (
                    <Badge key={i} variant="secondary" className="bg-primary/10 text-primary">
                      {tech}
                    </Badge>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
