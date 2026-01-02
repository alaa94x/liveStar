import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'motion/react';
import StarLogo from '../shared/StarLogo';

export default function Splash() {
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      navigate('/onboarding');
    }, 3000);
    return () => clearTimeout(timer);
  }, [navigate]);

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="relative h-full flex items-center justify-center overflow-hidden bg-[#0E0E0E]"
    >
      {/* Animated gradient orbs */}
      <motion.div
        className="absolute top-1/4 left-1/4 w-96 h-96 bg-gradient-to-br from-[#8A2BE2] to-[#FF007F] rounded-full opacity-30 blur-3xl"
        animate={{
          scale: [1, 1.2, 1],
          x: [0, 50, 0],
          y: [0, -30, 0],
        }}
        transition={{
          duration: 8,
          repeat: Infinity,
          ease: 'easeInOut',
        }}
      />
      
      <motion.div
        className="absolute bottom-1/4 right-1/4 w-80 h-80 bg-gradient-to-br from-[#FF007F] to-[#8A2BE2] rounded-full opacity-20 blur-3xl"
        animate={{
          scale: [1, 1.3, 1],
          x: [0, -40, 0],
          y: [0, 40, 0],
        }}
        transition={{
          duration: 10,
          repeat: Infinity,
          ease: 'easeInOut',
        }}
      />

      {/* Center content */}
      <div className="relative z-10 flex flex-col items-center">
        {/* Logo container with glow effect */}
        <motion.div
          initial={{ scale: 0.3, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ 
            duration: 1.2, 
            ease: [0.34, 1.56, 0.64, 1] // Bounce easing
          }}
          className="relative"
        >
          {/* Outer glow */}
          <motion.div
            className="absolute inset-0 -m-8"
            animate={{
              boxShadow: [
                '0 0 60px 20px rgba(138, 43, 226, 0.4)',
                '0 0 100px 30px rgba(255, 0, 127, 0.6)',
                '0 0 60px 20px rgba(138, 43, 226, 0.4)',
              ],
            }}
            transition={{
              duration: 3,
              repeat: Infinity,
              ease: 'easeInOut',
            }}
          />

          {/* Rotating ring */}
          <motion.div
            className="absolute -inset-8"
            animate={{ rotate: 360 }}
            transition={{
              duration: 20,
              repeat: Infinity,
              ease: 'linear',
            }}
          >
            <div className="w-full h-full rounded-full border-2 border-dashed border-white/20" />
          </motion.div>

          {/* Logo */}
          <motion.div
            animate={{
              y: [0, -10, 0],
            }}
            transition={{
              duration: 2,
              repeat: Infinity,
              ease: 'easeInOut',
            }}
          >
            <StarLogo size={140} />
          </motion.div>

          {/* Sparkle effects */}
          {[...Array(8)].map((_, i) => (
            <motion.div
              key={i}
              className="absolute w-1 h-1 bg-white rounded-full"
              style={{
                left: '50%',
                top: '50%',
              }}
              animate={{
                x: [0, Math.cos((i * Math.PI) / 4) * 100],
                y: [0, Math.sin((i * Math.PI) / 4) * 100],
                opacity: [0, 1, 0],
                scale: [0, 1, 0],
              }}
              transition={{
                duration: 2,
                repeat: Infinity,
                delay: i * 0.2,
                ease: 'easeOut',
              }}
            />
          ))}
        </motion.div>

        {/* App name with gradient */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.8 }}
          className="mt-12"
        >
          <motion.h1
            className="text-6xl bg-gradient-to-r from-[#8A2BE2] via-[#C147E9] to-[#FF007F] bg-clip-text text-transparent text-center"
            style={{ fontWeight: 800 }}
            animate={{
              backgroundPosition: ['0% 50%', '100% 50%', '0% 50%'],
            }}
            transition={{
              duration: 5,
              repeat: Infinity,
              ease: 'linear',
            }}
          >
            LiveStar
          </motion.h1>
        </motion.div>

        {/* Tagline */}
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1, duration: 0.8 }}
          className="mt-3 text-white/70 text-center tracking-wide"
        >
          Stream. Connect. Shine.
        </motion.p>

        {/* Animated underline */}
        <motion.div
          initial={{ width: 0 }}
          animate={{ width: 120 }}
          transition={{ delay: 1.2, duration: 0.8 }}
          className="mt-3 h-0.5 bg-gradient-to-r from-transparent via-white/40 to-transparent"
        />
      </div>

      {/* Loading indicator */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1.5 }}
        className="absolute bottom-20 left-1/2 -translate-x-1/2"
      >
        <div className="flex space-x-3">
          {[0, 1, 2].map((i) => (
            <motion.div
              key={i}
              className="w-2.5 h-2.5 rounded-full bg-gradient-to-r from-[#8A2BE2] to-[#FF007F]"
              animate={{
                scale: [1, 1.4, 1],
                opacity: [0.3, 1, 0.3],
              }}
              transition={{
                duration: 1.5,
                repeat: Infinity,
                delay: i * 0.2,
                ease: 'easeInOut',
              }}
            />
          ))}
        </div>
      </motion.div>

      {/* Particle effects */}
      {[...Array(15)].map((_, i) => (
        <motion.div
          key={i}
          className="absolute w-1 h-1 bg-white/30 rounded-full"
          style={{
            left: `${Math.random() * 100}%`,
            top: `${Math.random() * 100}%`,
          }}
          animate={{
            y: [0, -100, 0],
            opacity: [0, 0.6, 0],
          }}
          transition={{
            duration: 3 + Math.random() * 2,
            repeat: Infinity,
            delay: Math.random() * 2,
            ease: 'easeInOut',
          }}
        />
      ))}
    </motion.div>
  );
}
