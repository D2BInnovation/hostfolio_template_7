'use client';

import { useEffect, useRef } from 'react';
import { Button } from '@/components/ui/button';
import { ArrowRight } from 'lucide-react';

interface HeroProps {
  data: {
    personal: {
      name: string;
      title: string;
      bio: string;
    };
    hero: {
      greeting: string;
      description: string;
      primaryButton: {
        text: string;
        link: string;
      };
      secondaryButton: {
        text: string;
        link: string;
      };
    };
  };
}

export function Hero({ data }: HeroProps) {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const handleMouseMove = (e: MouseEvent) => {
      const rect = container.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      const moveX = (x - rect.width / 2) * 0.02;
      const moveY = (y - rect.height / 2) * 0.02;

      container.style.transform = `perspective(1000px) rotateX(${moveY}deg) rotateY(${moveX}deg)`;
    };

    const handleMouseLeave = () => {
      container.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg)';
    };

    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('mouseleave', handleMouseLeave);

    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseleave', handleMouseLeave);
    };
  }, []);

  return (
    <section className="min-h-screen flex items-center justify-center relative overflow-hidden px-4 py-20">
      {/* Animated background */}
      <div className="absolute inset-0 -z-10">
        <div className="absolute top-20 left-10 w-72 h-72 bg-primary/20 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-20 right-10 w-72 h-72 bg-accent/20 rounded-full blur-3xl animate-pulse delay-1000" />
      </div>

      <div ref={containerRef} className="w-full max-w-4xl transition-transform duration-300">
        <div className="text-center space-y-8 animate-fade-in">
          {/* Greeting */}
          <div className="inline-block">
            <span className="text-sm font-semibold text-accent uppercase tracking-widest animate-slide-up">
              {data.hero.greeting}
            </span>
          </div>

          {/* Main Title */}
          <div>
            <h1 className="text-5xl md:text-7xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-primary via-primary to-accent mb-4 animate-slide-up leading-tight">
              {data.personal.name}
            </h1>
            <p className="text-xl md:text-2xl text-muted-foreground font-medium animate-slide-up">
              {data.personal.title}
            </p>
          </div>

          {/* Description */}
          <p className="text-lg md:text-xl text-foreground/80 max-w-2xl mx-auto leading-relaxed animate-slide-up">
            {data.hero.description}
          </p>

          {/* Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4 animate-slide-up">
            <a href={data.hero.primaryButton.link}>
              <Button
                size="lg"
                className="group bg-primary hover:bg-primary/90 text-primary-foreground px-8"
              >
                {data.hero.primaryButton.text}
                <ArrowRight className="ml-2 w-4 h-4 group-hover:translate-x-1 transition-transform" />
              </Button>
            </a>
            <a href={data.hero.secondaryButton.link}>
              <Button
                size="lg"
                variant="outline"
                className="border-primary/50 hover:border-primary text-foreground bg-transparent"
              >
                {data.hero.secondaryButton.text}
              </Button>
            </a>
          </div>

          {/* Scroll indicator */}
          <div className="pt-12 animate-bounce">
            <svg
              className="w-6 h-6 mx-auto text-accent"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path d="M19 14l-7 7m0 0l-7-7m7 7V3" />
            </svg>
          </div>
        </div>
      </div>

      <style>{`
        @keyframes fade-in {
          from {
            opacity: 0;
          }
          to {
            opacity: 1;
          }
        }

        @keyframes slide-up {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        .animate-fade-in {
          animation: fade-in 0.6s ease-out;
        }

        .animate-slide-up {
          animation: slide-up 0.6s ease-out forwards;
        }

        .animate-slide-up:nth-child(1) {
          animation-delay: 0.1s;
        }

        .animate-slide-up:nth-child(2) {
          animation-delay: 0.2s;
        }

        .animate-slide-up:nth-child(3) {
          animation-delay: 0.3s;
        }

        .animate-slide-up:nth-child(4) {
          animation-delay: 0.4s;
        }

        .delay-1000 {
          animation-delay: 1000ms;
        }
      `}</style>
    </section>
  );
}
