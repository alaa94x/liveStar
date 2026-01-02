import { motion } from 'motion/react';

interface GiftIconProps {
  giftId: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  animated?: boolean;
  className?: string;
}

// Gift icon data with emojis and animation styles
const giftIconData: Record<string, { emoji: string; animation: string }> = {
  '1': { emoji: '🌹', animation: 'float-rotate' },
  '2': { emoji: '💎', animation: 'sparkle-pulse' },
  '3': { emoji: '🚗', animation: 'zoom-shake' },
  '4': { emoji: '🚀', animation: 'fly-bounce' },
  '5': { emoji: '👑', animation: 'royal-glow' },
  '6': { emoji: '🎁', animation: 'bounce-shake' },
  '7': { emoji: '💰', animation: 'swing-pulse' },
  '8': { emoji: '⭐', animation: 'star-twinkle' },
  '9': { emoji: '🔥', animation: 'flame-flicker' },
  '10': { emoji: '💖', animation: 'heart-beat' },
  '11': { emoji: '🎉', animation: 'party-spin' },
  '12': { emoji: '🌈', animation: 'rainbow-wave' },
};

export default function GiftIcon({ giftId, size = 'md', animated = true, className = '' }: GiftIconProps) {
  const iconData = giftIconData[giftId];

  if (!iconData) {
    return <span className={className}>🎁</span>;
  }

  const sizeClasses = {
    sm: 'text-2xl',
    md: 'text-3xl',
    lg: 'text-4xl',
    xl: 'text-5xl',
  };

  if (!animated) {
    return (
      <span className={`${sizeClasses[size]} ${className}`}>
        {iconData.emoji}
      </span>
    );
  }

  return (
    <motion.span
      className={`${sizeClasses[size]} ${className} inline-block gift-icon-${iconData.animation}`}
      initial={{ scale: 0.8, opacity: 0 }}
      animate={{ scale: 1, opacity: 1 }}
      transition={{ duration: 0.3 }}
    >
      {iconData.emoji}
      <style>{`
        /* Float and Rotate */
        .gift-icon-float-rotate {
          animation: floatRotate 3s ease-in-out infinite;
        }
        @keyframes floatRotate {
          0%, 100% { transform: translateY(0) rotate(0deg); }
          25% { transform: translateY(-8px) rotate(5deg); }
          50% { transform: translateY(-4px) rotate(-5deg); }
          75% { transform: translateY(-8px) rotate(5deg); }
        }

        /* Sparkle Pulse */
        .gift-icon-sparkle-pulse {
          animation: sparklePulse 2s ease-in-out infinite;
          filter: drop-shadow(0 0 8px rgba(0, 255, 255, 0.6));
        }
        @keyframes sparklePulse {
          0%, 100% { transform: scale(1); filter: drop-shadow(0 0 8px rgba(0, 255, 255, 0.6)); }
          50% { transform: scale(1.15); filter: drop-shadow(0 0 16px rgba(0, 255, 255, 0.9)); }
        }

        /* Zoom Shake */
        .gift-icon-zoom-shake {
          animation: zoomShake 2.5s ease-in-out infinite;
        }
        @keyframes zoomShake {
          0%, 100% { transform: scale(1) rotate(0deg); }
          20% { transform: scale(1.1) rotate(-3deg); }
          40% { transform: scale(1.05) rotate(3deg); }
          60% { transform: scale(1.1) rotate(-2deg); }
          80% { transform: scale(1.05) rotate(2deg); }
        }

        /* Fly Bounce */
        .gift-icon-fly-bounce {
          animation: flyBounce 2s ease-in-out infinite;
        }
        @keyframes flyBounce {
          0%, 100% { transform: translateY(0) rotate(-20deg); }
          25% { transform: translateY(-12px) rotate(-15deg); }
          50% { transform: translateY(-6px) rotate(-25deg); }
          75% { transform: translateY(-10px) rotate(-18deg); }
        }

        /* Royal Glow */
        .gift-icon-royal-glow {
          animation: royalGlow 2.5s ease-in-out infinite;
          filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.7));
        }
        @keyframes royalGlow {
          0%, 100% { 
            transform: scale(1) translateY(0); 
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.7)); 
          }
          50% { 
            transform: scale(1.12) translateY(-4px); 
            filter: drop-shadow(0 0 20px rgba(255, 215, 0, 1)); 
          }
        }

        /* Bounce Shake */
        .gift-icon-bounce-shake {
          animation: bounceShake 1.8s ease-in-out infinite;
        }
        @keyframes bounceShake {
          0%, 100% { transform: translateY(0) rotate(0deg); }
          10% { transform: translateY(-8px) rotate(-5deg); }
          20% { transform: translateY(0) rotate(5deg); }
          30% { transform: translateY(-6px) rotate(-3deg); }
          40% { transform: translateY(0) rotate(3deg); }
          50% { transform: translateY(-4px) rotate(0deg); }
        }

        /* Swing Pulse */
        .gift-icon-swing-pulse {
          animation: swingPulse 2.2s ease-in-out infinite;
          transform-origin: top center;
        }
        @keyframes swingPulse {
          0%, 100% { transform: rotate(0deg) scale(1); }
          20% { transform: rotate(15deg) scale(1.05); }
          40% { transform: rotate(-12deg) scale(1.08); }
          60% { transform: rotate(10deg) scale(1.05); }
          80% { transform: rotate(-8deg) scale(1.03); }
        }

        /* Star Twinkle */
        .gift-icon-star-twinkle {
          animation: starTwinkle 1.5s ease-in-out infinite;
          filter: drop-shadow(0 0 6px rgba(255, 255, 100, 0.8));
        }
        @keyframes starTwinkle {
          0%, 100% { 
            transform: scale(1) rotate(0deg); 
            filter: drop-shadow(0 0 6px rgba(255, 255, 100, 0.8)); 
          }
          25% { 
            transform: scale(1.2) rotate(20deg); 
            filter: drop-shadow(0 0 14px rgba(255, 255, 100, 1)); 
          }
          50% { 
            transform: scale(0.95) rotate(-10deg); 
            filter: drop-shadow(0 0 4px rgba(255, 255, 100, 0.6)); 
          }
          75% { 
            transform: scale(1.15) rotate(15deg); 
            filter: drop-shadow(0 0 12px rgba(255, 255, 100, 0.9)); 
          }
        }

        /* Flame Flicker */
        .gift-icon-flame-flicker {
          animation: flameFlicker 1s ease-in-out infinite;
          filter: drop-shadow(0 0 8px rgba(255, 100, 0, 0.7));
        }
        @keyframes flameFlicker {
          0%, 100% { 
            transform: scale(1) translateY(0); 
            filter: drop-shadow(0 0 8px rgba(255, 100, 0, 0.7)); 
          }
          25% { 
            transform: scale(1.08) translateY(-2px); 
            filter: drop-shadow(0 0 12px rgba(255, 100, 0, 0.9)); 
          }
          50% { 
            transform: scale(1.12) translateY(-4px); 
            filter: drop-shadow(0 0 16px rgba(255, 100, 0, 1)); 
          }
          75% { 
            transform: scale(1.05) translateY(-1px); 
            filter: drop-shadow(0 0 10px rgba(255, 100, 0, 0.8)); 
          }
        }

        /* Heart Beat */
        .gift-icon-heart-beat {
          animation: heartBeat 1.2s ease-in-out infinite;
        }
        @keyframes heartBeat {
          0%, 100% { transform: scale(1); }
          10% { transform: scale(1.15); }
          20% { transform: scale(1); }
          30% { transform: scale(1.2); }
          40% { transform: scale(1); }
        }

        /* Party Spin */
        .gift-icon-party-spin {
          animation: partySpin 2s ease-in-out infinite;
        }
        @keyframes partySpin {
          0%, 100% { transform: rotate(0deg) scale(1); }
          25% { transform: rotate(15deg) scale(1.1); }
          50% { transform: rotate(-15deg) scale(1.05); }
          75% { transform: rotate(10deg) scale(1.08); }
        }

        /* Rainbow Wave */
        .gift-icon-rainbow-wave {
          animation: rainbowWave 2.5s ease-in-out infinite;
        }
        @keyframes rainbowWave {
          0%, 100% { transform: translateX(0) translateY(0) rotate(0deg); }
          25% { transform: translateX(4px) translateY(-6px) rotate(10deg); }
          50% { transform: translateX(-2px) translateY(-8px) rotate(-5deg); }
          75% { transform: translateX(2px) translateY(-4px) rotate(8deg); }
        }
      `}</style>
    </motion.span>
  );
}
