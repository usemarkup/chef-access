node['access']['sudo']['users'].each do |user, value|
    sudo "#{user}" do
      user     "#{user}"
      commands value['commands']
      nopasswd true
    end
end

node['access']['sudo']['groups'].each do |group, value|
    sudo "#{group}" do
      group value['group']
      commands value['commands']
      nopasswd true
      runas value['runas']
    end
end
