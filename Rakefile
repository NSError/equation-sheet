require 'rake/clean'

TEXEN = FileList['*.tex']

%w{aux ps dvi log}.each { |ext| CLEAN.include "**/*.#{ext}" }
CLOBBER.include('eqnsheet.pdf')

rule('.dvi' => '.tex') { |tex_file| sh "latex #{tex_file.source}" }
rule('.ps' => '.dvi') { |dvi_file| sh "dvips #{dvi_file.source}" }
rule('.pdf' => '.ps') { |ps_file| sh "ps2pdf #{ps_file.source}" }

FileList['*.tex'].each do |tex_file|
  file tex_file.ext('.dvi') => tex_file
  file tex_file.ext('.ps' ) => tex_file.ext('.dvi')
  file tex_file.ext('.pdf') => tex_file.ext('.ps')
end

desc 'build my equation sheet'
task :'equation-sheet' => 'eqnsheet.pdf'

task :default => :'equation-sheet'
