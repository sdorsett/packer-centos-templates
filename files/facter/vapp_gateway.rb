require 'facter'

  Facter.add(:vapp_gateway) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /gateway/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
