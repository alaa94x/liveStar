import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Gift, Trophy, Target, Zap } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import GradientButton from '../shared/GradientButton';
import { Progress } from '../ui/progress';
import { Badge } from '../ui/badge';

const dailyRewards = [
  { day: 1, reward: 50, claimed: true },
  { day: 2, reward: 75, claimed: true },
  { day: 3, reward: 100, claimed: true },
  { day: 4, reward: 150, claimed: false, today: true },
  { day: 5, reward: 200, claimed: false },
  { day: 6, reward: 300, claimed: false },
  { day: 7, reward: 500, claimed: false },
];

const missions = [
  {
    id: '1',
    title: 'Go Live for 10 minutes',
    description: 'Stream for at least 10 minutes',
    progress: 7,
    total: 10,
    reward: 100,
    xp: 50,
    completed: false,
  },
  {
    id: '2',
    title: 'Send 5 gifts',
    description: 'Send gifts to other streamers',
    progress: 5,
    total: 5,
    reward: 50,
    xp: 25,
    completed: true,
  },
  {
    id: '3',
    title: 'Get 100 followers',
    description: 'Reach 100 followers',
    progress: 87,
    total: 100,
    reward: 200,
    xp: 100,
    completed: false,
  },
  {
    id: '4',
    title: 'Stream 3 days in a row',
    description: 'Maintain a streaming streak',
    progress: 2,
    total: 3,
    reward: 150,
    xp: 75,
    completed: false,
  },
];

export default function Rewards() {
  const navigate = useNavigate();
  const [currentLevel] = useState(12);
  const [currentXP] = useState(3250);
  const [nextLevelXP] = useState(4000);

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
              <h2 className="text-white">Rewards & Missions</h2>
              <div className="w-6" />
            </div>
          </div>

          {/* Level card */}
          <div className="mx-4 mt-6 p-6 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-3xl">
            <div className="flex items-center justify-between mb-4">
              <div>
                <p className="text-white/80 text-sm">Your Level</p>
                <div className="flex items-center gap-2 mt-1">
                  <Trophy className="w-6 h-6 text-white" />
                  <p className="text-white">Level {currentLevel}</p>
                </div>
              </div>
              <Badge className="bg-white/20 text-white border-0 px-3 py-1">
                Gold
              </Badge>
            </div>
            
            <div className="space-y-2">
              <div className="flex justify-between text-sm text-white">
                <span>{currentXP} XP</span>
                <span>{nextLevelXP} XP</span>
              </div>
              <Progress 
                value={(currentXP / nextLevelXP) * 100} 
                className="h-2 bg-white/20"
              />
              <p className="text-xs text-white/80 text-center">
                {nextLevelXP - currentXP} XP to next level
              </p>
            </div>
          </div>

          {/* Daily Rewards */}
          <div className="mx-4 mt-8">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-white flex items-center gap-2">
                <Gift className="w-5 h-5" />
                Daily Check-in
              </h3>
              <span className="text-sm text-white/60">Day 4/7</span>
            </div>

            <div className="grid grid-cols-7 gap-2">
              {dailyRewards.map((day) => (
                <div
                  key={day.day}
                  className={`aspect-square rounded-2xl p-2 flex flex-col items-center justify-center ${
                    day.claimed
                      ? 'bg-white/5 border border-white/10'
                      : day.today
                      ? 'bg-gradient-to-br from-[#C700FF] to-[#FF2D92] shadow-[0_0_20px_rgba(199,0,255,0.5)]'
                      : 'bg-white/5 border border-white/10'
                  }`}
                >
                  <p className="text-xs text-white/60 mb-1">Day {day.day}</p>
                  <p className="text-xs text-white">{day.reward}</p>
                  {day.claimed && (
                    <div className="mt-1 text-green-500">✓</div>
                  )}
                  {day.today && !day.claimed && (
                    <Zap className="w-3 h-3 text-white mt-1" />
                  )}
                </div>
              ))}
            </div>

            {!dailyRewards[3].claimed && (
              <GradientButton className="w-full mt-4">
                Claim Today's Reward
              </GradientButton>
            )}
          </div>

          {/* Missions */}
          <div className="mx-4 mt-8">
            <h3 className="text-white flex items-center gap-2 mb-4">
              <Target className="w-5 h-5" />
              Missions
            </h3>

            <div className="space-y-3">
              {missions.map((mission) => (
                <div
                  key={mission.id}
                  className={`p-4 rounded-2xl border ${
                    mission.completed
                      ? 'bg-green-500/10 border-green-500/30'
                      : 'bg-white/5 border-white/10'
                  }`}
                >
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex-1">
                      <p className="text-white">{mission.title}</p>
                      <p className="text-sm text-white/60 mt-1">
                        {mission.description}
                      </p>
                    </div>
                    {mission.completed && (
                      <Badge className="bg-green-500 text-white border-0">
                        Completed
                      </Badge>
                    )}
                  </div>

                  <div className="space-y-2">
                    <div className="flex justify-between text-sm text-white/80">
                      <span>
                        {mission.progress}/{mission.total}
                      </span>
                      <span>{Math.round((mission.progress / mission.total) * 100)}%</span>
                    </div>
                    <Progress
                      value={(mission.progress / mission.total) * 100}
                      className="h-2 bg-white/10"
                    />
                  </div>

                  <div className="flex items-center justify-between mt-3">
                    <div className="flex items-center gap-4 text-sm text-white/60">
                      <span>💰 {mission.reward} coins</span>
                      <span>⚡ {mission.xp} XP</span>
                    </div>
                    {mission.completed && (
                      <GradientButton className="px-4 py-2 text-sm">
                        Claim
                      </GradientButton>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </PageTransition>
  );
}
