require 'facter'

  Facter.add(:vapp_ip_address) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /ip_address/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
