require 'facter'

  Facter.add(:vapp_puppetmaster) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /puppetmaster/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
