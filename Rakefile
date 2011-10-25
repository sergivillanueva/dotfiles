require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :clean_erb do
  Dir['*.erb'].each do |file|
    if File.exist? file.noerb
      system %Q{rm "#{file.noerb}"}
    end
  end
end

task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE .gitignore].include? file
    next if (file.match(/.erb$/) && (File.there? file.noerb)) #It was already generated
    if File.there?(File.join(ENV['HOME'], ".#{file.noerb}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.noerb}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(generate_file file)
    end
  end
end

class String
  def noerb
    self.sub('.erb','')
  end
end

class File
  def self.there? file
    exist?(file) || symlink?(file)
  end
end

def generate_file(file)
  if file =~ /.erb$/
    puts "generating #{file.noerb}"
    File.open(File.join(file.noerb), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  end
  return file.noerb
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file.noerb}"}
  link_file(generate_file(file))
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
