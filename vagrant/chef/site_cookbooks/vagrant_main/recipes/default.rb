include_recipe 'iis'

# Update default website
iis_pool 'DefaultAppPool' do
    thirty_two_bit :true
    action :restart
end

iis_site 'Default Web Site' do
    action [:stop, :delete]
end

iis_site 'DevSite' do
    protocol :http
    port 80
    path 'C:\Website'
    application_pool 'DefaultAppPool'
    action [:add, :start]
end

directory 'C:\Website' do
    rights :full_control, 'IIS APPPOOL\DefaultAppPool'
end