require 'facter'

  Facter.add(:vapp_dns_servers) do
    command = (`/usr/sbin/vmtoolsd --cmd "info-get guestinfo.ovfEnv" | awk -F'\"' ' /dns_servers/ {print $4}'`).chomp
    output = []
    command.split(',').each { |entry| output << (entry.gsub(/\s+/, "")) }
    if output != []
      setcode do
        output.to_a
      end
    end
  end
