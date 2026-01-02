import { motion } from 'motion/react';
import { Eye } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

interface LiveCardProps {
  id: string;
  streamerName: string;
  streamerPhoto: string;
  thumbnail: string;
  title: string;
  viewerCount: number;
}

export default function LiveCard({ 
  id, 
  streamerName, 
  streamerPhoto, 
  thumbnail, 
  title, 
  viewerCount 
}: LiveCardProps) {
  const navigate = useNavigate();

  return (
    <motion.div
      whileTap={{ scale: 0.95 }}
      onClick={() => navigate(`/live/${id}`)}
      className="relative rounded-2xl overflow-hidden cursor-pointer"
    >
      <img 
        src={thumbnail} 
        alt={title}
        className="w-full aspect-[3/4] object-cover"
      />
      
      {/* Gradient overlay */}
      <div className="absolute inset-0 bg-gradient-to-b from-black/20 via-transparent to-black/60" />
      
      {/* Streamer photo */}
      <div className="absolute top-3 left-3">
        <img 
          src={streamerPhoto}
          alt={streamerName}
          className="w-10 h-10 rounded-full border-2 border-white/30"
        />
      </div>
      
      {/* Live badge and viewer count */}
      <div className="absolute top-3 right-3 flex items-center gap-2">
        <div className="px-2 py-1 bg-red-600 rounded-md flex items-center gap-1">
          <div className="w-2 h-2 bg-white rounded-full animate-pulse" />
          <span className="text-xs">LIVE</span>
        </div>
      </div>
      
      <div className="absolute top-14 right-3 bg-black/60 backdrop-blur-sm px-2 py-1 rounded-lg flex items-center gap-1">
        <Eye className="w-3 h-3" />
        <span className="text-xs">{viewerCount >= 1000 ? `${(viewerCount / 1000).toFixed(1)}K` : viewerCount}</span>
      </div>
      
      {/* Title */}
      <div className="absolute bottom-0 left-0 right-0 p-3">
        <p className="text-sm line-clamp-2">{title}</p>
      </div>
    </motion.div>
  );
}
