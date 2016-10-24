require 'facter'

  Facter.add(:vapp_netmask) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /netmask/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
