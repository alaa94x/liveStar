import { useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ChevronLeft, Settings, Share2, Grid, Video, Heart, Crown } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import BottomNav from '../shared/BottomNav';
import GradientButton from '../shared/GradientButton';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '../ui/tabs';

const pastStreams = [
  {
    id: '1',
    thumbnail: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400',
    views: 12400,
    duration: '2:45:30',
  },
  {
    id: '2',
    thumbnail: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=400',
    views: 8900,
    duration: '1:30:15',
  },
  {
    id: '3',
    thumbnail: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=400',
    views: 15600,
    duration: '3:15:00',
  },
  {
    id: '4',
    thumbnail: 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=400',
    views: 9800,
    duration: '2:10:45',
  },
  {
    id: '5',
    thumbnail: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
    views: 18200,
    duration: '3:30:20',
  },
  {
    id: '6',
    thumbnail: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
    views: 7300,
    duration: '1:15:45',
  },
  {
    id: '7',
    thumbnail: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400',
    views: 21500,
    duration: '4:05:10',
  },
  {
    id: '8',
    thumbnail: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=400',
    views: 11700,
    duration: '2:20:35',
  },
  {
    id: '9',
    thumbnail: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400',
    views: 14900,
    duration: '2:55:00',
  },
  {
    id: '10',
    thumbnail: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
    views: 19800,
    duration: '3:40:15',
  },
  {
    id: '11',
    thumbnail: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400',
    views: 6500,
    duration: '1:05:50',
  },
  {
    id: '12',
    thumbnail: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400',
    views: 13400,
    duration: '2:35:25',
  },
];

