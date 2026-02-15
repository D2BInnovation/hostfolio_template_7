'use client';

import { useEffect, useState } from 'react';
import { Hero } from '@/components/hero';
import { About } from '@/components/about';
import { Experience } from '@/components/experience';
import { Projects } from '@/components/projects';
import { Contact } from '@/components/contact';
import portfolioData from '../data.json';

interface PortfolioData {
  personal: {
    name: string;
    title: string;
    email: string;
    phone: string;
    location: string;
    website: string;
    linkedin: string;
    github: string;
    bio: string;
    resume?: string;
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
  about: {
    description: string[];
    skills: string[];
  };
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
  projects: Array<{
    id: number;
    title: string;
    description: string;
    technologies: string[];
    githubUrl: string;
    liveUrl: string;
    image: string;
    featured: boolean;
  }>;
  contact: {
    title: string;
    description: string;
    socialLinks: Array<{
      platform: string;
      url: string;
      icon: string;
    }>;
  };
}

export default function Home() {
  const [data, setData] = useState<PortfolioData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Use imported data directly for static export compatibility
    try {
      setData(portfolioData as PortfolioData);
    } catch (error) {
      console.error('Failed to load portfolio data:', error);
    } finally {
      setLoading(false);
    }
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center">
          <div className="inline-block">
            <div className="w-12 h-12 border-4 border-primary/20 border-t-primary rounded-full animate-spin" />
          </div>
          <p className="mt-4 text-foreground/60">Loading portfolio...</p>
        </div>
      </div>
    );
  }

  if (!data) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center">
          <p className="text-foreground/60">Failed to load portfolio data</p>
        </div>
      </div>
    );
  }

  return (
    <main className="relative bg-background overflow-hidden">
      {data.hero && <Hero data={data} />}
      {data.about && <About data={data} />}
      {data.experience && data.experience.length > 0 && <Experience data={data} />}
      {data.projects && data.projects.length > 0 && <Projects data={data} />}
      {data.contact && <Contact data={data} />}

      {/* Footer */}
      <footer className="border-t border-primary/20 py-8 px-4 bg-card/30">
        <div className="max-w-6xl mx-auto text-center text-sm text-foreground/60">
          <p>© {new Date().getFullYear()} {data.personal?.name || ''}. All rights reserved.</p>
        </div>
      </footer>
    </main>
  );
}
