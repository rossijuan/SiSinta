# encoding: utf-8
class TipoDeEstructura < Lookup
  has_many :estructuras, inverse_of: :tipo
end
