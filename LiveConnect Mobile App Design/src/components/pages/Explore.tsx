import { useState } from 'react';
import { Search, SlidersHorizontal, Plus } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import BottomNav from '../shared/BottomNav';
import LiveCard from '../shared/LiveCard';
import { Badge } from '../ui/badge';

const categories = ['Popular', 'Gaming', 'Music', 'Chat', 'Fashion', 'Dance', 'Sports'];

const trendingCreators = [
  {
    id: '1',
    name: 'Emma Rose',
    photo: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
    followers: '125K',
  },
  {
    id: '2',
    name: 'Alex Chen',
    photo: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
    followers: '98K',
  },
  {
    id: '3',
    name: 'Sophie Lee',
    photo: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
    followers: '87K',
  },
  {
    id: '4',
    name: 'Maya Kim',
    photo: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
    followers: '156K',
  },
];

const exploreStreams = [
  {
    id: '7',
    streamerName: 'Emma Rose',
    streamerPhoto: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400',
    title: 'Fashion haul and styling tips 👗',
    viewerCount: 4230,
  },
  {
    id: '8',
    streamerName: 'Jake Wilson',
    streamerPhoto: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
    thumbnail: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=400',
    title: 'Pro gaming tips and tricks',
    viewerCount: 7890,
  },
];

export default function Explore() {
  const [selectedCategory, setSelectedCategory] = useState('Popular');

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] pb-24 overflow-y-auto">
        <div className="max-w-[430px] mx-auto">
          {/* Header */}
          <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10">
            <div className="px-4 py-4">
              <h2 className="text-white mb-4">Explore</h2>
              
              {/* Search bar */}
              <div className="relative flex items-center gap-3">
                <div className="flex-1 relative">
                  <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
                  <input
                    type="text"
                    placeholder="Search streams, creators..."
                    className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-3 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20 outline-none"
                  />
                </div>
                <button className="p-3 bg-white/5 border border-white/10 rounded-2xl hover:bg-white/10 transition-colors">
                  <SlidersHorizontal className="w-5 h-5 text-white" />
                </button>
              </div>
            </div>

            {/* Category tabs */}
            <div className="overflow-x-auto scrollbar-hide px-4 pb-3">
              <div className="flex gap-2">
                {categories.map((category) => (
                  <button
                    key={category}
                    onClick={() => setSelectedCategory(category)}
                    className={`px-4 py-2 rounded-full whitespace-nowrap transition-all ${
                      selectedCategory === category
                        ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white'
                        : 'bg-white/5 text-white/60 hover:bg-white/10'
                    }`}
                  >
                    {category}
                  </button>
                ))}
              </div>
            </div>
          </div>

          {/* Trending creators */}
          <div className="px-4 py-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-white">Trending Creators</h3>
              <button className="text-sm text-[#FF2D92]">See all</button>
            </div>
            
            <div className="flex gap-4 overflow-x-auto scrollbar-hide pb-2">
              {trendingCreators.map((creator) => (
                <div key={creator.id} className="flex-shrink-0">
                  <div className="relative">
                    <img
                      src={creator.photo}
                      alt={creator.name}
                      className="w-20 h-20 rounded-full border-2 border-gradient-to-r from-[#C700FF] to-[#FF2D92] object-cover"
                    />
                    <div className="absolute -bottom-1 -right-1 w-6 h-6 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-full flex items-center justify-center">
                      <Plus className="w-4 h-4" />
                    </div>
                  </div>
                  <p className="mt-2 text-sm text-white text-center truncate w-20">
                    {creator.name}
                  </p>
                  <p className="text-xs text-white/60 text-center">
                    {creator.followers}
                  </p>
                </div>
              ))}
            </div>
          </div>

          {/* Live streams */}
          <div className="px-4 pb-6">
            <h3 className="text-white mb-4">Live Now</h3>
            <div className="grid grid-cols-2 gap-4">
              {exploreStreams.map((stream) => (
                <LiveCard key={stream.id} {...stream} />
              ))}
            </div>
          </div>
        </div>

        <BottomNav />
      </div>
    </PageTransition>
  );
}
