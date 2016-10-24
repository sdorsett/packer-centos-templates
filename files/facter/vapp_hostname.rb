require 'facter'

  Facter.add(:vapp_hostname) do
    output = `/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /hostname/ {print $4}'`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