export default function Profile() {
  const navigate = useNavigate();
  const { id } = useParams();
  const isOwnProfile = !id; // If no ID in params, it's the user's own profile

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] pb-24 overflow-y-auto">
        <div className="max-w-[430px] mx-auto">
          {/* Header */}
          <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10 px-4 py-4">
            <div className="flex items-center justify-between">
              {!isOwnProfile && (
                <button
                  onClick={() => navigate(-1)}
                  className="text-white/60"
                >
                  <ChevronLeft className="w-6 h-6" />
                </button>
              )}
              <h2 className="text-white flex-1 text-center">Profile</h2>
              <button
                onClick={() => navigate('/settings')}
                className="text-white/60"
              >
                <Settings className="w-6 h-6" />
              </button>
            </div>
          </div>

          {/* Profile header */}
          <div className="relative">
            {/* Cover gradient */}
            <div className="h-32 bg-gradient-to-r from-[#C700FF] to-[#FF2D92]" />
            
            {/* Profile info */}
            <div className="px-6 -mt-16">
              <div className="relative inline-block">
                <img
                  src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400"
                  alt="Profile"
                  className="w-28 h-28 rounded-full border-4 border-[#0D0D0F] object-cover"
                />
                <div className="absolute -bottom-1 -right-1 w-8 h-8 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-full flex items-center justify-center">
                  <Crown className="w-4 h-4 text-white" />
                </div>
              </div>

              <div className="mt-4">
                <h2 className="text-white">Emma Rose</h2>
                <p className="text-white/60 mt-1">
                  ✨ Live streamer & content creator
                </p>
                <p className="text-white/60 text-sm mt-1">
                  💕 Spreading good vibes daily
                </p>
              </div>

              {/* Stats */}
              <div className="flex items-center gap-6 mt-6">
                <div className="text-center">
                  <p className="text-white">125K</p>
                  <p className="text-sm text-white/60">Followers</p>
                </div>
                <div className="text-center">
                  <p className="text-white">340</p>
                  <p className="text-sm text-white/60">Following</p>
                </div>
                <div className="text-center">
                  <p className="text-white">2.4M</p>
                  <p className="text-sm text-white/60">Likes</p>
                </div>
              </div>

              {/* Action buttons */}
              <div className="flex gap-3 mt-6">
                {isOwnProfile ? (
                  <>
                    <GradientButton
                      onClick={() => navigate('/settings')}
                      className="flex-1"
                    >
                      Edit Profile
                    </GradientButton>
                    <button className="px-6 py-3 bg-white/5 border border-white/10 rounded-full text-white hover:bg-white/10 transition-colors">
                      <Share2 className="w-5 h-5" />
                    </button>
                  </>
                ) : (
                  <>
                    <GradientButton className="flex-1">
                      Follow
                    </GradientButton>
                    <button className="px-6 py-3 bg-white/5 border border-white/10 rounded-full text-white hover:bg-white/10 transition-colors">
                      <Heart className="w-5 h-5" />
                    </button>
                    <button className="px-6 py-3 bg-white/5 border border-white/10 rounded-full text-white hover:bg-white/10 transition-colors">
                      <Share2 className="w-5 h-5" />
                    </button>
                  </>
                )}
              </div>
            </div>
          </div>

          {/* Premium banner */}
          <div className="mx-6 mt-6 p-4 bg-gradient-to-r from-[#C700FF]/20 to-[#FF2D92]/20 border border-white/10 rounded-2xl">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-white flex items-center gap-2">
                  <Crown className="w-5 h-5" />
                  Go Premium
                </p>
                <p className="text-sm text-white/60 mt-1">
                  Unlock exclusive features and badges
                </p>
              </div>
              <GradientButton className="px-4 py-2 text-sm">
                Upgrade
              </GradientButton>
            </div>
          </div>

          {/* Content tabs */}
          <Tabs defaultValue="streams" className="mt-6">
            <TabsList className="w-full bg-transparent border-b border-white/10 rounded-none h-auto p-0">
              <TabsTrigger
                value="streams"
                className="flex-1 data-[state=active]:text-white data-[state=active]:bg-transparent text-white/60 bg-transparent rounded-none pt-3 pb-3 hover:bg-transparent relative data-[state=active]:before:content-[''] data-[state=active]:before:absolute data-[state=active]:before:top-0 data-[state=active]:before:left-1/2 data-[state=active]:before:-translate-x-1/2 data-[state=active]:before:w-1/2 data-[state=active]:before:h-[2px] data-[state=active]:before:bg-[#FF2D92]"
              >
                <Video className="w-4 h-4 mr-2" />
                Streams
              </TabsTrigger>
              <TabsTrigger
                value="liked"
                className="flex-1 data-[state=active]:text-white data-[state=active]:bg-transparent text-white/60 bg-transparent rounded-none pt-3 pb-3 hover:bg-transparent relative data-[state=active]:before:content-[''] data-[state=active]:before:absolute data-[state=active]:before:top-0 data-[state=active]:before:left-1/2 data-[state=active]:before:-translate-x-1/2 data-[state=active]:before:w-1/2 data-[state=active]:before:h-[2px] data-[state=active]:before:bg-[#FF2D92]"
              >
                <Heart className="w-4 h-4 mr-2" />
                Liked
              </TabsTrigger>
            </TabsList>

            <TabsContent value="streams" className="px-4 mt-4 flex-none">
              <div className="grid grid-cols-2 gap-3 pb-6">
                {pastStreams.map((stream) => (
                  <div
                    key={stream.id}
                    className="relative aspect-[9/16] rounded-2xl overflow-hidden cursor-pointer"
                  >
                    <img
                      src={stream.thumbnail}
                      alt="Stream"
                      className="w-full h-full object-cover"
                    />
                    <div className="absolute inset-0 bg-gradient-to-b from-transparent to-black/60" />
                    <div className="absolute bottom-2 left-2 right-2">
                      <p className="text-xs text-white">{stream.views.toLocaleString()} views</p>
                      <p className="text-xs text-white/60">{stream.duration}</p>
                    </div>
                  </div>
                ))}
              </div>
            </TabsContent>

            <TabsContent value="liked" className="px-4 mt-4">
              <div className="text-center py-12">
                <Heart className="w-12 h-12 text-white/20 mx-auto mb-3" />
                <p className="text-white/60">No liked streams yet</p>
              </div>
            </TabsContent>
          </Tabs>
        </div>

        <BottomNav />
      </div>
    </PageTransition>
  );
}
