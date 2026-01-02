import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Wallet as WalletIcon, ArrowUpRight, ArrowDownLeft, TrendingUp } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import GradientButton from '../shared/GradientButton';
import { Card } from '../ui/card';

const transactions = [
  {
    id: '1',
    type: 'received',
    description: 'Gift from Alex Chen',
    amount: 200,
    date: '2024-11-02',
    time: '10:30 AM',
  },
  {
    id: '2',
    type: 'sent',
    description: 'Gift to Emma Rose',
    amount: -150,
    date: '2024-11-02',
    time: '09:15 AM',
  },
  {
    id: '3',
    type: 'earned',
    description: 'Stream earnings',
    amount: 850,
    date: '2024-11-01',
    time: '11:45 PM',
  },
  {
    id: '4',
    type: 'purchased',
    description: 'Coin purchase',
    amount: 1000,
    date: '2024-11-01',
    time: '08:20 PM',
  },
  {
    id: '5',
    type: 'sent',
    description: 'Gift to Sophie Lee',
    amount: -300,
    date: '2024-11-01',
    time: '06:00 PM',
  },
  {
    id: '6',
    type: 'received',
    description: 'Gift from Jake Wilson',
    amount: 500,
    date: '2024-10-31',
    time: '07:30 PM',
  },
];

const earningsData = [
  { day: 'Mon', amount: 450 },
  { day: 'Tue', amount: 620 },
  { day: 'Wed', amount: 850 },
  { day: 'Thu', amount: 730 },
  { day: 'Fri', amount: 920 },
  { day: 'Sat', amount: 1100 },
  { day: 'Sun', amount: 680 },
];

export default function Wallet() {
  const navigate = useNavigate();
  const [balance] = useState(5420);
  const [weeklyEarnings] = useState(5350);

  const maxEarning = Math.max(...earningsData.map((d) => d.amount));

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] overflow-y-auto">
        <div className="max-w-[430px] mx-auto pb-12">
          {/* Header */}
          <div className="sticky top-0 z-40 bg-[#0D0D0F]/95 backdrop-blur-lg border-b border-white/10 px-4 py-4">
            <div className="flex items-center justify-between">
              <button
                onClick={() => navigate(-1)}
                className="text-white/60"
              >
                <ChevronLeft className="w-6 h-6" />
              </button>
              <h2 className="text-white">Wallet & Earnings</h2>
              <div className="w-6" />
            </div>
          </div>

          {/* Balance card */}
          <div className="mx-4 mt-6">
            <div className="p-6 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-3xl">
              <div className="flex items-center gap-2 mb-2">
                <WalletIcon className="w-5 h-5 text-white" />
                <p className="text-white/80">Total Balance</p>
              </div>
              <p className="text-white text-3xl mb-6">{balance.toLocaleString()} 💰</p>
              
              <div className="flex gap-3">
                <GradientButton
                  variant="secondary"
                  glow={false}
                  className="flex-1 py-3"
                >
                  <ArrowDownLeft className="w-4 h-4 mr-2" />
                  Withdraw
                </GradientButton>
                <GradientButton
                  variant="secondary"
                  glow={false}
                  className="flex-1 py-3"
                  onClick={() => navigate('/gifts')}
                >
                  <ArrowUpRight className="w-4 h-4 mr-2" />
                  Add Coins
                </GradientButton>
              </div>
            </div>
          </div>

          {/* Weekly earnings */}
          <div className="mx-4 mt-6">
            <Card className="bg-white/5 border-white/10 p-5">
              <div className="flex items-center justify-between mb-4">
                <div>
                  <p className="text-white/60 text-sm">This Week's Earnings</p>
                  <p className="text-white text-2xl mt-1">
                    {weeklyEarnings.toLocaleString()} 💰
                  </p>
                </div>
                <div className="flex items-center gap-1 text-green-500">
                  <TrendingUp className="w-4 h-4" />
                  <span className="text-sm">+12%</span>
                </div>
              </div>

              {/* Simple bar chart */}
              <div className="flex items-end justify-between gap-2 h-32">
                {earningsData.map((data) => (
                  <div key={data.day} className="flex-1 flex flex-col items-center gap-2">
                    <div className="w-full relative">
                      <div
                        className="w-full bg-gradient-to-t from-[#C700FF] to-[#FF2D92] rounded-t-lg"
                        style={{ height: `${(data.amount / maxEarning) * 100}px` }}
                      />
                    </div>
                    <span className="text-xs text-white/60">{data.day}</span>
                  </div>
                ))}
              </div>
            </Card>
          </div>

          {/* Transaction history */}
          <div className="mx-4 mt-6">
            <h3 className="text-white mb-4">Transaction History</h3>
            
            <div className="space-y-2">
              {transactions.map((transaction) => (
                <Card
                  key={transaction.id}
                  className="bg-white/5 border-white/10 p-4"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-10 h-10 rounded-full flex items-center justify-center ${
                          transaction.amount > 0
                            ? 'bg-green-500/20'
                            : 'bg-red-500/20'
                        }`}
                      >
                        {transaction.amount > 0 ? (
                          <ArrowDownLeft className="w-5 h-5 text-green-500" />
                        ) : (
                          <ArrowUpRight className="w-5 h-5 text-red-500" />
                        )}
                      </div>
                      <div>
                        <p className="text-white">{transaction.description}</p>
                        <p className="text-sm text-white/60">
                          {transaction.date} • {transaction.time}
                        </p>
                      </div>
                    </div>
                    <p
                      className={`${
                        transaction.amount > 0 ? 'text-green-500' : 'text-red-500'
                      }`}
                    >
                      {transaction.amount > 0 ? '+' : ''}
                      {transaction.amount}
                    </p>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        </div>
      </div>
    </PageTransition>
  );
}
