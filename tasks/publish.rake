task :publish => [:redocs]  do |t|
  target = File.expand_path '~/files/web/wml/gems/bondage'
  rm_r(target) if File.exist?(target)
  mv 'doc', target
end
