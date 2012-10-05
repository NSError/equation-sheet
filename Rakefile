desc 'Upload to teh webz'
task :upload do
  `rsync -avzh --delete --chmod=o=rx,g=rwx,u=rwx build/ fsdev.net:~/nserror.me/equation-sheet/`
end

desc 'Blow away the built site'
task :nuke do
  `rm -rf build`
end

desc 'Build a new.Site'
task :build do
  `middleman build`
end

desc 'Chain it together'
task :all => [ :nuke, :build, :upload ]
