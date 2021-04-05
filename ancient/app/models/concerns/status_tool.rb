module StatusTool

  extend ActiveSupport::Concern

  def h(sym)
    v = self.send(sym.to_s)
    "#{self.class.name}::#{sym.to_s.classify.upcase}".constantize[v]
  end

  module ClassMethods

  end
end