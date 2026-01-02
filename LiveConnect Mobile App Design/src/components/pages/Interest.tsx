import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Check, UserPlus, UserCheck, Sparkles, Music, Gamepad2, Utensils, Heart, Palette, Dumbbell, BookOpen, Smile, Camera, Mic2 } from 'lucide-react';
import { motion } from 'motion/react';
import PageTransition from '../shared/PageTransition';
import GradientButton from '../shared/GradientButton';
import { ImageWithFallback } from '../figma/ImageWithFallback';

const topics = [
  { id: 'music', name: 'Music', icon: Music },
  { id: 'gaming', name: 'Gaming', icon: Gamepad2 },
  { id: 'cooking', name: 'Cooking', icon: Utensils },
  { id: 'dance', name: 'Dance', icon: Heart },
  { id: 'art', name: 'Art & Craft', icon: Palette },
  { id: 'fitness', name: 'Fitness', icon: Dumbbell },
  { id: 'education', name: 'Education', icon: BookOpen },
  { id: 'comedy', name: 'Comedy', icon: Smile },
  { id: 'photography', name: 'Photography', icon: Camera },
  { id: 'singing', name: 'Singing', icon: Mic2 },
];

const suggestedUsers = [
  { id: 1, name: 'Sarah Johnson', username: '@sarahjay', followers: 2500000, avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop' },
  { id: 2, name: 'Mike Chen', username: '@mikechen', followers: 1800000, avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop' },
  { id: 3, name: 'Emma Davis', username: '@emmad', followers: 3200000, avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop' },
  { id: 4, name: 'Alex Rivera', username: '@alexriv', followers: 1500000, avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop' },
  { id: 5, name: 'Lisa Wong', username: '@lisawong', followers: 2800000, avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop' },
  { id: 6, name: 'David Kim', username: '@davidk', followers: 2100000, avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop' },
  { id: 7, name: 'Sofia Martinez', username: '@sofiam', followers: 1900000, avatar: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=150&h=150&fit=crop' },
  { id: 8, name: 'James Taylor', username: '@jamest', followers: 2600000, avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop' },
];

export default function Interest() {
  const navigate = useNavigate();
  const [selectedTopics, setSelectedTopics] = useState<string[]>([]);
  const [followedUsers, setFollowedUsers] = useState<number[]>([]);

  const toggleTopic = (topicId: string) => {
    setSelectedTopics(prev =>
      prev.includes(topicId)
        ? prev.filter(id => id !== topicId)
        : [...prev, topicId]
    );
  };

  const toggleFollow = (userId: number) => {
    setFollowedUsers(prev =>
      prev.includes(userId)
        ? prev.filter(id => id !== userId)
        : [...prev, userId]
    );
  };

  const handleContinue = () => {
    navigate('/home');
  };

  const handleSkip = () => {
    navigate('/home');
  };

  const canContinue = followedUsers.length >= 5;

  return (
    <PageTransition>
      <div className="h-[812px] bg-gradient-to-b from-[#0D0D0F] via-[#1A1A1F] to-[#0D0D0F] text-white overflow-y-auto pb-28">
        {/* Header */}
        <div className="px-6 pt-8 pb-6 text-center">
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.2, type: 'spring' }}
            className="w-16 h-16 rounded-full bg-gradient-to-r from-[#C700FF] to-[#FF2D92] flex items-center justify-center mx-auto mb-4"
          >
            <Sparkles className="w-8 h-8 text-white" />
          </motion.div>
          <h1 className="text-white mb-2">Personalize Your Feed</h1>
          <p className="text-white/60 text-sm">Choose topics and follow creators to get started</p>
        </div>

        {/* Topics Section */}
        <div className="px-6 mb-8">
          <h2 className="text-white mb-4 flex items-center gap-2">
            <Sparkles className="w-5 h-5 text-[#FF2D92]" />
            Select Your Interests
          </h2>
          <div className="grid grid-cols-2 gap-3">
            {topics.map((topic) => {
              const Icon = topic.icon;
              const isSelected = selectedTopics.includes(topic.id);
              return (
                <motion.button
                  key={topic.id}
                  whileTap={{ scale: 0.95 }}
                  onClick={() => toggleTopic(topic.id)}
                  className={`relative p-4 rounded-2xl border transition-all ${
                    isSelected
                      ? 'bg-gradient-to-r from-[#C700FF]/20 to-[#FF2D92]/20 border-[#C700FF]'
                      : 'bg-white/5 border-white/10 hover:border-white/20'
                  }`}
                >
                  <div className="flex flex-col items-center gap-2">
                    <Icon className={`w-6 h-6 ${isSelected ? 'text-[#FF2D92]' : 'text-white/60'}`} />
                    <span className={`text-sm ${isSelected ? 'text-white' : 'text-white/60'}`}>
                      {topic.name}
                    </span>
                  </div>
                  {isSelected && (
                    <motion.div
                      initial={{ scale: 0 }}
                      animate={{ scale: 1 }}
                      className="absolute top-2 right-2 w-5 h-5 rounded-full bg-gradient-to-r from-[#C700FF] to-[#FF2D92] flex items-center justify-center"
                    >
                      <Check className="w-3 h-3 text-white" />
                    </motion.div>
                  )}
                </motion.button>
              );
            })}
          </div>
        </div>

        {/* Suggested Users Section */}
        <div className="px-6 pb-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-white flex items-center gap-2">
              <UserPlus className="w-5 h-5 text-[#FF2D92]" />
              Follow Creators
            </h2>
            <span className={`text-sm ${followedUsers.length >= 5 ? 'text-green-400' : 'text-white/60'}`}>
              {followedUsers.length}/5 minimum
            </span>
          </div>
          
          <div className="space-y-3">
            {suggestedUsers.map((user) => {
              const isFollowed = followedUsers.includes(user.id);
              return (
                <motion.div
                  key={user.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: user.id * 0.05 }}
                  className="flex items-center gap-3 p-3 rounded-2xl bg-white/5 border border-white/10"
                >
                  <ImageWithFallback
                    src={user.avatar}
                    alt={user.name}
                    className="w-12 h-12 rounded-full object-cover"
                  />
                  <div className="flex-1 min-w-0">
                    <p className="text-white truncate">{user.name}</p>
                    <p className="text-white/60 text-sm">{user.username}</p>
                    <p className="text-white/40 text-xs">{(user.followers / 1000000).toFixed(1)}M followers</p>
                  </div>
                  <motion.button
                    whileTap={{ scale: 0.9 }}
                    onClick={() => toggleFollow(user.id)}
                    className={`px-4 py-2 rounded-full text-sm transition-all whitespace-nowrap ${
                      isFollowed
                        ? 'bg-white/10 text-white/60'
                        : 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white'
                    }`}
                  >
                    {isFollowed ? (
                      <span className="flex items-center gap-1">
                        <UserCheck className="w-4 h-4" />
                        Following
                      </span>
                    ) : (
                      <span className="flex items-center gap-1">
                        <UserPlus className="w-4 h-4" />
                        Follow
                      </span>
                    )}
                  </motion.button>
                </motion.div>
              );
            })}
          </div>
        </div>

        {/* Fixed Bottom Actions */}
        <div className="fixed bottom-0 left-0 right-0 px-6 py-6 bg-gradient-to-t from-[#0D0D0F] via-[#0D0D0F]/95 to-transparent backdrop-blur-sm max-w-[430px] mx-auto">
          <GradientButton
            onClick={handleContinue}
            disabled={!canContinue}
            className={`w-full mb-3 ${!canContinue ? 'opacity-50 cursor-not-allowed' : ''}`}
          >
            {canContinue ? 'Continue' : `Follow ${5 - followedUsers.length} more to continue`}
          </GradientButton>
          <button
            onClick={handleSkip}
            className="w-full text-white/60 text-sm hover:text-white transition-colors"
          >
            Skip for now
          </button>
        </div>
      </div>
    </PageTransition>
  );
}
