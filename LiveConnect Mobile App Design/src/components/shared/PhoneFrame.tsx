import { ReactNode } from 'react';

interface PhoneFrameProps {
  children: ReactNode;
}

export default function PhoneFrame({ children }: PhoneFrameProps) {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center p-8">
      {/* iPhone 16 Pro Max Frame */}
      <div className="relative">
        {/* Phone body */}
        <div className="relative bg-[#1a1a1a] rounded-[60px] p-3 shadow-2xl">
          {/* Screen bezel */}
          <div className="relative bg-black rounded-[50px] overflow-hidden shadow-inner">
            {/* Dynamic Island */}
            <div className="absolute top-0 left-1/2 -translate-x-1/2 z-50 bg-black rounded-full w-[126px] h-[37px] mt-2" />
            
            {/* Screen content */}
            <div className="relative w-[375px] h-[812px] bg-[#0D0D0F] overflow-hidden">
              {children}
            </div>
          </div>
          
          {/* Side buttons */}
          {/* Volume buttons */}
          <div className="absolute left-0 top-[180px] w-1 h-12 bg-[#2a2a2a] rounded-l-sm -ml-1" />
          <div className="absolute left-0 top-[240px] w-1 h-12 bg-[#2a2a2a] rounded-l-sm -ml-1" />
          
          {/* Power button */}
          <div className="absolute right-0 top-[220px] w-1 h-16 bg-[#2a2a2a] rounded-r-sm -mr-1" />
        </div>
        
        {/* Reflection effect */}
        <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent rounded-[60px] pointer-events-none" />
      </div>
    </div>
  );
}
