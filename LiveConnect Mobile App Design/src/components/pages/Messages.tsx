import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search, MoreVertical } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import BottomNav from '../shared/BottomNav';
import { Badge } from '../ui/badge';

const conversations = [
  {
    id: '1',
    name: 'Emma Rose',
    avatar: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
    lastMessage: 'Thanks for the gift! 💕',
    time: '2m',
    unread: 3,
    online: true,
  },
  {
    id: '2',
    name: 'Alex Chen',
    avatar: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
    lastMessage: 'See you in the next stream!',
    time: '1h',
    unread: 0,
    online: true,
  },
  {
    id: '3',
    name: 'Sophie Lee',
    avatar: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
    lastMessage: 'That was amazing! 🎉',
    time: '3h',
    unread: 1,
    online: false,
  },
  {
    id: '4',
    name: 'Maya Kim',
    avatar: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
    lastMessage: 'Love your streams ✨',
    time: '1d',
    unread: 0,
    online: false,
  },
  {
    id: '5',
    name: 'Jake Wilson',
    avatar: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
    lastMessage: 'When is your next gaming session?',
    time: '2d',
    unread: 0,
    online: true,
  },
];

export default function Messages() {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] pb-24 overflow-y-auto">
        <div className="max-w-[430px] mx-auto">
          {/* Header */}
          <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10">
            <div className="px-4 py-4">
              <h2 className="text-white mb-4">Messages</h2>
              
              {/* Search bar */}
              <div className="relative">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
                <input
                  type="text"
                  placeholder="Search messages..."
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-3 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20 outline-none"
                />
              </div>
            </div>
          </div>

          {/* Conversations list */}
          <div className="divide-y divide-white/5">
            {conversations.map((conversation) => (
              <button
                key={conversation.id}
                onClick={() => navigate(`/chat/${conversation.id}`)}
                className="w-full px-4 py-4 flex items-center gap-4 hover:bg-white/5 transition-colors"
              >
                {/* Avatar with online indicator */}
                <div className="relative flex-shrink-0">
                  <img
                    src={conversation.avatar}
                    alt={conversation.name}
                    className="w-14 h-14 rounded-full object-cover"
                  />
                  {conversation.online && (
                    <div className="absolute bottom-0 right-0 w-4 h-4 bg-green-500 rounded-full border-2 border-[#0D0D0F]" />
                  )}
                </div>

                {/* Message info */}
                <div className="flex-1 min-w-0 text-left">
                  <div className="flex items-center justify-between mb-1">
                    <p className="text-white truncate">
                      {conversation.name}
                    </p>
                    <span className="text-xs text-white/40 flex-shrink-0">
                      {conversation.time}
                    </span>
                  </div>
                  <p className="text-sm text-white/60 truncate">
                    {conversation.lastMessage}
                  </p>
                </div>

                {/* Unread badge */}
                {conversation.unread > 0 && (
                  <div className="flex-shrink-0">
                    <Badge className="bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white border-0 rounded-full min-w-[24px] h-6 flex items-center justify-center">
                      {conversation.unread}
                    </Badge>
                  </div>
                )}
              </button>
            ))}
          </div>
        </div>

        <BottomNav />
      </div>
    </PageTransition>
  );
}
