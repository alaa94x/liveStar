import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'motion/react';
import { Video, Users, Gift, ChevronRight } from 'lucide-react';
import GradientButton from '../shared/GradientButton';

const slides = [
  {
    icon: Video,
    title: 'Go Live and Be Seen',
    description: 'Share your moments with the world. Start streaming in seconds and build your audience.',
  },
  {
    icon: Users,
    title: 'Chat and Meet New Friends',
    description: 'Connect with people worldwide. Make new friends and join vibrant communities.',
  },
  {
    icon: Gift,
    title: 'Earn Rewards and Gifts',
    description: 'Get rewarded for your content. Receive virtual gifts and turn them into real earnings.',
  },
];

export default function Onboarding() {
  const [currentSlide, setCurrentSlide] = useState(0);
  const navigate = useNavigate();

  const handleNext = () => {
    if (currentSlide < slides.length - 1) {
      setCurrentSlide(currentSlide + 1);
    } else {
      navigate('/login');
    }
  };

  const handleSkip = () => {
    navigate('/login');
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      className="relative h-full bg-gradient-to-br from-[#C700FF]/20 via-[#8B00FF]/10 to-[#FF2D92]/20"
    >
        <div className="max-w-[430px] mx-auto h-full flex flex-col px-6 py-12">
          {/* Skip button */}
          <div className="flex justify-end mb-8">
            <button onClick={handleSkip} className="text-white/60 text-sm">
              Skip
            </button>
          </div>

          {/* Slide content */}
          <div className="flex-1 flex items-center justify-center">
            <AnimatePresence mode="wait">
              <motion.div
                key={currentSlide}
                initial={{ opacity: 0, x: 50 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -50 }}
                transition={{ duration: 0.3 }}
                className="text-center"
              >
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  transition={{ delay: 0.2, type: 'spring' }}
                  className="inline-flex items-center justify-center w-32 h-32 bg-gradient-to-br from-[#C700FF] to-[#FF2D92] rounded-full mb-8 shadow-[0_0_60px_rgba(199,0,255,0.5)]"
                >
                  {(() => {
                    const Icon = slides[currentSlide].icon;
                    return <Icon className="w-16 h-16" />;
                  })()}
                </motion.div>

                <h2 className="mb-4 text-white">
                  {slides[currentSlide].title}
                </h2>
                <p className="text-white/70 px-4">
                  {slides[currentSlide].description}
                </p>
              </motion.div>
            </AnimatePresence>
          </div>

          {/* Dots indicator */}
          <div className="flex justify-center gap-2 mb-8">
            {slides.map((_, index) => (
              <div
                key={index}
                className={`h-2 rounded-full transition-all duration-300 ${
                  index === currentSlide
                    ? 'w-8 bg-gradient-to-r from-[#C700FF] to-[#FF2D92]'
                    : 'w-2 bg-white/30'
                }`}
              />
            ))}
          </div>

          {/* Next/Get Started button */}
          <GradientButton onClick={handleNext} className="w-full">
            <span className="flex items-center justify-center gap-2">
              {currentSlide < slides.length - 1 ? 'Next' : 'Get Started'}
              <ChevronRight className="w-5 h-5" />
            </span>
          </GradientButton>
        </div>
      </motion.div>
  );
}
