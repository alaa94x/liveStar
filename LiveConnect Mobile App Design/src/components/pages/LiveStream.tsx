import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { X, Heart, MessageCircle, Gift, Mic, Video, MoreVertical, Eye, Coins, Sparkles } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import PageTransition from '../shared/PageTransition';
import GiftIcon from '../shared/GiftIcon';
import { toast } from 'sonner@2.0.3';

const mockComments = [
  { id: 1, user: 'Sarah123', message: 'Love this stream! 💕', avatar: 'https://i.pravatar.cc/150?img=1' },
  { id: 2, user: 'Mike_89', message: 'Amazing content!', avatar: 'https://i.pravatar.cc/150?img=2' },
  { id: 3, user: 'Luna_xo', message: 'You are so talented! ✨', avatar: 'https://i.pravatar.cc/150?img=3' },
];

const availableGifts = [
  { id: '1', emoji: '🌹', name: 'Rose', price: 50, color: 'from-red-500 to-pink-500' },
  { id: '2', emoji: '💎', name: 'Diamond', price: 200, color: 'from-cyan-500 to-blue-500' },
  { id: '3', emoji: '🚗', name: 'Sports Car', price: 500, color: 'from-yellow-500 to-orange-500' },
  { id: '4', emoji: '🚀', name: 'Rocket', price: 1000, color: 'from-purple-500 to-pink-500' },
  { id: '5', emoji: '👑', name: 'Crown', price: 2000, color: 'from-yellow-400 to-yellow-600' },
  { id: '6', emoji: '🎁', name: 'Gift Box', price: 100, color: 'from-green-500 to-emerald-500' },
  { id: '7', emoji: '💰', name: 'Money Bag', price: 800, color: 'from-green-400 to-green-600' },
  { id: '8', emoji: '⭐', name: 'Star', price: 150, color: 'from-yellow-300 to-orange-400' },
  { id: '9', emoji: '🔥', name: 'Fire', price: 300, color: 'from-orange-500 to-red-500' },
  { id: '10', emoji: '💖', name: 'Heart', price: 80, color: 'from-pink-400 to-pink-600' },
  { id: '11', emoji: '🎉', name: 'Party', price: 120, color: 'from-purple-400 to-pink-400' },
  { id: '12', emoji: '🌈', name: 'Rainbow', price: 400, color: 'from-blue-400 via-purple-400 to-pink-400' },
];

interface FloatingGift {
  id: string;
  emoji: string;
  x: number;
  y: number;
}

