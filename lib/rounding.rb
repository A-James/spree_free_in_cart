class Numeric
  def roundup(nearest=10)
    self % nearest == 0 ? self : self + nearest - (self % nearest)
  end
  def rounddown(nearest=10)
    self % nearest == 0 ? self : self - (self % nearest)
  end

  def number_free
    # puts "=" * 80
    # (1..30).each do |i|
    #   foo = i.to_f - 1
    #   bar = (i.to_f/3).to_f - 1
    #   puts "Buy #{i} get #{foo.to_f-bar.to_f} free"
    # end

    return 0 if self == 1 or self == 0
    return 1 if self == 2

    foo = self.to_f - 1
    bar = (self.to_f/3).to_f - 1
    return (foo.to_f-bar.to_f).to_f.floor
    # puts "=" * 80
  end

end 
