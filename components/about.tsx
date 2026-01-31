'use client';

import { useInView } from '@/hooks/use-in-view';
import { useRef } from 'react';

interface AboutProps {
  data: {
    personal: {
      bio: string;
    };
    about: {
      description: string[];
      skills: string[];
    };
  };
}

export function About({ data }: AboutProps) {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref);

  return (
    <section id="about" className="py-20 px-4 relative overflow-hidden">
      {/* Background elements */}
      <div className="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl -z-10" />
      <div className="absolute bottom-0 left-0 w-96 h-96 bg-accent/10 rounded-full blur-3xl -z-10" />

      <div ref={ref} className="max-w-6xl mx-auto">
        <div className="grid md:grid-cols-2 gap-12 items-center">
          {/* Left content */}
          <div className="space-y-6">
            <div>
              <h2
                className={`text-4xl md:text-5xl font-bold text-foreground mb-4 transition-all duration-700 ${
                  isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
                }`}
              >
                About Me
              </h2>
              <div className="h-1 w-20 bg-gradient-to-r from-primary to-accent rounded-full" />
            </div>

            {data.about.description.map((text, index) => (
              <p
                key={index}
                className={`text-lg text-foreground/80 leading-relaxed transition-all duration-700 ${
                  isInView ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-10'
                }`}
                style={{ transitionDelay: `${(index + 1) * 100}ms` }}
              >
                {text}
              </p>
            ))}
          </div>

          {/* Right content - Skills */}
          <div>
            <h3
              className={`text-2xl font-bold text-foreground mb-6 transition-all duration-700 ${
                isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
              }`}
            >
              Skills & Technologies
            </h3>
            <div className="grid grid-cols-2 gap-3">
              {data.about.skills.map((skill, index) => (
                <div
                  key={index}
                  className={`group cursor-pointer transition-all duration-300 ${
                    isInView ? 'opacity-100 scale-100' : 'opacity-0 scale-95'
                  }`}
                  style={{ transitionDelay: `${index * 30}ms` }}
                >
                  <div className="p-4 bg-card/50 hover:bg-card border border-primary/20 hover:border-primary/50 rounded-lg backdrop-blur-sm transition-all duration-300 group-hover:shadow-lg group-hover:shadow-primary/20">
                    <span className="text-sm font-medium text-foreground group-hover:text-primary transition-colors">
                      {skill}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
