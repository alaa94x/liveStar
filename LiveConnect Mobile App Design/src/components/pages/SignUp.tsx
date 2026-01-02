import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { User, Mail, Lock, ChevronLeft } from 'lucide-react';
import { motion } from 'motion/react';
import GradientButton from '../shared/GradientButton';
import { Input } from '../ui/input';
import { Checkbox } from '../ui/checkbox';

export default function SignUp() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    confirmPassword: '',
    agreeToTerms: false,
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    navigate('/verification');
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
          <h1 className="mb-2 text-white">Create Account</h1>
          <p className="text-white/60">Join the streaming community</p>
        </div>

        {/* Sign up form */}
        <form onSubmit={handleSubmit} className="space-y-5">
          {/* Name */}
          <div className="relative">
            <User className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
            <Input
              type="text"
              placeholder="Full name"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
            />
          </div>

          {/* Email */}
          <div className="relative">
            <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
            <Input
              type="email"
              placeholder="Email address"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
            />
          </div>

          {/* Password */}
          <div className="relative">
            <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
            <Input
              type="password"
              placeholder="Password"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
            />
          </div>

          {/* Confirm Password */}
          <div className="relative">
            <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
            <Input
              type="password"
              placeholder="Confirm password"
              value={formData.confirmPassword}
              onChange={(e) => setFormData({ ...formData, confirmPassword: e.target.value })}
              className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
            />
          </div>

          {/* Terms checkbox */}
          <div className="flex items-start gap-3">
            <Checkbox
              id="terms"
              checked={formData.agreeToTerms}
              onCheckedChange={(checked) =>
                setFormData({ ...formData, agreeToTerms: checked as boolean })
              }
              className="mt-1 border-white/30 data-[state=checked]:bg-gradient-to-r data-[state=checked]:from-[#C700FF] data-[state=checked]:to-[#FF2D92]"
            />
            <label htmlFor="terms" className="text-sm text-white/70 cursor-pointer">
              I agree to the{' '}
              <span className="text-[#FF2D92]">Terms of Service</span> and{' '}
              <span className="text-[#FF2D92]">Privacy Policy</span>
            </label>
          </div>

          {/* Continue button */}
          <GradientButton type="submit" className="w-full mt-8">
            Continue
          </GradientButton>
        </form>

        {/* Login link */}
        <p className="text-center mt-8 text-white/60">
          Already have an account?{' '}
          <button
            onClick={() => navigate('/login')}
            className="text-[#FF2D92] hover:underline"
          >
            Login
          </button>
        </p>
      </div>
    </motion.div>
  );
}
