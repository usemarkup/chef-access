node['access']['users'].each do |name, value|
    # Create the user as group nobody to start with.. (jumpcloud fix)
    nobody_group_id = `id -g nobody`

    user_account name do
      comment       "#{name}"
      home          "/home/#{name}"
      ssh_keys      node['access']['keys']
      shell         "/bin/bash"
      create_group  false
      gid           nobody_group_id.delete("\n").to_i
    end

    group name do
        action :create
        group_name "#{name}"
        append true
        members ["#{name}"]
    end
end

node['access']['groups'].each do |user, groups|
    groups.each do |group|
        bash 'Create group if required' do
          code "groupadd -f #{group}"
        end
    end

    execute "User groups for #{user}" do
        groups = groups.join(',')
        command "usermod -G #{groups} #{user}"
        action :run
    end
end
