// Simple PNG-based StarLogo component for LiveStar branding

interface StarLogoProps {
  size?: number;
  className?: string;
}

export default function StarLogo({ 
  size = 64,
  className = ''
}: StarLogoProps) {
  // Using a simple star emoji/icon with gradient background
  return (
    <div 
      className={`relative flex items-center justify-center ${className}`}
      style={{ width: size, height: size }}
    >
      {/* Gradient background circle */}
      <div 
        className="absolute inset-0 rounded-full bg-gradient-to-br from-[#8A2BE2] to-[#FF007F]"
        style={{ width: size, height: size }}
      />
      
      {/* Star icon overlay */}
      <div 
        className="relative z-10 flex items-center justify-center text-white"
        style={{ fontSize: size * 0.6 }}
      >
        ⭐
      </div>
    </div>
  );
}
