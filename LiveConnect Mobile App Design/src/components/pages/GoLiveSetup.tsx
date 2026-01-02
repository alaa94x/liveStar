import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Camera, Mic, Video, Lock, Globe } from 'lucide-react';
import GradientButton from '../shared/GradientButton';
import PageTransition from '../shared/PageTransition';
import { Input } from '../ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '../ui/select';
import { Switch } from '../ui/switch';

export default function GoLiveSetup() {
  const navigate = useNavigate();
  const [title, setTitle] = useState('');
  const [category, setCategory] = useState('');
  const [isPrivate, setIsPrivate] = useState(false);
  const [cameraOn, setCameraOn] = useState(true);
  const [micOn, setMicOn] = useState(true);

  const handleStartLive = () => {
    navigate('/live/my-stream');
  };

  return (
    <PageTransition>
      <div className="h-[812px] bg-gradient-to-b from-[#0D0D0F] via-[#1A0D26] to-[#0D0D0F] overflow-y-auto">
        <div className="max-w-[430px] mx-auto px-6 py-6">
          {/* Header */}
          <button
            onClick={() => navigate(-1)}
            className="mb-4 text-white/60 flex items-center gap-2"
          >
            <ChevronLeft className="w-5 h-5" />
            Back
          </button>

          <h1 className="text-white mb-4">Go Live</h1>

          {/* Camera preview */}
          <div className="relative h-64 bg-gradient-to-br from-purple-900/20 to-pink-900/20 rounded-3xl overflow-hidden mb-5 border border-white/10">
            <img
              src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400"
              alt="Camera preview"
              className="w-full h-full object-cover opacity-50"
            />
            
            {/* Camera controls overlay */}
            <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex items-center gap-4">
              <button
                onClick={() => setCameraOn(!cameraOn)}
                className={`w-12 h-12 rounded-full flex items-center justify-center transition-colors ${
                  cameraOn
                    ? 'bg-white/20 backdrop-blur-md'
                    : 'bg-red-600'
                }`}
              >
                <Video className="w-6 h-6 text-white" />
              </button>
              
              <button
                onClick={() => setMicOn(!micOn)}
                className={`w-12 h-12 rounded-full flex items-center justify-center transition-colors ${
                  micOn
                    ? 'bg-white/20 backdrop-blur-md'
                    : 'bg-red-600'
                }`}
              >
                <Mic className="w-6 h-6 text-white" />
              </button>
              
              <button className="w-12 h-12 bg-white/20 backdrop-blur-md rounded-full flex items-center justify-center">
                <Camera className="w-6 h-6 text-white" />
              </button>
            </div>
          </div>

          {/* Stream settings */}
          <div className="space-y-5 mb-8">
            {/* Title */}
            <div>
              <label className="block text-white/80 text-sm mb-2">
                Stream Title
              </label>
              <Input
                type="text"
                placeholder="What are you streaming?"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-2xl px-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
              />
            </div>

            {/* Category */}
            <div>
              <label className="block text-white/80 text-sm mb-2">
                Category
              </label>
              <Select value={category} onValueChange={setCategory}>
                <SelectTrigger className="w-full bg-white/5 border border-white/10 rounded-2xl px-4 py-6 text-white focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20">
                  <SelectValue placeholder="Choose a category" />
                </SelectTrigger>
                <SelectContent className="bg-[#1A1A1F] border-white/10">
                  <SelectItem value="chat">Just Chatting</SelectItem>
                  <SelectItem value="gaming">Gaming</SelectItem>
                  <SelectItem value="music">Music</SelectItem>
                  <SelectItem value="fashion">Fashion</SelectItem>
                  <SelectItem value="dance">Dance</SelectItem>
                  <SelectItem value="cooking">Cooking</SelectItem>
                </SelectContent>
              </Select>
            </div>

            {/* Privacy toggle */}
            <div className="flex items-center justify-between p-4 bg-white/5 border border-white/10 rounded-2xl">
              <div className="flex items-center gap-3">
                {isPrivate ? (
                  <Lock className="w-5 h-5 text-white/60" />
                ) : (
                  <Globe className="w-5 h-5 text-white/60" />
                )}
                <div>
                  <p className="text-white">
                    {isPrivate ? 'Private Stream' : 'Public Stream'}
                  </p>
                  <p className="text-xs text-white/60">
                    {isPrivate ? 'Only invited viewers can join' : 'Anyone can join'}
                  </p>
                </div>
              </div>
              <Switch
                checked={isPrivate}
                onCheckedChange={setIsPrivate}
                className="data-[state=checked]:bg-gradient-to-r data-[state=checked]:from-[#C700FF] data-[state=checked]:to-[#FF2D92]"
              />
            </div>
          </div>

          {/* Start button */}
          <GradientButton
            onClick={handleStartLive}
            disabled={!title || !category}
            className="w-full disabled:opacity-50"
          >
            Start Live Stream
          </GradientButton>
        </div>
      </div>
    </PageTransition>
  );
}
