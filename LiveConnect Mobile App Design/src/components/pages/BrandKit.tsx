import { Download } from 'lucide-react';
import { motion } from 'motion/react';
import StarLogo from '../shared/StarLogo';

export default function BrandKit() {
  const colors = [
    { name: 'Primary Gradient Start', hex: '#8A2BE2', rgb: 'rgb(138, 43, 226)' },
    { name: 'Primary Gradient End', hex: '#FF007F', rgb: 'rgb(255, 0, 127)' },
    { name: 'Accent Blue', hex: '#4B9EFF', rgb: 'rgb(75, 158, 255)' },
    { name: 'Background Black', hex: '#0E0E0E', rgb: 'rgb(14, 14, 14)' },
    { name: 'Card Background', hex: '#1A1A1F', rgb: 'rgb(26, 26, 31)' },
    { name: 'Text Primary', hex: '#FFFFFF', rgb: 'rgb(255, 255, 255)' },
    { name: 'Text Secondary', hex: '#A0A0A0', rgb: 'rgb(160, 160, 160)' },
  ];

  const typography = [
    { level: 'H1 - Display', size: '32px', weight: '700', sample: 'LiveStar' },
    { level: 'H2 - Heading', size: '24px', weight: '600', sample: 'Go Live Now' },
    { level: 'H3 - Subheading', size: '18px', weight: '600', sample: 'Trending Streams' },
    { level: 'Body Large', size: '16px', weight: '500', sample: 'Watch live streams and connect' },
    { level: 'Body', size: '14px', weight: '400', sample: 'Start streaming to your fans' },
    { level: 'Caption', size: '12px', weight: '400', sample: '2.3K viewers • Live now' },
  ];

  return (
    <div className="min-h-screen bg-[#0E0E0E] overflow-y-auto">
      <div className="max-w-[1400px] mx-auto px-8 py-12">
        {/* Header */}
        <div className="mb-12">
          <h1 className="text-white mb-4">LiveStar Brand Kit</h1>
          <p className="text-white/60">
            Official branding guidelines and assets for LiveStar - The ultimate live streaming platform
          </p>
        </div>

        {/* Logo Section */}
        <section className="mb-16">
          <h2 className="text-white mb-6">Logo Variations</h2>
          
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
            {/* Full Logo - Gradient */}
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center justify-center min-h-[300px]"
            >
              <div className="mb-4 flex items-center gap-4">
                {/* Star Icon */}
                <div className="relative flex items-center justify-center">
                  <div className="absolute inset-0 bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] opacity-40 blur-xl rounded-full" />
                  <StarLogo size={64} />
                </div>
                
                {/* Text */}
                <div>
                  <div className="text-5xl bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] bg-clip-text text-transparent" style={{ fontWeight: 800 }}>
                    LiveStar
                  </div>
                </div>
              </div>
              <p className="text-white/60 text-sm">Full Logo - Gradient (Primary)</p>
              <button className="mt-4 px-4 py-2 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white text-sm flex items-center gap-2 transition-colors">
                <Download className="w-4 h-4" />
                Download SVG
              </button>
            </motion.div>

            {/* Icon Only - Gradient */}
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center justify-center min-h-[300px]"
            >
              <div className="mb-4 relative w-32 h-32 flex items-center justify-center">
                <div className="absolute inset-0 bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] opacity-50 blur-2xl rounded-full" />
                <StarLogo size={120} />
              </div>
              <p className="text-white/60 text-sm">Icon Only - App Launcher</p>
              <button className="mt-4 px-4 py-2 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white text-sm flex items-center gap-2 transition-colors">
                <Download className="w-4 h-4" />
                Download PNG
              </button>
            </motion.div>

            {/* Logo on White Background */}
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
              className="bg-white border border-gray-200 rounded-3xl p-8 flex flex-col items-center justify-center min-h-[300px]"
            >
              <div className="mb-4 flex items-center gap-4">
                {/* Star Icon */}
                <StarLogo size={64} />
                
                {/* Text */}
                <div className="text-5xl bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] bg-clip-text text-transparent" style={{ fontWeight: 800 }}>
                  LiveStar
                </div>
              </div>
              <p className="text-gray-600 text-sm">For Light Backgrounds</p>
              <button className="mt-4 px-4 py-2 bg-gray-100 hover:bg-gray-200 border border-gray-200 rounded-xl text-gray-700 text-sm flex items-center gap-2 transition-colors">
                <Download className="w-4 h-4" />
                Download SVG
              </button>
            </motion.div>

            {/* Monochrome White Version */}
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center justify-center min-h-[300px]"
            >
              <div className="mb-4 flex items-center gap-4">
                {/* Star Icon */}
                <div className="w-16 h-16 rounded-full bg-white flex items-center justify-center">
                  <StarLogo size={48} />
                </div>
                
                {/* Text */}
                <div className="text-5xl text-white" style={{ fontWeight: 800 }}>
                  LiveStar
                </div>
              </div>
              <p className="text-white/60 text-sm">Monochrome White</p>
              <button className="mt-4 px-4 py-2 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white text-sm flex items-center gap-2 transition-colors">
                <Download className="w-4 h-4" />
                Download SVG
              </button>
            </motion.div>
          </div>

          {/* App Icon Mockup */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center"
            >
              <div className="w-40 h-40 rounded-[32px] bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] flex items-center justify-center shadow-2xl shadow-purple-500/30 mb-4">
                <div className="text-white text-7xl">⭐</div>
              </div>
              <p className="text-white text-sm mb-1">App Icon</p>
              <p className="text-white/60 text-xs">1024×1024px</p>
            </motion.div>

            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.5 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center"
            >
              <div className="w-40 h-40 rounded-full bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] flex items-center justify-center shadow-2xl shadow-purple-500/30 mb-4">
                <div className="text-white text-6xl">⭐</div>
              </div>
              <p className="text-white text-sm mb-1">Favicon</p>
              <p className="text-white/60 text-xs">Circle variant</p>
            </motion.div>

            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.6 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-3xl p-8 flex flex-col items-center"
            >
              <div className="w-40 h-40 rounded-2xl bg-white/5 backdrop-blur-md flex items-center justify-center mb-4 border border-white/10">
                <div className="opacity-60">
                  <StarLogo size={60} />
                </div>
              </div>
              <p className="text-white text-sm mb-1">Watermark</p>
              <p className="text-white/60 text-xs">For video overlays</p>
            </motion.div>
          </div>
        </section>

        {/* Color Palette */}
        <section className="mb-16">
          <h2 className="text-white mb-6">Color Palette</h2>
          
          <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-4">
            {colors.map((color, index) => (
              <motion.div
                key={color.hex}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: index * 0.05 }}
                className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl p-4"
              >
                <div 
                  className="w-full h-24 rounded-xl mb-3 border-2 border-white/20"
                  style={{ backgroundColor: color.hex }}
                />
                <p className="text-white text-sm mb-2">{color.name}</p>
                <p className="text-white/60 text-xs font-mono mb-1">{color.hex}</p>
                <p className="text-white/40 text-xs font-mono">{color.rgb}</p>
              </motion.div>
            ))}
          </div>

          {/* Gradient Showcase */}
          <div className="mt-6 bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl p-8">
            <p className="text-white/60 text-sm mb-4">Primary Gradient</p>
            <div className="h-32 rounded-2xl bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] shadow-[0_0_40px_rgba(138,43,226,0.4)]" />
            <div className="mt-4 flex items-center justify-between">
              <code className="text-white/80 text-sm font-mono">
                background: linear-gradient(to right, #8A2BE2, #FF007F)
              </code>
              <button className="px-4 py-2 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white text-sm transition-colors">
                Copy CSS
              </button>
            </div>
          </div>
        </section>

        {/* Typography */}
        <section className="mb-16">
          <h2 className="text-white mb-6">Typography</h2>
          
          <div className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl p-8">
            <div className="mb-6">
              <p className="text-white/60 text-sm mb-2">Font Family</p>
              <p className="text-white text-2xl">Poppins, system-ui, -apple-system, sans-serif</p>
            </div>

            <div className="space-y-6">
              {typography.map((type, index) => (
                <motion.div
                  key={type.level}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: index * 0.05 }}
                  className="border-t border-white/10 pt-6 first:border-t-0 first:pt-0"
                >
                  <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div className="flex-1">
                      <p className="text-white/60 text-sm mb-1">{type.level}</p>
                      <p className="text-white/40 text-xs">{type.size} • Weight {type.weight}</p>
                    </div>
                    <div className="flex-1">
                      <p 
                        className="text-white"
                        style={{ 
                          fontSize: type.size, 
                          fontWeight: type.weight 
                        }}
                      >
                        {type.sample}
                      </p>
                    </div>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* UI Components Preview */}
        <section className="mb-16">
          <h2 className="text-white mb-6">UI Components</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Buttons */}
            <div className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl p-8">
              <p className="text-white mb-4">Buttons</p>
              <div className="space-y-4">
                <button className="w-full py-4 rounded-2xl bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] text-white shadow-[0_0_20px_rgba(138,43,226,0.4)] hover:shadow-[0_0_30px_rgba(138,43,226,0.6)] transition-all">
                  Primary Button
                </button>
                <button className="w-full py-4 rounded-2xl bg-white/5 border border-white/10 text-white hover:bg-white/10 transition-all">
                  Secondary Button
                </button>
                <button className="w-full py-4 rounded-2xl bg-[#4B9EFF]/10 border border-[#4B9EFF]/30 text-[#4B9EFF] hover:bg-[#4B9EFF]/20 transition-all">
                  Accent Button
                </button>
              </div>
            </div>

            {/* Cards */}
            <div className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl p-8">
              <p className="text-white mb-4">Cards</p>
              <div className="space-y-4">
                <div className="bg-white/5 backdrop-blur-md border border-white/10 rounded-2xl p-6">
                  <p className="text-white mb-2">Glassmorphism Card</p>
                  <p className="text-white/60 text-sm">With backdrop blur effect</p>
                </div>
                <div className="bg-gradient-to-br from-[#8A2BE2]/10 to-[#FF007F]/10 border border-[#8A2BE2]/30 rounded-2xl p-6">
                  <p className="text-white mb-2">Gradient Card</p>
                  <p className="text-white/60 text-sm">For highlights and features</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Usage Examples */}
        <section>
          <h2 className="text-white mb-6">Usage Examples</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Splash Screen Example */}
            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: 0.2 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl overflow-hidden"
            >
              <div className="p-4 border-b border-white/10">
                <p className="text-white text-sm">Splash Screen</p>
              </div>
              <div className="aspect-[9/16] bg-gradient-to-br from-[#0E0E0E] via-[#8A2BE2]/20 to-[#0E0E0E] flex flex-col items-center justify-center">
                <div className="relative mb-6">
                  <div className="absolute inset-0 bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] opacity-60 blur-3xl" />
                  <div className="relative">
                    <StarLogo size={120} />
                  </div>
                </div>
                <h1 className="text-white text-3xl mb-2 bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] bg-clip-text text-transparent">LiveStar</h1>
                <p className="text-white/60">Live Streaming Platform</p>
              </div>
            </motion.div>

            {/* Navigation Bar Example */}
            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: 0.3 }}
              className="bg-gradient-to-br from-[#1A1A1F] to-[#0E0E0E] border border-white/10 rounded-2xl overflow-hidden"
            >
              <div className="p-4 border-b border-white/10">
                <p className="text-white text-sm">App Header</p>
              </div>
              <div className="aspect-[9/16] bg-[#0E0E0E] p-6">
                <div className="flex items-center justify-between mb-8">
                  <div className="flex items-center gap-2">
                    <StarLogo size={32} />
                    <span className="text-xl bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] bg-clip-text text-transparent" style={{ fontWeight: 800 }}>
                      LiveStar
                    </span>
                  </div>
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 rounded-full bg-white/10" />
                    <div className="w-8 h-8 rounded-full bg-white/10" />
                  </div>
                </div>
                <div className="space-y-4">
                  <div className="h-20 bg-white/5 rounded-2xl border border-white/10" />
                  <div className="h-32 bg-white/5 rounded-2xl border border-white/10" />
                  <div className="h-20 bg-white/5 rounded-2xl border border-white/10" />
                </div>
              </div>
            </motion.div>
          </div>
        </section>

        {/* Download Section */}
        <section className="mt-16">
          <div className="bg-gradient-to-r from-[#8A2BE2] to-[#FF007F] rounded-3xl p-12 text-center">
            <h2 className="text-white mb-4">Download Complete Brand Kit</h2>
            <p className="text-white/90 mb-8 max-w-2xl mx-auto">
              Get all logo variations, color swatches, typography guidelines, and UI component templates in a single package.
            </p>
            <button className="px-8 py-4 bg-white text-[#8A2BE2] rounded-2xl hover:shadow-2xl transition-all flex items-center gap-3 mx-auto">
              <Download className="w-5 h-5" />
              Download Brand Kit (ZIP)
            </button>
          </div>
        </section>
      </div>
    </div>
  );
}
