module StringMethods
  def is_upper?
    not self.match /[[:lower:]]/
  end

  def is_lower?
    not self.match /[[:upper:]]/
  end
end

String.include StringMethods
