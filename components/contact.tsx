'use client';

import React from "react"

import { useRef } from 'react';
import { Button } from '@/components/ui/button';
import { useInView } from '@/hooks/use-in-view';
import {
  Github,
  Linkedin,
  Mail,
  ExternalLink,
  Phone,
  MapPin,
} from 'lucide-react';

interface ContactProps {
  data: {
    personal: {
      email: string;
      phone: string;
      location: string;
    };
    contact: {
      title: string;
      description: string;
      socialLinks: Array<{
        platform: string;
        url: string;
        icon: string;
      }>;
    };
  };
}

const iconMap: Record<string, React.ReactNode> = {
  github: <Github className="w-6 h-6" />,
  linkedin: <Linkedin className="w-6 h-6" />,
  twitter: (
    <svg
      className="w-6 h-6"
      fill="currentColor"
      viewBox="0 0 24 24"
      aria-hidden="true"
    >
      <path d="M8.29 20c7.547 0 11.674-6.25 11.674-11.674 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-7.593 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
    </svg>
  ),
  email: <Mail className="w-6 h-6" />,
};

export function Contact({ data }: ContactProps) {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref);

  return (
    <section id="contact" className="py-20 px-4 relative overflow-hidden">
      {/* Background */}
      <div className="absolute top-0 right-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl -z-10" />
      <div className="absolute bottom-0 left-0 w-96 h-96 bg-accent/10 rounded-full blur-3xl -z-10" />

      <div ref={ref} className="max-w-4xl mx-auto">
        {/* Header */}
        <div
          className={`text-center mb-16 transition-all duration-700 ${
            isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
          }`}
        >
          <h2 className="text-4xl md:text-5xl font-bold text-foreground mb-4">
            {data.contact.title}
          </h2>
          <div className="h-1 w-20 bg-gradient-to-r from-primary to-accent rounded-full mx-auto mb-6" />
          <p className="text-lg text-foreground/80 max-w-2xl mx-auto">
            {data.contact.description}
          </p>
        </div>

        {/* Contact info */}
        <div className="grid md:grid-cols-3 gap-6 mb-16">
          {/* Email */}
          <div
            className={`group p-6 bg-card/40 hover:bg-card/60 border border-primary/20 hover:border-primary/50 rounded-lg backdrop-blur-sm text-center transition-all duration-700 hover:shadow-lg hover:shadow-primary/20 ${
              isInView ? 'opacity-100 scale-100' : 'opacity-0 scale-95'
            }`}
            style={{ transitionDelay: '0ms' }}
          >
            <Mail className="w-8 h-8 text-primary mx-auto mb-4 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground mb-2">Email</h3>
            <a
              href={`mailto:${data.personal.email}`}
              className="text-primary hover:text-accent transition-colors text-sm"
            >
              {data.personal.email}
            </a>
          </div>

          {/* Phone */}
          <div
            className={`group p-6 bg-card/40 hover:bg-card/60 border border-primary/20 hover:border-primary/50 rounded-lg backdrop-blur-sm text-center transition-all duration-700 hover:shadow-lg hover:shadow-primary/20 ${
              isInView ? 'opacity-100 scale-100' : 'opacity-0 scale-95'
            }`}
            style={{ transitionDelay: '100ms' }}
          >
            <Phone className="w-8 h-8 text-primary mx-auto mb-4 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground mb-2">Phone</h3>
            <a
              href={`tel:${data.personal.phone}`}
              className="text-primary hover:text-accent transition-colors text-sm"
            >
              {data.personal.phone}
            </a>
          </div>

          {/* Location */}
          <div
            className={`group p-6 bg-card/40 hover:bg-card/60 border border-primary/20 hover:border-primary/50 rounded-lg backdrop-blur-sm text-center transition-all duration-700 hover:shadow-lg hover:shadow-primary/20 ${
              isInView ? 'opacity-100 scale-100' : 'opacity-0 scale-95'
            }`}
            style={{ transitionDelay: '200ms' }}
          >
            <MapPin className="w-8 h-8 text-primary mx-auto mb-4 group-hover:scale-110 transition-transform" />
            <h3 className="font-semibold text-foreground mb-2">Location</h3>
            <p className="text-primary text-sm">{data.personal.location}</p>
          </div>
        </div>

        {/* Social Links */}
        <div className="flex flex-wrap gap-4 justify-center mb-12">
          {data.contact.socialLinks.map((link, index) => (
            <a
              key={index}
              href={link.url}
              target="_blank"
              rel="noopener noreferrer"
              className={`group p-4 bg-card/40 hover:bg-primary border border-primary/20 hover:border-primary rounded-lg backdrop-blur-sm transition-all duration-700 hover:shadow-lg hover:shadow-primary/20 ${
                isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
              }`}
              style={{ transitionDelay: `${(index + 3) * 100}ms` }}
            >
              <div className="text-primary group-hover:text-primary-foreground transition-colors">
                {iconMap[link.icon] || <ExternalLink className="w-6 h-6" />}
              </div>
            </a>
          ))}
        </div>

        {/* CTA Button */}
        <div
          className={`text-center transition-all duration-700 ${
            isInView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
          }`}
          style={{ transitionDelay: '700ms' }}
        >
          <a href={`mailto:${data.personal.email}`}>
            <Button size="lg" className="bg-primary hover:bg-primary/90 text-primary-foreground">
              Send Me an Email
              <ExternalLink className="ml-2 w-4 h-4" />
            </Button>
          </a>
        </div>
      </div>
    </section>
  );
}
