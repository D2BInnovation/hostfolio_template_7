import React from "react"
import type { Metadata } from 'next'
import { Geist, Geist_Mono } from 'next/font/google'
import { Analytics } from '@vercel/analytics/next'
import Script from 'next/script'
import './globals.css'


const _geist = Geist({ subsets: ["latin"] });
const _geistMono = Geist_Mono({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: 'My Portfolio',
  description: 'My Portfolio',
  generator: 'HostFolio',
  icons: {
    icon: [
      {
        url: '/favicon-32x32.png',
        media: '(prefers-color-scheme: light)',
      },
      {
        url: '/favicon-32x32.png',
        media: '(prefers-color-scheme: dark)',
      },
      {
        url: '/favicon-32x32.png',
        type: 'image/png',
      },
    ],
    apple: '/apple-touch-icon.png',
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" className="dark">
      <body className={`font-sans antialiased`}>
        {children}
        <Analytics />
        <Script id="hostfolio-native-fixes" strategy="afterInteractive">
          {`
            (function() {
              async function updateTitle() {
                try {
                  const response = await fetch('./data.json');
                  if (!response.ok) throw new Error('data.json not found');
                  const data = await response.json();
                  if (data.personal && data.personal.name) {
                    document.title = data.personal.name + ' | Portfolio';
                  }
                } catch (e) {
                  console.log('Title update skipped:', e.message);
                }
              }
              updateTitle();
              window.addEventListener('error', function(e) {
                if (e.target.tagName === 'IMG') {
                  const img = e.target;
                  if (img.dataset.fallbackApplied) return;
                  img.dataset.fallbackApplied = 'true';
                  img.style.display = 'none';
                  const placeholder = document.createElement('div');
                  placeholder.style.cssText = 'display:flex;align-items:center;justify-content:center;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:12px;width:100%;height:100%;min-height:100px;';
                  placeholder.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="opacity:0.3"><rect width="18" height="18" x="3" y="3" rx="2" ry="2"/><circle cx="9" cy="9" r="2"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/></svg>';
                  img.parentNode.insertBefore(placeholder, img);
                }
              }, true);
            })();
          `}
        </Script>
      </body>
    </html>

  )
}
