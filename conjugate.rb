# accented chars for copying: é ú á í ñ ó
#
# Resources:
# http://www.spanishdict.com/answers/245763/glue-of-the-language-19-most-commonly-used-irregular-verbs-for-beginners-

require 'bundler/setup' 
require 'highline/import'

def regular_ar_verbs
  [
    ["alquilar", "to rent"],
    ["entrar", "to enter (into); entrar (en)"],
    ["necesitar", "to need"],
    ["amar", "to love"],
    ["olvidar", "to forget"],
    ["escuchar", "to listen to"],
    ["ayudar", "to help"],
    ["esperar", "to hope, to wait for, to expect"],
    ["bailar", "to dance"],
    ["estudiar", "to study"],
    ["preguntar", "to ask"],
    ["firmar", "to sign"],
    ["preparar", "to prepare"],
    ["caminar", "to walk"],
    ["ganar", "to win, earn"],
    ["regresar", "to return"],
    ["cantar", "to sing"],
    ["gastar", "to spend money"],
    ["saludar", "to greet"],
    ["cocinar", "to cook"],
    ["hablar", "to speak, to talk"],
    ["comprar", "to buy"],
    ["lavar", "to wash"],
    ["tomar", "to take, to drink"],
    ["contestar", "to answer"],
    ["trabajar", "to work"],
    ["dejar", "to allow, to leave"],
    ["llevar", "to wear, to carry, to take"],
    ["viajar", "to travel"],
    ["desear", "to desire"],
    ["mandar", "to order"],
    ["visitar", "to visit"],
    ["entrar", "to enter"],
    ["enseñar", "to teach"],
    ["mirar", "to watch, to look at"],
    ["limpiar", "to clean"],
    ["quedar", "to stay, to remain"],
    ["doblar", "to fold"],
    ["encantar", "to love, to bewitch"],
    ["pasar", "to pass"],
    ["reparar", "to repair, to fix"],
    ["desayunar", "to have breakfast"],
    ["descansar", "to rest"],
    ["gustar", "to like"],
    ["regalar", "to give"],
    ["cuidar", "to take care of, to look after"]
  ]
end

def regular_er_verbs
  [
    ["romper", "to break"],
    ["aprender", "to learn"],
    ["beber", "to drink"],
    ["deber", "to have to, to owe"],
    ["prometer", "to promise"],
    ["comer", "to eat"],
    ["esconder", "to hide"],
    ["comprender", "to understand"],
    ["temer", "to fear"],
    ["correr", "to run"],
    ["prender", "to turn on"],
    ["meter", "to put (into); meter (en)"],
    ["vender", "to sell"]
  ]
end

def regular_ir_verbs
  [
    ["abrir", "to open"],
    ["descubrir", "to discover"],
    ["permitir", "to permit"],
    ["compartir", "to share"],
    ["admitir", "to admit"],
    ["discutir", "to discuss"],
    ["recibir", "to receive"],
    ["asistir", "to attend; asistir (a)"],
    ["escribir", "to write"],
    ["subir", "to climb, to go up"],
    ["cubrir", "to cover"],
    ["existir", "to exist"],
    ["sufrir", "to suffer"],
    ["decidir", "to decide"],
    ["omitir", "to omit"],
    ["unir", "to unite"],
    ["describir", "to describe"],
    ["partir", "to divide"],
    ["vivir", "to live"]
  ]
end

def pronouns
  %W[yo tú él ella nosotros ellos ellas usted ustedes]
end

def pronoun_index(pronoun)
  [/yo/,/tú/,/él\z|ella\z|usted\z/,/nosotros/,/ellos|ellas|ustedes/].index { |p| p =~ pronoun }
end

def get_verb_ending_and_root(verb)
  verb_ending = /ar\z|er\z|ir\z/.match(verb)[0]
  root = verb.gsub(/#{verb_ending}\z/, '')
  return verb_ending, root
end

def conjugate_in_the_present_indicative(pronoun, verb)
  verb_ending, root = get_verb_ending_and_root(verb)
  case verb_ending
  when 'ar' then conjugate_ar_in_the_present_indicative(pronoun, root)
  when 'er' then conjugate_er_in_the_present_indicative(pronoun, root)
  when 'ir' then conjugate_ir_in_the_present_indicative(pronoun, root)
  end
end

def conjugate_ar_in_the_present_indicative(pronoun, root_of_verb)
  root_of_verb + %W[o as a amos an][pronoun_index(pronoun)]
end

def conjugate_er_in_the_present_indicative(pronoun, root_of_verb)
  root_of_verb + %W[o es e emos en][pronoun_index(pronoun)]
end

def conjugate_ir_in_the_present_indicative(pronoun, root_of_verb)
  root_of_verb + %W[o es e imos en][pronoun_index(pronoun)]
end

def conjugate_in_the_preterite(pronoun, verb)
  verb_ending, root = get_verb_ending_and_root(verb)
  if verb_ending == 'ar'
    conjugate_ar_in_the_preterite(pronoun, root)
  else # er and ir are the same
    conjugate_er_ir_in_the_preterite(pronoun, root)
  end
end

def conjugate_ar_in_the_preterite(pronoun, root_of_verb)
  root_of_verb + %W[é aste ó amos aron][pronoun_index(pronoun)]
end

def conjugate_er_ir_in_the_preterite(pronoun, root_of_verb)
  root_of_verb + %W[í iste ió imos ieron][pronoun_index(pronoun)]
end

def conjugate_in_the_imperfect(pronoun, verb)
  verb_ending, root = get_verb_ending_and_root(verb)
  if verb_ending == 'ar'
    conjugate_ar_in_the_imperfect(pronoun, root)
  else # er and ir are the same
    conjugate_er_ir_in_the_imperfect(pronoun, root)
  end
end

def conjugate_ar_in_the_imperfect(pronoun, root_of_verb)
  root_of_verb + %W[aba abas aba ábamos aban][pronoun_index(pronoun)]
end

def conjugate_er_ir_in_the_imperfect(pronoun, root_of_verb)
  root_of_verb + %W[ía ías ía íamos ían][pronoun_index(pronoun)]
end

method = nil
choose do |menu|
  menu.prompt = "Choose tense or quit."

  menu.choice(:present) { method = :conjugate_in_the_present_indicative }
  menu.choice(:preterite) { method = :conjugate_in_the_preterite }
  menu.choice(:imperfect) { method = :conjugate_in_the_imperfect }
  menu.choice(:quit) { exit }
end


puts "\nEnter q to quit or enter to proceed to next item\n\n"

do_not_quit = true
while do_not_quit
  pair = [regular_ar_verbs.sample, regular_er_verbs.sample, regular_ir_verbs.sample].sample
  pronoun = pronouns.sample

  puts "#{pronoun} / #{pair[0]}"
  entry = ask("> ")
  do_not_quit = entry != "q"
  puts "\n> " + send(method, pronoun, pair[0])
  puts "> #{pair[1]}\n\n"
end
