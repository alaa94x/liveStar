import { useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ChevronLeft, Send, Heart, Gift, MoreVertical, Smile } from 'lucide-react';
import { motion } from 'motion/react';
import PageTransition from '../shared/PageTransition';

const mockMessages = [
  {
    id: 1,
    text: 'Hey! Thanks for joining my stream today! 💕',
    sender: 'them',
    time: '10:30 AM',
  },
  {
    id: 2,
    text: 'I loved it! You were amazing 🎉',
    sender: 'me',
    time: '10:32 AM',
  },
  {
    id: 3,
    text: 'Thank you so much! That means a lot to me ✨',
    sender: 'them',
    time: '10:33 AM',
  },
  {
    id: 4,
    text: 'When is your next stream?',
    sender: 'me',
    time: '10:35 AM',
  },
  {
    id: 5,
    text: 'Tomorrow at 8 PM! Hope to see you there 🎬',
    sender: 'them',
    time: '10:36 AM',
  },
];

export default function ChatConversation() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [messages, setMessages] = useState(mockMessages);
  const [newMessage, setNewMessage] = useState('');

  const handleSend = () => {
    if (!newMessage.trim()) return;

    setMessages([
      ...messages,
      {
        id: messages.length + 1,
        text: newMessage,
        sender: 'me',
        time: new Date().toLocaleTimeString('en-US', { 
          hour: 'numeric', 
          minute: '2-digit' 
        }),
      },
    ]);
    setNewMessage('');
  };

  return (
    <PageTransition>
      <div className="h-[812px] bg-[#0D0D0F] flex flex-col">
        <div className="max-w-[430px] mx-auto w-full flex flex-col h-full">
          {/* Header */}
          <div className="flex-shrink-0 bg-[#0D0D0F] border-b border-white/10 px-4 py-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <button
                  onClick={() => navigate(-1)}
                  className="text-white/60"
                >
                  <ChevronLeft className="w-6 h-6" />
                </button>
                
                <div className="relative">
                  <img
                    src="https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200"
                    alt="Emma Rose"
                    className="w-10 h-10 rounded-full object-cover"
                  />
                  <div className="absolute bottom-0 right-0 w-3 h-3 bg-green-500 rounded-full border-2 border-[#0D0D0F]" />
                </div>

                <div>
                  <p className="text-white">Emma Rose</p>
                  <p className="text-xs text-green-500">Online</p>
                </div>
              </div>

              <button className="text-white/60">
                <MoreVertical className="w-6 h-6" />
              </button>
            </div>
          </div>

          {/* Messages */}
          <div className="flex-1 overflow-y-auto px-4 py-6 space-y-4">
            {messages.map((message) => (
              <motion.div
                key={message.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className={`flex ${message.sender === 'me' ? 'justify-end' : 'justify-start'}`}
              >
                <div
                  className={`max-w-[75%] ${
                    message.sender === 'me'
                      ? 'bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-3xl rounded-br-lg'
                      : 'bg-white/10 rounded-3xl rounded-bl-lg'
                  } px-4 py-3`}
                >
                  <p className="text-white">{message.text}</p>
                  <p className="text-xs text-white/60 mt-1">{message.time}</p>
                </div>
              </motion.div>
            ))}
          </div>

          {/* Quick actions */}
          <div className="flex-shrink-0 px-4 py-2 flex items-center gap-3 border-t border-white/10">
            <button className="p-2 text-white/60 hover:text-[#FF2D92] transition-colors">
              <Heart className="w-6 h-6" />
            </button>
            <button className="p-2 text-white/60 hover:text-[#FF2D92] transition-colors">
              <Gift className="w-6 h-6" />
            </button>
          </div>

          {/* Input */}
          <div className="flex-shrink-0 px-4 py-4 bg-[#0D0D0F] border-t border-white/10">
            <div className="flex items-center gap-3">
              <button className="text-white/60">
                <Smile className="w-6 h-6" />
              </button>
              
              <input
                type="text"
                value={newMessage}
                onChange={(e) => setNewMessage(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && handleSend()}
                placeholder="Type a message..."
                className="flex-1 bg-white/5 border border-white/10 rounded-full px-4 py-3 text-white placeholder:text-white/40 focus:border-[#C700FF] focus:ring-2 focus:ring-[#C700FF]/20 outline-none"
              />
              
              <button
                onClick={handleSend}
                className="w-10 h-10 bg-gradient-to-r from-[#C700FF] to-[#FF2D92] rounded-full flex items-center justify-center shadow-[0_0_20px_rgba(199,0,255,0.5)]"
              >
                <Send className="w-5 h-5 text-white" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </PageTransition>
  );
}
