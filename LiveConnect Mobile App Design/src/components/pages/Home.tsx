import { useState } from 'react';
import { Bell, Search, Gamepad2, Music, MessageCircle, Shirt, Flame, TrendingUp, Sparkles } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'motion/react';
import BottomNav from '../shared/BottomNav';
import LiveCard from '../shared/LiveCard';

const topics = [
  { id: 'all', label: 'For You', icon: Sparkles },
  { id: 'trending', label: 'Trending', icon: TrendingUp },
  { id: 'hot', label: 'Hot', icon: Flame },
  { id: 'gaming', label: 'Gaming', icon: Gamepad2 },
  { id: 'music', label: 'Music', icon: Music },
  { id: 'chat', label: 'Chat', icon: MessageCircle },
  { id: 'fashion', label: 'Fashion', icon: Shirt },
];

const liveStreams = [
  {
    id: '1',
    streamerName: 'Emma Rose',
    streamerPhoto: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400',
    title: 'Just chatting and vibing 💕✨',
    viewerCount: 2340,
  },
  {
    id: '2',
    streamerName: 'Alex Chen',
    streamerPhoto: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=400',
    title: 'Gaming session - Come hang out!',
    viewerCount: 5620,
  },
  {
    id: '3',
    streamerName: 'Sophie Lee',
    streamerPhoto: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=400',
    title: 'Morning coffee chat ☕',
    viewerCount: 1850,
  },
  {
    id: '4',
    streamerName: 'Maya Kim',
    streamerPhoto: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=400',
    title: 'Singing your favorite songs 🎤',
    viewerCount: 8920,
  },
  {
    id: '5',
    streamerName: 'Jake Wilson',
    streamerPhoto: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=400',
    title: 'Late night gaming stream',
    viewerCount: 3450,
  },
  {
    id: '6',
    streamerName: 'Luna Star',
    streamerPhoto: 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=400',
    title: 'Karaoke night! Join me 🎵',
    viewerCount: 6780,
  },
];

export default function Home() {
  const navigate = useNavigate();
  const [selectedTopic, setSelectedTopic] = useState('all');

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      className="h-[812px] bg-[#0D0D0F] relative"
    >
        <div className="h-full overflow-y-auto pb-24">
          <div className="max-w-[430px] mx-auto">
            {/* Header */}
            <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10">
            <div className="px-4 py-4 flex items-center justify-between">
              <h2 className="text-white">LiveConnect</h2>
              <div className="flex items-center gap-3">
                <button className="relative p-2 hover:bg-white/5 rounded-full transition-colors">
                  <Search className="w-6 h-6 text-white" />
                </button>
                <button
                  onClick={() => navigate('/notifications')}
                  className="relative p-2 hover:bg-white/5 rounded-full transition-colors"
                >
                  <Bell className="w-6 h-6 text-white" />
                  <div className="absolute top-1 right-1 w-2 h-2 bg-[#FF2D92] rounded-full" />
                </button>
              </div>
            </div>
          </div>

          {/* Topics selector */}
          <div className="sticky top-[73px] z-30 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10 py-3">
            <div className="overflow-x-auto scrollbar-hide px-4">
              <div className="flex gap-3 min-w-max">
                {topics.map((topic) => {
                  const Icon = topic.icon;
                  const isSelected = selectedTopic === topic.id;
                  
                  return (
                    <motion.button
                      key={topic.id}
                      onClick={() => setSelectedTopic(topic.id)}
                      whileTap={{ scale: 0.95 }}
                      className={`relative px-4 py-2.5 rounded-full flex items-center gap-2 transition-all whitespace-nowrap ${
                        isSelected
                          ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white shadow-[0_0_20px_rgba(199,0,255,0.4)]'
                          : 'bg-white/5 text-white/60 hover:bg-white/10 hover:text-white/80'
                      }`}
                    >
                      <Icon className="w-4 h-4" />
                      <span className="text-sm">{topic.label}</span>
                      {isSelected && (
                        <motion.div
                          layoutId="topic-indicator"
                          className="absolute inset-0 rounded-full bg-gradient-to-r from-[#C700FF] to-[#FF2D92]"
                          style={{ zIndex: -1 }}
                          transition={{ type: 'spring', bounce: 0.2, duration: 0.6 }}
                        />
                      )}
                    </motion.button>
                  );
                })}
              </div>
            </div>
          </div>

          {/* Live streams grid */}
          <div className="px-4 py-6">
            <div className="grid grid-cols-2 gap-4">
              {liveStreams.map((stream) => (
                <LiveCard key={stream.id} {...stream} />
              ))}
            </div>
          </div>
          </div>
        </div>

        <BottomNav />
      </motion.div>
  );
}
