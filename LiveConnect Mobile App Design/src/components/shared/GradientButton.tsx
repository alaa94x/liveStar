import { ButtonHTMLAttributes } from 'react';
import { motion } from 'motion/react';

interface GradientButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary';
  glow?: boolean;
}

export default function GradientButton({ 
  children, 
  variant = 'primary', 
  glow = true,
  className = '',
  ...props 
}: GradientButtonProps) {
  const baseClasses = "relative px-8 py-3 rounded-full overflow-hidden transition-all duration-300";
  
  const gradientClasses = variant === 'primary' 
    ? "bg-gradient-to-r from-[#C700FF] to-[#FF2D92]"
    : "bg-white/10 backdrop-blur-sm border border-white/20";
  
  const glowClasses = glow && variant === 'primary'
    ? "shadow-[0_0_30px_rgba(199,0,255,0.5)]"
    : "";

  return (
    <motion.button
      whileTap={{ scale: 0.95 }}
      className={`${baseClasses} ${gradientClasses} ${glowClasses} ${className}`}
      {...props}
    >
      {children}
    </motion.button>
  );
}
