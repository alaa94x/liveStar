import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Heart, MessageCircle, Users, Gift, Video, Trash2 } from 'lucide-react';
import PageTransition from '../shared/PageTransition';
import { motion } from 'motion/react';

const notifications = [
  {
    id: '1',
    type: 'gift',
    icon: Gift,
    avatar: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
    user: 'Alex Chen',
    message: 'sent you a Diamond 💎',
    time: '5 minutes ago',
    read: false,
  },
  {
    id: '2',
    type: 'follow',
    icon: Users,
    avatar: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
    user: 'Sophie Lee',
    message: 'started following you',
    time: '1 hour ago',
    read: false,
  },
  {
    id: '3',
    type: 'like',
    icon: Heart,
    avatar: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
    user: 'Maya Kim',
    message: 'liked your stream',
    time: '2 hours ago',
    read: true,
  },
  {
    id: '4',
    type: 'comment',
    icon: MessageCircle,
    avatar: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
    user: 'Jake Wilson',
    message: 'commented on your stream',
    time: '3 hours ago',
    read: true,
  },
  {
    id: '5',
    type: 'live',
    icon: Video,
    avatar: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
    user: 'Emma Rose',
    message: 'is now live!',
    time: '5 hours ago',
    read: true,
  },
];

export default function Notifications() {
  const navigate = useNavigate();
  const [notificationsList, setNotificationsList] = useState(notifications);

  const handleDelete = (id: string) => {
    setNotificationsList(notificationsList.filter((n) => n.id !== id));
  };

  const markAllAsRead = () => {
    setNotificationsList(
      notificationsList.map((n) => ({ ...n, read: true }))
    );
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
              <h2 className="text-white">Notifications</h2>
              <button
                onClick={markAllAsRead}
                className="text-sm text-[#FF2D92]"
              >
                Mark all read
              </button>
            </div>
          </div>

          {/* Notifications list */}
          <div className="divide-y divide-white/5">
            {notificationsList.map((notification) => {
              const Icon = notification.icon;
              
              return (
                <motion.div
                  key={notification.id}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: 20 }}
                  className={`px-4 py-4 flex items-start gap-3 ${
                    !notification.read ? 'bg-[#C700FF]/5' : ''
                  }`}
                >
                  {/* Avatar with icon badge */}
                  <div className="relative flex-shrink-0">
                    <img
                      src={notification.avatar}
                      alt={notification.user}
                      className="w-12 h-12 rounded-full object-cover"
                    />
                    <div className={`absolute -bottom-1 -right-1 w-6 h-6 rounded-full flex items-center justify-center ${
                      notification.type === 'gift'
                        ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92]'
                        : notification.type === 'follow'
                        ? 'bg-blue-500'
                        : notification.type === 'like'
                        ? 'bg-red-500'
                        : notification.type === 'live'
                        ? 'bg-green-500'
                        : 'bg-purple-500'
                    }`}>
                      <Icon className="w-3 h-3 text-white" />
                    </div>
                  </div>

                  {/* Content */}
                  <div className="flex-1 min-w-0">
                    <p className="text-white">
                      <span>{notification.user}</span>{' '}
                      <span className="text-white/60">{notification.message}</span>
                    </p>
                    <p className="text-sm text-white/40 mt-1">
                      {notification.time}
                    </p>
                  </div>

                  {/* Delete button */}
                  <button
                    onClick={() => handleDelete(notification.id)}
                    className="flex-shrink-0 text-white/40 hover:text-red-500 transition-colors"
                  >
                    <Trash2 className="w-5 h-5" />
                  </button>

                  {/* Unread indicator */}
                  {!notification.read && (
                    <div className="flex-shrink-0 w-2 h-2 bg-[#FF2D92] rounded-full" />
                  )}
                </motion.div>
              );
            })}
          </div>

          {/* Empty state */}
          {notificationsList.length === 0 && (
            <div className="text-center py-20">
              <div className="w-16 h-16 bg-white/5 rounded-full flex items-center justify-center mx-auto mb-4">
                <Heart className="w-8 h-8 text-white/20" />
              </div>
              <p className="text-white/60">No notifications yet</p>
            </div>
          )}
        </div>
      </div>
    </PageTransition>
  );
}
