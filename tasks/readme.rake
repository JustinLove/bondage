file "README.rdoc" => %w{
    description.rdoc
    frag/synopsis_header.rdoc
    synopsis.rb
    frag/misc.rdoc
    LICENSE.txt} do |t|
  sh "cat #{t.prerequisites.join(' ')} > #{t.name}"
end