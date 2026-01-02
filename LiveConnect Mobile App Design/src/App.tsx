import { BrowserRouter as Router, Routes, Route, useLocation, Navigate } from 'react-router-dom';
import { AnimatePresence } from 'motion/react';
import { Toaster } from './components/ui/sonner';
import PhoneFrame from './components/shared/PhoneFrame';
import Splash from './components/pages/Splash';
import Onboarding from './components/pages/Onboarding';
import Login from './components/pages/Login';
import SignUp from './components/pages/SignUp';
import Verification from './components/pages/Verification';
import Home from './components/pages/Home';
import Explore from './components/pages/Explore';
import LiveStream from './components/pages/LiveStream';
import GoLiveSetup from './components/pages/GoLiveSetup';
import Messages from './components/pages/Messages';
import ChatConversation from './components/pages/ChatConversation';
import Profile from './components/pages/Profile';
import GiftStore from './components/pages/GiftStore';
import Rewards from './components/pages/Rewards';
import Settings from './components/pages/Settings';
import Notifications from './components/pages/Notifications';
import Wallet from './components/pages/Wallet';
import BrandKit from './components/pages/BrandKit';
import Interest from './components/pages/Interest';

function AnimatedRoutes() {
  const location = useLocation();
  
  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/" element={<Splash />} />
        <Route path="/preview_page.html" element={<Navigate to="/" replace />} />
        <Route path="/onboarding" element={<Onboarding />} />
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/verification" element={<Verification />} />
        <Route path="/interest" element={<Interest />} />
        <Route path="/home" element={<Home />} />
        <Route path="/explore" element={<Explore />} />
        <Route path="/live/:id" element={<LiveStream />} />
        <Route path="/go-live" element={<GoLiveSetup />} />
        <Route path="/messages" element={<Messages />} />
        <Route path="/chat/:id" element={<ChatConversation />} />
        <Route path="/profile/:id?" element={<Profile />} />
        <Route path="/gifts" element={<GiftStore />} />
        <Route path="/rewards" element={<Rewards />} />
        <Route path="/settings" element={<Settings />} />
        <Route path="/notifications" element={<Notifications />} />
        <Route path="/wallet" element={<Wallet />} />
        <Route path="/brand-kit" element={<BrandKit />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </AnimatePresence>
  );
}

export default function App() {
  return (
    <Router>
      <PhoneFrame>
        <AnimatedRoutes />
      </PhoneFrame>
      <Toaster position="top-center" richColors />
    </Router>
  );
}
