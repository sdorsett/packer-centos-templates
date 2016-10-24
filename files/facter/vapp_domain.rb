require 'facter'

  Facter.add(:vapp_domain) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /domain/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
