import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Coins, History } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import GradientButton from '../shared/GradientButton';
import GiftIcon from '../shared/GiftIcon';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '../ui/tabs';

const gifts = [
  { id: '1', emoji: '🌹', name: 'Rose', price: 50 },
  { id: '2', emoji: '💎', name: 'Diamond', price: 200 },
  { id: '3', emoji: '🚗', name: 'Sports Car', price: 500 },
  { id: '4', emoji: '🚀', name: 'Rocket', price: 1000 },
  { id: '5', emoji: '👑', name: 'Crown', price: 2000 },
  { id: '6', emoji: '🎁', name: 'Gift Box', price: 100 },
  { id: '7', emoji: '💰', name: 'Money Bag', price: 800 },
  { id: '8', emoji: '⭐', name: 'Star', price: 150 },
  { id: '9', emoji: '🔥', name: 'Fire', price: 300 },
  { id: '10', emoji: '💖', name: 'Heart', price: 80 },
  { id: '11', emoji: '🎉', name: 'Party', price: 120 },
  { id: '12', emoji: '🌈', name: 'Rainbow', price: 400 },
];

const coinPackages = [
  { id: '1', coins: 500, price: 4.99, bonus: 0 },
  { id: '2', coins: 1200, price: 9.99, bonus: 200 },
  { id: '3', coins: 2500, price: 19.99, bonus: 500 },
  { id: '4', coins: 6000, price: 49.99, bonus: 1500 },
];

const giftHistory = [
  {
    id: '1',
    type: 'sent',
    giftId: '2',
    gift: '💎',
    recipient: 'Emma Rose',
    amount: 200,
    date: '2 hours ago',
  },
  {
    id: '2',
    type: 'received',
    giftId: '1',
    gift: '🌹',
    sender: 'Alex Chen',
    amount: 50,
    date: '5 hours ago',
  },
  {
    id: '3',
    type: 'sent',
    giftId: '4',
    gift: '🚀',
    recipient: 'Sophie Lee',
    amount: 1000,
    date: '1 day ago',
  },
];

export default function GiftStore() {
  const navigate = useNavigate();
  const [selectedTab, setSelectedTab] = useState('gifts');
  const [coinBalance] = useState(3450);

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] overflow-y-auto">
        <div className="max-w-[430px] mx-auto">
          {/* Header */}
          <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10 px-4 py-4">
            <div className="flex items-center justify-between mb-4">
              <button
                onClick={() => navigate(-1)}
                className="text-white/60"
              >
                <ChevronLeft className="w-6 h-6" />
              </button>
              <h2 className="text-white">Gift Store</h2>
              <div className="w-6" />
            </div>

            {/* Coin balance */}
            <div className="bg-gradient-to-r from-[#C700FF]/20 to-[#FF2D92]/20 border border-white/10 rounded-2xl p-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <Coins className="w-6 h-6 text-[#FFD700]" />
                  <div>
                    <p className="text-sm text-white/60">Your Balance</p>
                    <p className="text-white">{coinBalance.toLocaleString()} Coins</p>
                  </div>
                </div>
                <GradientButton
                  onClick={() => setSelectedTab('coins')}
                  className="px-4 py-2 text-sm"
                >
                  Buy Coins
                </GradientButton>
              </div>
            </div>
          </div>

          {/* Tabs */}
          <Tabs value={selectedTab} onValueChange={setSelectedTab} className="mt-4">
            <TabsList className="w-full bg-transparent border-b border-white/10 rounded-none h-auto p-0 px-4">
              <TabsTrigger
                value="gifts"
                className="flex-1 data-[state=active]:text-white data-[state=active]:border-b-2 data-[state=active]:border-[#FF2D92] text-white/60 rounded-none pb-3"
              >
                Gifts
              </TabsTrigger>
              <TabsTrigger
                value="coins"
                className="flex-1 data-[state=active]:text-white data-[state=active]:border-b-2 data-[state=active]:border-[#FF2D92] text-white/60 rounded-none pb-3"
              >
                Coins
              </TabsTrigger>
              <TabsTrigger
                value="history"
                className="flex-1 data-[state=active]:text-white data-[state=active]:border-b-2 data-[state=active]:border-[#FF2D92] text-white/60 rounded-none pb-3"
              >
                History
              </TabsTrigger>
            </TabsList>

            {/* Gifts tab */}
            <TabsContent value="gifts" className="px-4 py-6">
              <div className="grid grid-cols-3 gap-4">
                {gifts.map((gift) => (
                  <button
                    key={gift.id}
                    className="bg-white/5 border border-white/10 rounded-2xl p-4 hover:bg-white/10 transition-colors"
                  >
                    <div className="mb-2 flex items-center justify-center">
                      <GiftIcon giftId={gift.id} size="lg" animated={true} />
                    </div>
                    <p className="text-sm text-white mb-1">{gift.name}</p>
                    <div className="flex items-center justify-center gap-1">
                      <Coins className="w-3 h-3 text-[#FFD700]" />
                      <span className="text-xs text-white/60">{gift.price}</span>
                    </div>
                  </button>
                ))}
              </div>
            </TabsContent>

            {/* Coins tab */}
            <TabsContent value="coins" className="px-4 py-6">
              <div className="space-y-4">
                {coinPackages.map((pkg) => (
                  <div
                    key={pkg.id}
                    className="bg-white/5 border border-white/10 rounded-2xl p-5 hover:border-[#C700FF] transition-colors cursor-pointer"
                  >
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-3">
                        <Coins className="w-10 h-10 text-[#FFD700]" />
                        <div>
                          <p className="text-white">
                            {pkg.coins.toLocaleString()} Coins
                          </p>
                          {pkg.bonus > 0 && (
                            <p className="text-sm text-[#FF2D92]">
                              +{pkg.bonus} Bonus
                            </p>
                          )}
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-white">${pkg.price}</p>
                      </div>
                    </div>
                    <GradientButton className="w-full py-2">
                      Purchase
                    </GradientButton>
                  </div>
                ))}
              </div>
            </TabsContent>

            {/* History tab */}
            <TabsContent value="history" className="px-4 py-6">
              <div className="space-y-3">
                {giftHistory.map((item) => (
                  <div
                    key={item.id}
                    className="bg-white/5 border border-white/10 rounded-2xl p-4"
                  >
                    <div className="flex items-center gap-3">
                      <div className="flex-shrink-0">
                        <GiftIcon giftId={item.giftId} size="md" animated={true} />
                      </div>
                      <div className="flex-1">
                        <p className="text-white">
                          {item.type === 'sent' ? 'Sent to' : 'Received from'}{' '}
                          {item.type === 'sent' ? item.recipient : item.sender}
                        </p>
                        <div className="flex items-center gap-2 mt-1">
                          <Coins className="w-3 h-3 text-[#FFD700]" />
                          <span className="text-sm text-white/60">
                            {item.amount} coins
                          </span>
                          <span className="text-sm text-white/40">•</span>
                          <span className="text-sm text-white/40">{item.date}</span>
                        </div>
                      </div>
                      <div
                        className={`text-sm ${
                          item.type === 'sent' ? 'text-red-400' : 'text-green-400'
                        }`}
                      >
                        {item.type === 'sent' ? '-' : '+'}
                        {item.amount}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </TabsContent>
          </Tabs>
        </div>
      </div>
    </PageTransition>
  );
}
