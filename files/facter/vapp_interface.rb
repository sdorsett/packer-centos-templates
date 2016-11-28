require 'facter'

  Facter.add(:vapp_interface) do
    output = `ip a | grep mtu | grep -v lo | cut -d " " -f2 | cut -d ":" -f1`

    if output != "" && output != nil
      setcode do
        output.chomp
      end
    end
  end
