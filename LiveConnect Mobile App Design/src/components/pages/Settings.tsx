import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { 
  ChevronLeft, 
  User, 
  Bell, 
  Shield, 
  Globe, 
  HelpCircle, 
  Info,
  LogOut,
  ChevronRight,
  Moon,
  Volume2,
  Palette
} from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import { Switch } from '../ui/switch';
import { Separator } from '../ui/separator';

const settingsSections = [
  {
    title: 'Account',
    items: [
      { icon: User, label: 'Edit Profile', path: '/profile', hasToggle: false },
      { icon: Bell, label: 'Notifications', hasToggle: true, enabled: true },
      { icon: Volume2, label: 'Sound Effects', hasToggle: true, enabled: true },
    ],
  },
  {
    title: 'Privacy & Security',
    items: [
      { icon: Shield, label: 'Privacy Settings', path: '/privacy', hasToggle: false },
      { icon: User, label: 'Blocked Users', path: '/blocked', hasToggle: false },
    ],
  },
  {
    title: 'Preferences',
    items: [
      { icon: Globe, label: 'Language', value: 'English', hasToggle: false },
      { icon: Moon, label: 'Dark Mode', hasToggle: true, enabled: true },
    ],
  },
  {
    title: 'Support',
    items: [
      { icon: HelpCircle, label: 'Help Center', path: '/help', hasToggle: false },
      { icon: Info, label: 'About', path: '/about', hasToggle: false },
      { icon: Palette, label: 'Brand Kit', path: '/brand-kit', hasToggle: false },
    ],
  },
];

export default function Settings() {
  const navigate = useNavigate();
  const [toggleStates, setToggleStates] = useState({
    notifications: true,
    soundEffects: true,
    darkMode: true,
  });

  const handleToggle = (key: string) => {
    setToggleStates((prev) => ({ ...prev, [key]: !prev[key as keyof typeof toggleStates] }));
  };

  const handleLogout = () => {
    navigate('/login');
  };

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
              <h2 className="text-white">Settings</h2>
              <div className="w-6" />
            </div>
          </div>

          {/* Profile summary */}
          <div className="px-4 py-6">
            <div className="flex items-center gap-4 p-4 bg-white/5 border border-white/10 rounded-2xl">
              <img
                src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200"
                alt="Profile"
                className="w-16 h-16 rounded-full object-cover"
              />
              <div className="flex-1">
                <p className="text-white">Emma Rose</p>
                <p className="text-sm text-white/60">emma.rose@email.com</p>
              </div>
              <button onClick={() => navigate('/profile')}>
                <ChevronRight className="w-5 h-5 text-white/40" />
              </button>
            </div>
          </div>

          {/* Settings sections */}
          <div className="px-4 space-y-6">
            {settingsSections.map((section, sectionIndex) => (
              <div key={sectionIndex}>
                <h3 className="text-white/60 text-sm mb-3 px-2">
                  {section.title}
                </h3>
                <div className="bg-white/5 border border-white/10 rounded-2xl overflow-hidden">
                  {section.items.map((item, itemIndex) => {
                    const Icon = item.icon;
                    const toggleKey = item.label.toLowerCase().replace(/ /g, '');
                    
                    return (
                      <div key={itemIndex}>
                        {item.hasToggle ? (
                          <div className="w-full px-4 py-4 flex items-center justify-between">
                            <div className="flex items-center gap-3">
                              <Icon className="w-5 h-5 text-white/60" />
                              <span className="text-white">{item.label}</span>
                            </div>
                            
                            <div className="flex items-center gap-2">
                              {item.value && (
                                <span className="text-sm text-white/60">
                                  {item.value}
                                </span>
                              )}
                              <Switch
                                checked={toggleStates[toggleKey as keyof typeof toggleStates]}
                                onCheckedChange={() => handleToggle(toggleKey)}
                                className="data-[state=checked]:bg-gradient-to-r data-[state=checked]:from-[#C700FF] data-[state=checked]:to-[#FF2D92]"
                              />
                            </div>
                          </div>
                        ) : (
                          <button
                            onClick={() => item.path && navigate(item.path)}
                            className="w-full px-4 py-4 flex items-center justify-between hover:bg-white/5 transition-colors"
                          >
                            <div className="flex items-center gap-3">
                              <Icon className="w-5 h-5 text-white/60" />
                              <span className="text-white">{item.label}</span>
                            </div>
                            
                            <div className="flex items-center gap-2">
                              {item.value && (
                                <span className="text-sm text-white/60">
                                  {item.value}
                                </span>
                              )}
                              <ChevronRight className="w-5 h-5 text-white/40" />
                            </div>
                          </button>
                        )}
                        {itemIndex < section.items.length - 1 && (
                          <Separator className="bg-white/5" />
                        )}
                      </div>
                    );
                  })}
                </div>
              </div>
            ))}
          </div>

          {/* Logout button */}
          <div className="px-4 mt-8">
            <button
              onClick={handleLogout}
              className="w-full px-4 py-4 bg-red-500/10 border border-red-500/30 rounded-2xl flex items-center justify-center gap-3 text-red-500 hover:bg-red-500/20 transition-colors"
            >
              <LogOut className="w-5 h-5" />
              Logout
            </button>
          </div>

          {/* App version */}
          <p className="text-center text-white/40 text-sm mt-8">
            LiveConnect v1.0.0
          </p>
        </div>
      </div>
    </PageTransition>
  );
}
