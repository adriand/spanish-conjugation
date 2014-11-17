# accented chars for copying: é ú á í ñ
require 'bundler/setup' 
require 'highline/import'

def pronouns
  [
    'yo',
    'tú',
    'él',
    'ella',
    'nosotros',
    'ellos',
    'ellas',
    'usted',
    'ustedes'
  ]
end

def regular_ar_verbs
  [
    ["alquilar", "to rent"],
    ["entrar", "to enter (into); entrar (en)"],
    ["necesitar", "to need"],
    ["amar", "to love"],
    ["enviar", "to send"],
    ["olvidar", "to forget"],
    ["andar", "to walk"],
    ["escuchar", "to listen to"],
    ["pagar", "to pay for"],
    ["ayudar", "to help"],
    ["esperar", "to hope, to wait for, to expect"],
    ["practicar", "to practice"],
    ["bailar", "to dance"],
    ["estudiar", "to study"],
    ["preguntar", "to ask"],
    ["buscar", "to look for"],
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
    ["tocar", "to touch, to play an instrument"],
    ["comprar", "to buy"],
    ["lavar", "to wash"],
    ["tomar", "to take, to drink"],
    ["contestar", "to answer"],
    ["llegar", "to arrive"],
    ["trabajar", "to work"],
    ["dejar", "to allow, to leave"],
    ["llevar", "to wear, to carry"],
    ["viajar", "to travel"],
    ["desear", "to desire"],
    ["mandar", "to order"],
    ["visitar", "to visit"],
    ["enseñar", "to teach"],
    ["mirar", "to watch, to look at"]
  ]
end

def regular_er_verbs
  [
    ["romper", "to break"],
    ["aprender", "to learn"],
    ["creer", "to believe"],
    ["poseer", "to possess, to own"],
    ["beber", "to drink"],
    ["deber", "to have to, to owe"],
    ["prometer", "to promise"],
    ["comer", "to eat"],
    ["esconder", "to hide"],
    ["comprender", "to understand"],
    ["leer", "to read"],
    ["temer", "to fear"],
    ["correr", "to run"],
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
    ["asistir a", "to attend"],
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

def conjugate_regular_verb(pronoun, verb)
  verb_ending = /ar\z|er\z|ir\z/.match(verb)[0]
  root = verb.gsub(verb_ending, '')
  case verb_ending
  when 'ar' then conjugate_regular_ar_verb(pronoun, root)
  when 'er' then conjugate_regular_er_verb(pronoun, root)
  when 'ir' then conjugate_regular_ir_verb(pronoun, root)
  end
end

# these could be DRYed out rather easily
def conjugate_regular_ar_verb(pronoun, root_of_verb)
  case pronoun
  when 'yo' then "#{root_of_verb}o"
  when 'tú' then "#{root_of_verb}as"
  when /él\z|ella\z|usted\z/ then "#{root_of_verb}a"
  when 'nosotros' then "#{root_of_verb}amos"
  when /ellos|ellas|ustedes/ then "#{root_of_verb}an"
  end
end

def conjugate_regular_er_verb(pronoun, root_of_verb)
  case pronoun
  when 'yo' then "#{root_of_verb}o"
  when 'tú' then "#{root_of_verb}es"
  when /él\z|ella\z|usted\z/ then "#{root_of_verb}e"
  when 'nosotros' then "#{root_of_verb}emos"
  when /ellos|ellas|ustedes/ then "#{root_of_verb}en"
  end
end

def conjugate_regular_ir_verb(pronoun, root_of_verb)
  case pronoun
  when 'yo' then "#{root_of_verb}o"
  when 'tú' then "#{root_of_verb}es"
  when /él\z|ella\z|usted\z/ then "#{root_of_verb}e"
  when 'nosotros' then "#{root_of_verb}imos"
  when /ellos|ellas|ustedes/ then "#{root_of_verb}en"
  end
end

while true
  pair = [regular_ar_verbs.sample, regular_er_verbs.sample, regular_ir_verbs.sample].sample
  pronoun = pronouns.sample

  puts "#{pronoun} / #{pair[0]}"
  ask("> ") { |q| q.echo = false }
  puts "> " + conjugate_regular_verb(pronoun, pair[0])
  puts "> #{pair[1]}\n\n"
end
