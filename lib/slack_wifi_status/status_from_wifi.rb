module SlackWifiStatus
  class StatusFromWifi
    def self.wifissid
      @wifissid ||= `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`.chomp
    end

    def self.ssid
      ssids[0].each do |value|
        if value.split(',')[0] == (wifissid)
          return value.split(',').drop(1)
        end
      end
      return ssids[1].first.split ',',2
    end

    def self.ssids
      return SlackWifiStatus::Config.config['ssids'], SlackWifiStatus::Config.config['unknown']
    end

    def self.status_hash
      message, emoji = ssid

      return { message: (message), emoji: (emoji) }
    end

    def self.set_status
      SlackWifiStatus::UpdateStatus.post(status_hash)
    end
  end
end
