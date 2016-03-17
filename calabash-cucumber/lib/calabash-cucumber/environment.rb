module Calabash
  module Cucumber
    module Environment

      # @!visibility private
      def self.xtc?
        RunLoop::Environment.xtc?
      end

      # @!visibility private
      def self.xcode
        return nil if self.xtc?
        @@xcode ||= RunLoop::Xcode.new
      end

      # @!visibility private
      def self.simctl
        return nil if self.xtc?
        @@simctl ||= RunLoop::SimControl.new
      end

      # @!visibility private
      def self.instruments
        return nil if self.xtc?
        @@instruments ||= RunLoop::Instruments.new
      end

      # @!visibility private
      def self.device_target
        value = RunLoop::Environment.device_target
        if value
          if value == "simulator"
            identifier = RunLoop::Core.default_simulator
          elsif value == "device"
            identifier = RunLoop::Core.detect_connected_device
          else
            identifier = value
          end
        else
          identifier = RunLoop::Core.default_simulator
        end

        identifier
      end

      # @!visibility private
      def self.device_endpoint
        value = RunLoop::Environment.device_endpoint
        if value
          value
        else
          DEFAULT_AUT_ENDPOINT
        end
      end

      # @!visibility private
      DEFAULT_AUT_ENDPOINT = "http://127.0.0.1:37265/"
    end
  end
end
