module Jack
  class UI
    class << self
      @@mute = false
      def mute
        @@mute
      end
      def mute=(v)
        @@mute=v
      end
      def say(msg='')
        puts msg unless mute
      end
    end
  end
end