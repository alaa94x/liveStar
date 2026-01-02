import { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';
import { motion } from 'motion/react';
import GradientButton from '../shared/GradientButton';

export default function Verification() {
  const navigate = useNavigate();
  const [code, setCode] = useState(['', '', '', '']);
  const inputRefs = [
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
  ];

  useEffect(() => {
    inputRefs[0].current?.focus();
  }, []);

  const handleChange = (index: number, value: string) => {
    if (value.length > 1) return;
    
    const newCode = [...code];
    newCode[index] = value;
    setCode(newCode);

    // Auto-focus next input
    if (value && index < 3) {
      inputRefs[index + 1].current?.focus();
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent) => {
    if (e.key === 'Backspace' && !code[index] && index > 0) {
      inputRefs[index - 1].current?.focus();
    }
  };

  const handleVerify = () => {
    navigate('/interest');
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      className="h-full bg-gradient-to-b from-[#0D0D0F] via-[#1A0D26] to-[#0D0D0F] overflow-y-auto"
    >
      <div className="max-w-[430px] mx-auto px-6 py-12">
        {/* Header */}
        <button
          onClick={() => navigate(-1)}
          className="mb-8 text-white/60 flex items-center gap-2"
        >
          <ChevronLeft className="w-5 h-5" />
          Back
        </button>

        <div className="text-center mb-12">
          <h1 className="mb-2 text-white">Verification</h1>
          <p className="text-white/60">
            Enter the 4-digit code sent to your email
          </p>
        </div>

        {/* OTP inputs */}
        <div className="flex justify-center gap-4 mb-8">
          {code.map((digit, index) => (
            <input
              key={index}
              ref={inputRefs[index]}
              type="text"
              inputMode="numeric"
              maxLength={1}
              value={digit}
              onChange={(e) => handleChange(index, e.target.value)}
              onKeyDown={(e) => handleKeyDown(index, e)}
              className="w-16 h-16 bg-white/5 border-2 border-white/10 rounded-2xl text-center text-white text-2xl focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20 outline-none transition-all"
            />
          ))}
        </div>

        {/* Resend code */}
        <p className="text-center text-white/60 mb-8">
          Didn't receive the code?{' '}
          <button className="text-[#FF2D92] hover:underline">
            Resend code
          </button>
        </p>

        {/* Verify button */}
        <GradientButton
          onClick={handleVerify}
          disabled={code.some((digit) => !digit)}
          className="w-full disabled:opacity-50"
        >
          Verify
        </GradientButton>
      </div>
    </motion.div>
  );
}