export default function LiveStream() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [likes, setLikes] = useState(8234);
  const [isLiked, setIsLiked] = useState(false);
  const [comments, setComments] = useState(mockComments);
  const [newComment, setNewComment] = useState('');
  const [showGifts, setShowGifts] = useState(false);
  const [coinBalance, setCoinBalance] = useState(3450);
  const [floatingGifts, setFloatingGifts] = useState<FloatingGift[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<'popular' | 'premium' | 'all'>('all');
  const [showRadialMenu, setShowRadialMenu] = useState(false);
  const [radialMenuPos, setRadialMenuPos] = useState({ x: 0, y: 0 });
  const [longPressTimer, setLongPressTimer] = useState<NodeJS.Timeout | null>(null);
  const [showHints, setShowHints] = useState(true);

  // Hide hints after 5 seconds
  useEffect(() => {
    const timer = setTimeout(() => {
      setShowHints(false);
    }, 5000);
    return () => clearTimeout(timer);
  }, []);

  const handleLike = () => {
    setIsLiked(!isLiked);
    setLikes(isLiked ? likes - 1 : likes + 1);
  };

  const handleSendComment = () => {
    if (!newComment.trim()) return;
    
    setComments([
      ...comments,
      { 
        id: comments.length + 1, 
        user: 'You', 
        message: newComment, 
        avatar: 'https://i.pravatar.cc/150?img=10' 
      }
    ]);
    setNewComment('');
  };

  const handleSendGift = (gift: typeof availableGifts[0]) => {
    if (coinBalance < gift.price) {
      toast.error('Insufficient coins', {
        description: `You need ${gift.price - coinBalance} more coins to send this gift.`,
      });
      return;
    }

    // Deduct coins
    setCoinBalance(coinBalance - gift.price);

    // Add floating gift animation
    const newGift: FloatingGift = {
      id: `${Date.now()}-${Math.random()}`,
      emoji: gift.emoji,
      x: Math.random() * 60 + 20, // Random position between 20-80%
      y: 80,
    };
    setFloatingGifts([...floatingGifts, newGift]);

    // Remove gift after animation
    setTimeout(() => {
      setFloatingGifts((prev) => prev.filter((g) => g.id !== newGift.id));
    }, 3000);

    // Add gift message to comments
    setComments([
      ...comments,
      {
        id: comments.length + 1,
        user: 'You',
        message: `sent ${gift.emoji} ${gift.name}`,
        avatar: 'https://i.pravatar.cc/150?img=10',
      },
    ]);

    // Show success toast
    toast.success('Gift sent!', {
      description: `You sent ${gift.name} to Emma Rose`,
    });

    // Close gift panel
    setShowGifts(false);
  };

  const filteredGifts = availableGifts.filter((gift) => {
    if (selectedCategory === 'popular') return gift.price <= 500;
    if (selectedCategory === 'premium') return gift.price > 500;
    return true;
  });

  // Quick gifts for radial menu (top 6 popular gifts)
  const quickGifts = [
    availableGifts[0], // Rose
    availableGifts[9], // Heart
    availableGifts[1], // Diamond
    availableGifts[7], // Star
    availableGifts[8], // Fire
    availableGifts[10], // Party
  ];

  // Check if target is an interactive element
  const isInteractiveElement = (target: EventTarget | null): boolean => {
    if (!target || !(target instanceof Element)) return false;
    
    const tagName = target.tagName.toLowerCase();
    const interactiveTags = ['button', 'input', 'textarea', 'select', 'a'];
    
    // Check if element itself is interactive
    if (interactiveTags.includes(tagName)) return true;
    
    // Check if any parent is interactive (up to 5 levels)
    let parent = target.parentElement;
    let depth = 0;
    while (parent && depth < 5) {
      if (interactiveTags.includes(parent.tagName.toLowerCase())) return true;
      if (parent.getAttribute('role') === 'button') return true;
      parent = parent.parentElement;
      depth++;
    }
    
    return false;
  };

  // Handle screen tap (disabled double-tap feature)
  const handleScreenTap = (e: React.TouchEvent | React.MouseEvent) => {
    // Ignore if clicking on interactive elements
    if (isInteractiveElement(e.target)) {
      return;
    }
    // Double-tap feature disabled - only long-press is active
  };

  // Handle long press start
  const handlePressStart = (e: React.TouchEvent | React.MouseEvent) => {
    // Ignore if clicking on interactive elements
    if (isInteractiveElement(e.target)) {
      return;
    }

    const rect = e.currentTarget.getBoundingClientRect();
    const x = 'touches' in e ? e.touches[0].clientX - rect.left : (e as React.MouseEvent).clientX - rect.left;
    const y = 'touches' in e ? e.touches[0].clientY - rect.top : (e as React.MouseEvent).clientY - rect.top;

    const timer = setTimeout(() => {
      setRadialMenuPos({ x, y });
      setShowRadialMenu(true);
      
      // Haptic feedback (if available)
      if ('vibrate' in navigator) {
        navigator.vibrate(50);
      }
    }, 500); // 500ms long press

    setLongPressTimer(timer);
  };

  // Handle press end
  const handlePressEnd = (e: React.TouchEvent | React.MouseEvent) => {
    // Ignore if clicking on interactive elements
    if (isInteractiveElement(e.target)) {
      return;
    }

    if (longPressTimer) {
      clearTimeout(longPressTimer);
      setLongPressTimer(null);
    }
  };

  // Handle radial gift selection
  const handleQuickGiftSelect = (gift: typeof availableGifts[0]) => {
    handleSendGift(gift);
    setShowRadialMenu(false);
  };

  return (
    <PageTransition>
      <div className="relative h-[812px] bg-black overflow-hidden">
        {/* Background video (simulated with image) */}
        <div className="absolute inset-0">
          <img
            src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=800"
            alt="Live stream"
            className="w-full h-full object-cover"
          />
          <div className="absolute inset-0 bg-gradient-to-b from-black/40 via-transparent to-black/60" />
        </div>

        {/* Interactive touch layer for gestures */}
        <div 
          className="absolute inset-0 z-20 pointer-events-none"
          onClick={handleScreenTap}
          onTouchStart={handlePressStart}
          onTouchEnd={handlePressEnd}
          onMouseDown={handlePressStart}
          onMouseUp={handlePressEnd}
          onMouseLeave={handlePressEnd}
          style={{ touchAction: 'manipulation', pointerEvents: 'auto' }}
        />

        {/* Top bar */}
        <div className="relative z-30 px-4 pt-12 pb-4 flex items-center justify-between pointer-events-auto">
          <div className="flex items-center gap-3">
            <img
              src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200"
              alt="Streamer"
              className="w-12 h-12 rounded-full border-2 border-white"
            />
            <div>
              <p className="text-white">Emma Rose</p>
              <div className="flex items-center gap-2 text-xs text-white/80">
                <Eye className="w-3 h-3" />
                <span>2.3K</span>
              </div>
            </div>
          </div>
          
          <button
            onClick={() => navigate(-1)}
            className="w-10 h-10 bg-black/40 backdrop-blur-sm rounded-full flex items-center justify-center"
          >
            <X className="w-6 h-6 text-white" />
          </button>
        </div>

        {/* Comments overlay */}
        <div className="absolute bottom-40 left-4 right-20 z-30 pointer-events-none">
          <div className="space-y-2">
            <AnimatePresence>
              {comments.slice(-3).map((comment) => (
                <motion.div
                  key={comment.id}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0 }}
                  className="bg-black/40 backdrop-blur-md rounded-2xl px-3 py-2 max-w-[240px]"
                >
                  <div className="flex items-start gap-2">
                    <img
                      src={comment.avatar}
                      alt={comment.user}
                      className="w-6 h-6 rounded-full flex-shrink-0"
                    />
                    <div className="flex-1 min-w-0">
                      <p className="text-xs text-[#FF2D92]">{comment.user}</p>
                      <p className="text-sm text-white break-words">{comment.message}</p>
                    </div>
                  </div>
                </motion.div>
              ))}
            </AnimatePresence>
          </div>
        </div>

        {/* Right side buttons */}
        <div className="absolute right-3 bottom-28 z-30 flex flex-col gap-3 pointer-events-auto">
          <button
            onClick={() => setShowGifts(true)}
            className="w-12 h-12 bg-black/40 backdrop-blur-md rounded-full flex flex-col items-center justify-center"
          >
            <Gift className="w-5 h-5 text-white" />
          </button>
          
          <button
            onClick={handleLike}
            className="w-12 h-12 bg-black/40 backdrop-blur-md rounded-full flex flex-col items-center justify-center relative"
          >
            <Heart className={`w-5 h-5 ${isLiked ? 'fill-[#FF2D92] text-[#FF2D92]' : 'text-white'}`} />
            <span className="text-[10px] text-white absolute -bottom-4">{likes >= 1000 ? `${(likes / 1000).toFixed(1)}K` : likes}</span>
          </button>
          
          <button className="w-12 h-12 bg-black/40 backdrop-blur-md rounded-full flex flex-col items-center justify-center mt-2">
            <MessageCircle className="w-5 h-5 text-white" />
          </button>

          <button className="w-12 h-12 bg-black/40 backdrop-blur-md rounded-full flex items-center justify-center">
            <MoreVertical className="w-5 h-5 text-white" />
          </button>
        </div>

        {/* Bottom section with gift bar and input */}
        <div className="absolute bottom-0 left-0 right-0 z-30 bg-gradient-to-t from-black/95 via-black/80 to-transparent px-4 py-3 pb-6 pointer-events-auto">
          {/* Quick gift bar */}
          <div className="mb-3 relative">
            <div className="flex items-center gap-2 overflow-x-auto scrollbar-hide pb-1" style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}>
              {/* Gift bar label */}
              <div className="flex-shrink-0 flex items-center gap-1.5 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-full px-3 py-1.5 mr-1">
                <Sparkles className="w-3.5 h-3.5 text-white" />
                <span className="text-[10px] text-white">Quick Send</span>
              </div>

              {/* Scrollable gift items */}
              {availableGifts.map((gift) => {
                const canAfford = coinBalance >= gift.price;
                return (
                  <motion.button
                    key={gift.id}
                    whileTap={{ scale: canAfford ? 0.85 : 1 }}
                    onClick={() => canAfford && handleSendGift(gift)}
                    disabled={!canAfford}
                    className={`flex-shrink-0 flex items-center gap-1.5 rounded-full px-2.5 py-1.5 transition-all border ${
                      canAfford
                        ? 'bg-white/10 backdrop-blur-md border-white/20 hover:bg-white/20 hover:border-white/40 cursor-pointer'
                        : 'bg-white/5 border-white/5 opacity-40 cursor-not-allowed'
                    }`}
                  >
                    <span className="text-xl">{gift.emoji}</span>
                    <div className="flex items-center gap-0.5">
                      <Coins className="w-3 h-3 text-[#FFD700]" />
                      <span className="text-[10px] text-white/80">{gift.price}</span>
                    </div>
                  </motion.button>
                );
              })}

              {/* View all button */}
              <button
                onClick={() => setShowGifts(true)}
                className="flex-shrink-0 flex items-center gap-1 bg-white/10 backdrop-blur-md border border-white/20 rounded-full px-3 py-1.5 hover:bg-white/20 transition-all ml-1"
              >
                <Gift className="w-3.5 h-3.5 text-white" />
                <span className="text-[10px] text-white/80">All</span>
              </button>
            </div>

            {/* Fade effect on right edge */}
            <div className="absolute top-0 right-0 bottom-0 w-12 bg-gradient-to-l from-black/95 to-transparent pointer-events-none" />
          </div>

          {/* Comment input */}
          <div className="flex items-center gap-2">
            <div className="flex-1 relative">
              <input
                type="text"
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && handleSendComment()}
                placeholder="Say something nice..."
                className="w-full bg-white/10 backdrop-blur-md border border-white/20 rounded-full px-4 py-2.5 text-sm text-white placeholder:text-white/50 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20 outline-none"
              />
            </div>
            <button
              onClick={handleSendComment}
              className="w-11 h-11 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-full flex items-center justify-center shadow-[0_0_20px_rgba(199,0,255,0.5)] flex-shrink-0"
            >
              <MessageCircle className="w-5 h-5 text-white" />
            </button>
          </div>
        </div>

        {/* Floating gift animations */}
        <AnimatePresence>
          {floatingGifts.map((gift) => (
            <motion.div
              key={gift.id}
              initial={{ 
                x: `${gift.x}%`, 
                y: '100%',
                scale: 0.3,
                opacity: 0,
                rotate: -30,
              }}
              animate={{ 
                y: '-20%',
                scale: [0.3, 1.8, 1.2, 1.5, 0.8],
                opacity: [0, 1, 1, 1, 0],
                rotate: [0, 15, -15, 10, 0],
                x: [`${gift.x}%`, `${gift.x + 5}%`, `${gift.x - 3}%`, `${gift.x + 2}%`, `${gift.x}%`],
              }}
              exit={{ opacity: 0, scale: 0 }}
              transition={{ 
                duration: 3.5,
                ease: [0.34, 1.56, 0.64, 1],
                times: [0, 0.2, 0.5, 0.8, 1],
              }}
              className="absolute z-30 pointer-events-none"
              style={{ 
                fontSize: '64px',
                filter: 'drop-shadow(0 0 20px rgba(199, 0, 255, 0.6)) drop-shadow(0 0 40px rgba(255, 45, 146, 0.4))',
              }}
            >
              <motion.span
                animate={{
                  filter: [
                    'drop-shadow(0 0 10px rgba(199, 0, 255, 0.8))',
                    'drop-shadow(0 0 25px rgba(255, 45, 146, 1))',
                    'drop-shadow(0 0 15px rgba(199, 0, 255, 0.9))',
                  ],
                }}
                transition={{
                  duration: 0.8,
                  repeat: Infinity,
                  ease: 'easeInOut',
                }}
              >
                {gift.emoji}
              </motion.span>
            </motion.div>
          ))}
        </AnimatePresence>

        {/* Radial Quick Gift Menu */}
        <AnimatePresence>
          {showRadialMenu && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="absolute inset-0 z-40"
              onClick={() => setShowRadialMenu(false)}
            >
              <div
                className="absolute"
                style={{
                  left: radialMenuPos.x,
                  top: radialMenuPos.y,
                  transform: 'translate(-50%, -50%)',
                }}
              >
                {/* Center indicator */}
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-16 h-16 rounded-full bg-gradient-to-r from-[#C700FF] to-[#FF2D92] flex items-center justify-center shadow-[0_0_30px_rgba(199,0,255,0.8)]"
                >
                  <Sparkles className="w-8 h-8 text-white" />
                </motion.div>

                {/* Radial gift buttons */}
                {quickGifts.map((gift, index) => {
                  const angle = (index * 60) - 90; // 6 items in circle, starting from top
                  const radius = 85;
                  const x = Math.cos((angle * Math.PI) / 180) * radius;
                  const y = Math.sin((angle * Math.PI) / 180) * radius;
                  const canAfford = coinBalance >= gift.price;

                  return (
                    <motion.button
                      key={gift.id}
                      initial={{ scale: 0, opacity: 0 }}
                      animate={{ scale: 1, opacity: 1 }}
                      transition={{ delay: index * 0.05 }}
                      onClick={(e) => {
                        e.stopPropagation();
                        if (canAfford) {
                          handleQuickGiftSelect(gift);
                        }
                      }}
                      disabled={!canAfford}
                      className={`absolute w-14 h-14 rounded-full flex flex-col items-center justify-center backdrop-blur-xl border-2 transition-all ${
                        canAfford
                          ? 'bg-white/20 border-white/40 hover:scale-110 hover:border-white cursor-pointer'
                          : 'bg-white/5 border-white/10 opacity-40 cursor-not-allowed'
                      }`}
                      style={{
                        left: x,
                        top: y,
                        transform: 'translate(-50%, -50%)',
                      }}
                    >
                      <span className="text-2xl">{gift.emoji}</span>
                      <div className="absolute -bottom-1 -right-1 w-5 h-5 bg-black/80 rounded-full flex items-center justify-center">
                        <Coins className="w-3 h-3 text-[#FFD700]" />
                      </div>
                    </motion.button>
                  );
                })}

                {/* Instruction text */}
                <motion.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.3 }}
                  className="absolute top-[140px] left-1/2 -translate-x-1/2 whitespace-nowrap"
                >
                  <p className="text-xs text-white/80 bg-black/60 backdrop-blur-sm px-3 py-1.5 rounded-full">
                    Tap a gift to send
                  </p>
                </motion.div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Gift modal */}
        <AnimatePresence>
          {showGifts && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="absolute inset-0 z-50 bg-black/80 backdrop-blur-sm"
              onClick={() => setShowGifts(false)}
            >
              <motion.div
                initial={{ y: '100%' }}
                animate={{ y: 0 }}
                exit={{ y: '100%' }}
                transition={{ type: 'spring', damping: 30, stiffness: 300 }}
                className="absolute bottom-0 left-0 right-0 bg-gradient-to-b from-[#1A1A1F] to-[#0D0D0F] rounded-t-3xl max-h-[95vh] overflow-hidden"
                onClick={(e) => e.stopPropagation()}
              >
                {/* Handle */}
                <div className="w-12 h-1 bg-white/20 rounded-full mx-auto mt-3 mb-4" />
                
                {/* Header with balance */}
                <div className="px-6 pb-4 border-b border-white/10">
                  <div className="flex items-center justify-between mb-3">
                    <h3 className="text-white flex items-center gap-2">
                      <Gift className="w-5 h-5" />
                      Send a Gift
                    </h3>
                    <div className="flex items-center gap-2 px-3 py-1.5 bg-gradient-to-r from-[#C700FF]/20 to-[#FF2D92]/20 border border-white/10 rounded-full">
                      <Coins className="w-4 h-4 text-[#FFD700]" />
                      <span className="text-white text-sm">{coinBalance.toLocaleString()}</span>
                    </div>
                  </div>

                  {/* Category filters */}
                  <div className="flex gap-2">
                    <button
                      onClick={() => setSelectedCategory('all')}
                      className={`px-4 py-1.5 rounded-full text-sm transition-all ${
                        selectedCategory === 'all'
                          ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white'
                          : 'bg-white/5 text-white/60 hover:bg-white/10'
                      }`}
                    >
                      All
                    </button>
                    <button
                      onClick={() => setSelectedCategory('popular')}
                      className={`px-4 py-1.5 rounded-full text-sm transition-all ${
                        selectedCategory === 'popular'
                          ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white'
                          : 'bg-white/5 text-white/60 hover:bg-white/10'
                      }`}
                    >
                      Popular
                    </button>
                    <button
                      onClick={() => setSelectedCategory('premium')}
                      className={`px-4 py-1.5 rounded-full text-sm transition-all ${
                        selectedCategory === 'premium'
                          ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] text-white'
                          : 'bg-white/5 text-white/60 hover:bg-white/10'
                      }`}
                    >
                      <Sparkles className="w-3 h-3 inline mr-1" />
                      Premium
                    </button>
                  </div>
                </div>
                
                {/* Gifts grid */}
                <div className="px-6 py-4 overflow-y-auto max-h-[calc(70vh-180px)]">
                  <div className="grid grid-cols-4 gap-3">
                    {filteredGifts.map((gift) => {
                      const canAfford = coinBalance >= gift.price;
                      return (
                        <motion.button
                          key={gift.id}
                          whileTap={{ scale: canAfford ? 0.9 : 1 }}
                          onClick={() => handleSendGift(gift)}
                          disabled={!canAfford}
                          className={`aspect-square bg-white/5 border rounded-2xl flex flex-col items-center justify-center gap-1 p-2 transition-all ${
                            canAfford
                              ? 'border-white/10 hover:border-white/30 hover:bg-white/10 cursor-pointer'
                              : 'border-white/5 opacity-40 cursor-not-allowed'
                          }`}
                        >
                          <GiftIcon giftId={gift.id} size="md" animated={true} />
                          <span className="text-[10px] text-white/80 truncate w-full text-center px-1">
                            {gift.name}
                          </span>
                          <div className="flex items-center gap-0.5">
                            <Coins className="w-3 h-3 text-[#FFD700]" />
                            <span className="text-[10px] text-white/60">{gift.price}</span>
                          </div>
                        </motion.button>
                      );
                    })}
                  </div>

                  {/* Buy more coins link */}
                  <button
                    onClick={() => {
                      setShowGifts(false);
                      navigate('/gifts');
                    }}
                    className="w-full mt-4 py-3 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-2xl text-white flex items-center justify-center gap-2 shadow-[0_0_20px_rgba(199,0,255,0.4)]"
                  >
                    <Coins className="w-5 h-5" />
                    Buy More Coins
                  </button>
                </div>
              </motion.div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Gesture hints */}
        <AnimatePresence>
          {showHints && (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.5 }}
              className="absolute bottom-44 left-1/2 -translate-x-1/2 z-30 pointer-events-none"
            >
              <div className="bg-black/70 backdrop-blur-md px-4 py-2 rounded-full border border-white/20">
                <p className="text-xs text-white/90 text-center">
                  <span className="inline-block mr-1">💡</span>
                  Tap gifts below or long-press screen for quick menu
                </p>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* CSS for scrollbar hiding */}
        <style>{`
          .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
          }

          .scrollbar-hide::-webkit-scrollbar {
            display: none;
          }
        `}</style>
      </div>
    </PageTransition>
  );
}
