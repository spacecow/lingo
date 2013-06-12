namespace :linker do
  desc "Save a map of symlinks"
  task :save_symlinks_map => :environment do
    Johan::Linker.save_symlinks_map
  end

  desc "Replace symlinks with their actual files"
  task :replace_symlinks => :environment do
    Johan::Linker.replace_symlinks
  end

  desc "Unlink symlinks and save to map file"
  task :pre_deploy => :environment do
    Johan::Linker.pre_deploy
  end

  desc "Link up symlinks again from map file"
  task :post_deploy => :environment do
    Johan::Linker.post_deploy
  end
end
