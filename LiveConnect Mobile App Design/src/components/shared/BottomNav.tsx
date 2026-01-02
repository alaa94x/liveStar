import { useNavigate, useLocation } from 'react-router-dom';
import { Home, Compass, Radio, MessageCircle, User } from 'lucide-react';
import { motion } from 'motion/react';

export default function BottomNav() {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { icon: Home, label: 'Home', path: '/home' },
    { icon: Compass, label: 'Explore', path: '/explore' },
    { icon: Radio, label: 'Go Live', path: '/go-live', isSpecial: true },
    { icon: MessageCircle, label: 'Messages', path: '/messages' },
    { icon: User, label: 'Profile', path: '/profile' },
  ];

  return (
    <div className="absolute bottom-0 left-0 right-0 bg-[#1A1A1F]/95 backdrop-blur-lg border-t border-white/10 pb-safe z-50">
      <div className="px-4 py-2 flex items-center justify-around">
        {navItems.map((item) => {
          const isActive = location.pathname === item.path;
          const Icon = item.icon;

          if (item.isSpecial) {
            return (
              <motion.button
                key={item.path}
                whileTap={{ scale: 0.9 }}
                onClick={() => navigate(item.path)}
                className="relative -mt-8"
              >
                <div className="w-14 h-14 rounded-full bg-gradient-to-r from-[#C700FF] to-[#FF2D92] flex items-center justify-center shadow-[0_0_30px_rgba(199,0,255,0.6)]">
                  <Icon className="w-6 h-6" />
                </div>
              </motion.button>
            );
          }

          return (
            <motion.button
              key={item.path}
              whileTap={{ scale: 0.9 }}
              onClick={() => navigate(item.path)}
              className={`flex flex-col items-center gap-1 py-2 px-3 ${
                isActive ? 'text-[#FF2D92]' : 'text-white/60'
              }`}
            >
              <Icon className="w-6 h-6" />
            </motion.button>
          );
        })}
      </div>
    </div>
  );
}
