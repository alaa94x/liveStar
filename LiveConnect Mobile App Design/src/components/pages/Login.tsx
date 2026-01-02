import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Mail, Lock, Facebook } from 'lucide-react';
import { motion } from 'motion/react';
import GradientButton from '../shared/GradientButton';
import { Input } from '../ui/input';

export default function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    navigate('/home');
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
          <div className="text-center mb-12">
            <h1 className="mb-2 text-white">Welcome Back</h1>
            <p className="text-white/60">Login to continue streaming</p>
          </div>

          {/* Login form */}
          <form onSubmit={handleLogin} className="space-y-5">
            {/* Email */}
            <div className="relative">
              <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
              <Input
                type="email"
                placeholder="Email address"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
              />
            </div>

            {/* Password */}
            <div className="relative">
              <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/40" />
              <Input
                type="password"
                placeholder="Password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-2xl pl-12 pr-4 py-6 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20"
              />
            </div>

            {/* Forgot password */}
            <div className="text-right">
              <button
                type="button"
                className="text-sm text-[#FF2D92] hover:underline"
              >
                Forgot password?
              </button>
            </div>

            {/* Login button */}
            <GradientButton type="submit" className="w-full">
              Login
            </GradientButton>
          </form>

          {/* Divider */}
          <div className="flex items-center gap-4 my-8">
            <div className="flex-1 h-px bg-white/10" />
            <span className="text-white/40 text-sm">or continue with</span>
            <div className="flex-1 h-px bg-white/10" />
          </div>

          {/* Social login */}
          <div className="space-y-3">
            <button className="w-full bg-white/5 border border-white/10 rounded-2xl px-4 py-4 flex items-center justify-center gap-3 text-white hover:bg-white/10 transition-colors">
              <svg className="w-5 h-5" viewBox="0 0 24 24">
                <path
                  fill="currentColor"
                  d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                />
                <path
                  fill="currentColor"
                  d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                />
                <path
                  fill="currentColor"
                  d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                />
                <path
                  fill="currentColor"
                  d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                />
              </svg>
              Login with Google
            </button>

            <button className="w-full bg-white/5 border border-white/10 rounded-2xl px-4 py-4 flex items-center justify-center gap-3 text-white hover:bg-white/10 transition-colors">
              <Facebook className="w-5 h-5 fill-current" />
              Login with Facebook
            </button>
          </div>

          {/* Sign up link */}
          <p className="text-center mt-8 text-white/60">
            Don't have an account?{' '}
            <button
              onClick={() => navigate('/signup')}
              className="text-[#FF2D92] hover:underline"
            >
              Create Account
            </button>
          </p>
        </div>
      </motion.div>
  );
}
